// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.decl.VarDecl

module Generated {
  class SuperRefExpr extends Synth::TSuperRefExpr, Expr {
    override string getAPrimaryQlClass() { result = "SuperRefExpr" }

    /**
     * Gets the self.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    VarDecl getImmediateSelf() {
      result =
        Synth::convertVarDeclFromRaw(Synth::convertSuperRefExprToRaw(this)
              .(Raw::SuperRefExpr)
              .getSelf())
    }

    /**
     * Gets the self.
     */
    final VarDecl getSelf() { result = getImmediateSelf().resolve() }
  }
}
