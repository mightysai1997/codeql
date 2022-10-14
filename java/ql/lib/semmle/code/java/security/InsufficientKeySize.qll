/** Provides classes and predicates related to insufficient key sizes in Java. */

private import semmle.code.java.security.Encryption
private import semmle.code.java.dataflow.DataFlow

// TODO: only update key sizes (and key size strings) in one place in the code
/** A source for an insufficient key size. */
abstract class InsufficientKeySizeSource extends DataFlow::Node {
  /** Holds if this source has the specified `state`. */
  predicate hasState(DataFlow::FlowState state) { state instanceof DataFlow::FlowStateEmpty }
}

/** A sink for an insufficient key size. */
abstract class InsufficientKeySizeSink extends DataFlow::Node {
  /** Holds if this sink has the specified `state`. */
  predicate hasState(DataFlow::FlowState state) { state instanceof DataFlow::FlowStateEmpty }
}

/** A source for an insufficient key size (asymmetric-non-ec: RSA, DSA, DH). */
private class AsymmetricNonECSource extends InsufficientKeySizeSource {
  AsymmetricNonECSource() { getNodeIntValue(this) < 2048 }

  override predicate hasState(DataFlow::FlowState state) { state = "2048" }
}

/** A source for an insufficient key size (asymmetric-ec: EC%). */
private class AsymmetricECSource extends InsufficientKeySizeSource {
  AsymmetricECSource() {
    getNodeIntValue(this) < 256 or
    getECKeySize(this.asExpr().(StringLiteral).getValue()) < 256 // for cases when the key size is embedded in the curve name
  }

  override predicate hasState(DataFlow::FlowState state) { state = "256" }
}

/** A source for an insufficient key size (symmetric: AES). */
private class SymmetricSource extends InsufficientKeySizeSource {
  SymmetricSource() { getNodeIntValue(this) < 128 }

  override predicate hasState(DataFlow::FlowState state) { state = "128" }
}

// TODO: use `typeFlag` like with sinks below to include the size numbers in this predicate?
private int getNodeIntValue(DataFlow::Node node) {
  result = node.asExpr().(IntegerLiteral).getIntValue()
}

// TODO: check if any other regex should be added based on some MRVA results.
/** Returns the key size in the EC algorithm string */
bindingset[algorithm]
private int getECKeySize(string algorithm) {
  algorithm.matches("sec%") and // specification such as "secp256r1"
  result = algorithm.regexpCapture("sec[p|t](\\d+)[a-zA-Z].*", 1).toInt()
  or
  algorithm.matches("X9.62%") and //specification such as "X9.62 prime192v2"
  result = algorithm.regexpCapture("X9\\.62 .*[a-zA-Z](\\d+)[a-zA-Z].*", 1).toInt()
  or
  (algorithm.matches("prime%") or algorithm.matches("c2tnb%")) and //specification such as "prime192v2"
  result = algorithm.regexpCapture(".*[a-zA-Z](\\d+)[a-zA-Z].*", 1).toInt()
}

/** A sink for an insufficient key size (asymmetric-non-ec). */
private class AsymmetricNonECSink extends InsufficientKeySizeSink {
  AsymmetricNonECSink() {
    hasKeySizeInInitMethod(this, "asymmetric-non-ec")
    or
    hasKeySizeInSpec(this)
  }

  override predicate hasState(DataFlow::FlowState state) { state = "2048" }
}

private class AsymmetricNonECSpec extends RefType {
  AsymmetricNonECSpec() {
    this instanceof RsaKeyGenParameterSpec or
    this instanceof DsaGenParameterSpec or
    this instanceof DhGenParameterSpec
  }
}

/** A sink for an insufficient key size (asymmetric-ec). */
private class AsymmetricECSink extends InsufficientKeySizeSink {
  AsymmetricECSink() {
    hasKeySizeInInitMethod(this, "asymmetric-ec")
    or
    hasKeySizeInSpec(this)
  }

  override predicate hasState(DataFlow::FlowState state) { state = "256" }
}

/** A sink for an insufficient key size (symmetric). */
private class SymmetricSink extends InsufficientKeySizeSink {
  SymmetricSink() { hasKeySizeInInitMethod(this, "symmetric") }

  override predicate hasState(DataFlow::FlowState state) { state = "128" }
}

// TODO: rethink the predicate name; also think about whether this could/should be a class instead; or a predicate within the sink class so can do sink.predicate()...
// TODO: can prbly re-work way using the typeFlag to be better and less repetitive
private predicate hasKeySizeInInitMethod(DataFlow::Node node, string typeFlag) {
  exists(MethodAccess ma, JavaxCryptoAlgoSpec jcaSpec |
    (
      ma.getMethod() instanceof KeyGeneratorInitMethod and typeFlag = "symmetric"
      or
      ma.getMethod() instanceof KeyPairGeneratorInitMethod and typeFlag.matches("asymmetric%")
    ) and
    (
      jcaSpec instanceof JavaxCryptoKeyGenerator and typeFlag = "symmetric"
      or
      jcaSpec instanceof JavaSecurityKeyPairGenerator and typeFlag.matches("asymmetric%")
    ) and
    (
      getAlgoName(jcaSpec) = "AES" and typeFlag = "symmetric"
      or
      getAlgoName(jcaSpec).matches(["RSA", "DSA", "DH"]) and typeFlag = "asymmetric-non-ec"
      or
      getAlgoName(jcaSpec).matches("EC%") and typeFlag = "asymmetric-ec"
    ) and
    DataFlow::localExprFlow(jcaSpec, ma.getQualifier()) and
    node.asExpr() = ma.getArgument(0)
  )
}

// TODO: this predicate is just a poc for more code condensing; redo this
private string getAlgoName(JavaxCryptoAlgoSpec jca) {
  result = jca.getAlgoSpec().(StringLiteral).getValue().toUpperCase()
}

// TODO: rethink the predicate name; also think about whether this could/should be a class instead; or a predicate within the sink class so can do sink.predicate()...
// TODO: can prbly re-work way using the typeFlag to be better and less repetitive...
private predicate hasKeySizeInSpec(DataFlow::Node node) {
  exists(ClassInstanceExpr paramSpec |
    (
      paramSpec.getConstructedType() instanceof AsymmetricNonECSpec //and
      or
      //typeFlag = "asymmetric-non-ec"
      paramSpec.getConstructedType() instanceof EcGenParameterSpec //and
      //typeFlag = "asymmetric-ec"
    ) and
    node.asExpr() = paramSpec.getArgument(0)
  )
}

// ! use below instead of/in above??
class Spec extends ClassInstanceExpr {
  Spec() {
    this.getConstructedType() instanceof AsymmetricNonECSpec or
    this.getConstructedType() instanceof EcGenParameterSpec
  }

  Argument getKeySizeArg() { result = this.getArgument(0) }
}
// TODO:
// todo #0: look into use of specs without keygen objects; should spec not be a sink in these cases?
// todo #3: make list of algo names more easily reusable (either as constant-type variable at top of file, or model as own class to share, etc.)
