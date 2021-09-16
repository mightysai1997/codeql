private import python
private import semmle.python.Concepts
private import semmle.python.ApiGraphs
private import semmle.python.dataflow.new.DataFlow
private import semmle.python.dataflow.new.RemoteFlowSources

/**
 * A data flow source of the client ip obtained according to the remote endpoint identifier specified
 * (`X-Forwarded-For`, `X-Real-IP`, `Proxy-Client-IP`, etc.) in the header.
 *
 * For example: `request.headers.get("X-Forwarded-For")`.
 */
abstract class ClientSuppliedIpUsedInSecurityCheck extends DataFlow::CallCfgNode { }

private class FlaskClientSuppliedIpUsedInSecurityCheck extends ClientSuppliedIpUsedInSecurityCheck {
  FlaskClientSuppliedIpUsedInSecurityCheck() {
    this =
      API::moduleImport("flask")
          .getMember("request")
          .getMember("headers")
          .getMember(["get", "get_all", "getlist"])
          .getACall() and
    this.getArg(0).asCfgNode().getNode().(StrConst).getText().toLowerCase() =
      clientIpParameterName()
  }
}

private class DjangoClientSuppliedIpUsedInSecurityCheck extends ClientSuppliedIpUsedInSecurityCheck {
  DjangoClientSuppliedIpUsedInSecurityCheck() {
    exists(RemoteFlowSource rfs, DataFlow::LocalSourceNode lsn |
      rfs.getSourceType() = "django.http.request.HttpRequest" and rfs.asCfgNode() = lsn.asCfgNode()
    |
      lsn.flowsTo(DataFlow::exprNode(this.getFunction()
              .asExpr()
              .(Attribute)
              .getObject()
              .(Attribute)
              .getObject())) and
      this.getFunction().asExpr().(Attribute).getName() = "get" and
      this.getFunction().asExpr().(Attribute).getObject().(Attribute).getName() in [
          "headers", "META"
        ] and
      this.getArg(0).asCfgNode().getNode().(StrConst).getText().toLowerCase() =
        clientIpParameterName()
    )
  }
}

private class TornadoClientSuppliedIpUsedInSecurityCheck extends ClientSuppliedIpUsedInSecurityCheck {
  TornadoClientSuppliedIpUsedInSecurityCheck() {
    exists(RemoteFlowSource rfs, DataFlow::LocalSourceNode lsn |
      rfs.getSourceType() = "tornado.web.RequestHandler" and rfs.asCfgNode() = lsn.asCfgNode()
    |
      lsn.flowsTo(DataFlow::exprNode(this.getFunction()
              .asExpr()
              .(Attribute)
              .getObject()
              .(Attribute)
              .getObject()
              .(Attribute)
              .getObject())) and
      this.getFunction().asExpr().(Attribute).getName() in ["get", "get_list"] and
      this.getFunction().asExpr().(Attribute).getObject().(Attribute).getName() = "headers" and
      this.getArg(0).asCfgNode().getNode().(StrConst).getText().toLowerCase() =
        clientIpParameterName()
    )
  }
}

private string clientIpParameterName() {
  result in [
      "x-forwarded-for", "x_forwarded_for", "x-real-ip", "x_real_ip", "proxy-client-ip",
      "proxy_client_ip", "wl-proxy-client-ip", "wl_proxy_client_ip", "http_x_forwarded_for",
      "http-x-forwarded-for", "http_x_forwarded", "http_x_cluster_client_ip", "http_client_ip",
      "http_forwarded_for", "http_forwarded", "http_via", "remote_addr"
    ]
}

/** A data flow sink for ip address forgery vulnerabilities. */
abstract class ClientSuppliedIpUsedInSecurityCheckSink extends DataFlow::Node { }

/** A data flow sink for sql operation. */
private class SqlOperationSink extends ClientSuppliedIpUsedInSecurityCheckSink {
  SqlOperationSink() { this = any(SqlExecution e).getSql() }
}

/**
 * A data flow sink for remote client ip comparison.
 *
 * For example: `if not ipAddr.startswith('192.168.') : ...` determine whether the client ip starts
 * with `192.168.`, and the program can be deceived by forging the ip address.
 */
private class CompareSink extends ClientSuppliedIpUsedInSecurityCheckSink {
  CompareSink() {
    exists(Call call |
      call.getFunc().(Attribute).getName() = "startswith" and
      call.getArg(0).(StrConst).getText().regexpMatch(getIpAddressRegex()) and
      not call.getArg(0).(StrConst).getText() = "0:0:0:0:0:0:0:1" and
      call.getFunc().(Attribute).getObject() = this.asExpr()
    )
    or
    exists(Compare compare |
      (
        compare.getOp(0) instanceof Eq or
        compare.getOp(0) instanceof NotEq
      ) and
      (
        compare.getLeft() = this.asExpr() and
        compare.getComparator(0).(StrConst).getText() instanceof PrivateHostName and
        not compare.getComparator(0).(StrConst).getText() = "0:0:0:0:0:0:0:1"
        or
        compare.getComparator(0) = this.asExpr() and
        compare.getLeft().(StrConst).getText() instanceof PrivateHostName and
        not compare.getLeft().(StrConst).getText() = "0:0:0:0:0:0:0:1"
      )
    )
    or
    exists(Compare compare |
      (
        compare.getOp(0) instanceof In or
        compare.getOp(0) instanceof NotIn
      ) and
      (
        compare.getLeft() = this.asExpr()
        or
        compare.getComparator(0) = this.asExpr() and
        not compare.getLeft().(StrConst).getText() in ["%", ",", "."]
      )
    )
  }
}

string getIpAddressRegex() {
  result =
    "^((10\\.((1\\d{2})?|(2[0-4]\\d)?|(25[0-5])?|([1-9]\\d|[0-9])?)(\\.)?)|(192\\.168\\.)|172\\.(1[6789]|2[0-9]|3[01])\\.)((1\\d{2})?|(2[0-4]\\d)?|(25[0-5])?|([1-9]\\d|[0-9])?)(\\.)?((1\\d{2})?|(2[0-4]\\d)?|(25[0-5])?|([1-9]\\d|[0-9])?)$"
}

/**
 * A string matching private host names of IPv4 and IPv6, which only matches the host portion therefore checking for port is not necessary.
 * Several examples are localhost, reserved IPv4 IP addresses including 127.0.0.1, 10.x.x.x, 172.16.x,x, 192.168.x,x, and reserved IPv6 addresses including [0:0:0:0:0:0:0:1] and [::1]
 */
private class PrivateHostName extends string {
  bindingset[this]
  PrivateHostName() {
    this.regexpMatch("(?i)localhost(?:[:/?#].*)?|127\\.0\\.0\\.1(?:[:/?#].*)?|10(?:\\.[0-9]+){3}(?:[:/?#].*)?|172\\.16(?:\\.[0-9]+){2}(?:[:/?#].*)?|192.168(?:\\.[0-9]+){2}(?:[:/?#].*)?|\\[?0:0:0:0:0:0:0:1\\]?(?:[:/?#].*)?|\\[?::1\\]?(?:[:/?#].*)?")
  }
}
