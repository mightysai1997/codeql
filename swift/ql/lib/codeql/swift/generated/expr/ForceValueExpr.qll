// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr

module Generated {
  class ForceValueExpr extends Synth::TForceValueExpr, Expr {
    override string getAPrimaryQlClass() { result = "ForceValueExpr" }

    /**
     * Gets the sub expr.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertForceValueExprToRaw(this)
              .(Raw::ForceValueExpr)
              .getSubExpr())
    }

    /**
     * Gets the sub expr.
     */
    final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }
  }
}
