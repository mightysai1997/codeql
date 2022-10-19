// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.AstNode
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.pattern.Pattern

module Generated {
  class CaseLabelItem extends Synth::TCaseLabelItem, AstNode {
    override string getAPrimaryQlClass() { result = "CaseLabelItem" }

    /**
     * Gets the pattern.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Pattern getImmediatePattern() {
      result =
        Synth::convertPatternFromRaw(Synth::convertCaseLabelItemToRaw(this)
              .(Raw::CaseLabelItem)
              .getPattern())
    }

    /**
     * Gets the pattern.
     */
    final Pattern getPattern() { result = getImmediatePattern().resolve() }

    /**
     * Gets the guard, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Expr getImmediateGuard() {
      result =
        Synth::convertExprFromRaw(Synth::convertCaseLabelItemToRaw(this)
              .(Raw::CaseLabelItem)
              .getGuard())
    }

    /**
     * Gets the guard, if it exists.
     */
    final Expr getGuard() { result = getImmediateGuard().resolve() }

    /**
     * Holds if `getGuard()` exists.
     */
    final predicate hasGuard() { exists(getGuard()) }
  }
}
