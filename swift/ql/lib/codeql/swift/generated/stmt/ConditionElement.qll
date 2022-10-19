// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.AstNode
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.pattern.Pattern

module Generated {
  class ConditionElement extends Synth::TConditionElement, AstNode {
    override string getAPrimaryQlClass() { result = "ConditionElement" }

    /**
     * Gets the boolean, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Expr getImmediateBoolean() {
      result =
        Synth::convertExprFromRaw(Synth::convertConditionElementToRaw(this)
              .(Raw::ConditionElement)
              .getBoolean())
    }

    /**
     * Gets the boolean, if it exists.
     */
    final Expr getBoolean() { result = getImmediateBoolean().resolve() }

    /**
     * Holds if `getBoolean()` exists.
     */
    final predicate hasBoolean() { exists(getBoolean()) }

    /**
     * Gets the pattern, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Pattern getImmediatePattern() {
      result =
        Synth::convertPatternFromRaw(Synth::convertConditionElementToRaw(this)
              .(Raw::ConditionElement)
              .getPattern())
    }

    /**
     * Gets the pattern, if it exists.
     */
    final Pattern getPattern() { result = getImmediatePattern().resolve() }

    /**
     * Holds if `getPattern()` exists.
     */
    final predicate hasPattern() { exists(getPattern()) }

    /**
     * Gets the initializer, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Expr getImmediateInitializer() {
      result =
        Synth::convertExprFromRaw(Synth::convertConditionElementToRaw(this)
              .(Raw::ConditionElement)
              .getInitializer())
    }

    /**
     * Gets the initializer, if it exists.
     */
    final Expr getInitializer() { result = getImmediateInitializer().resolve() }

    /**
     * Holds if `getInitializer()` exists.
     */
    final predicate hasInitializer() { exists(getInitializer()) }
  }
}
