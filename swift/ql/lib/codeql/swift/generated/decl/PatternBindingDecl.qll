// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.Decl
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.pattern.Pattern

module Generated {
  class PatternBindingDecl extends Synth::TPatternBindingDecl, Decl {
    override string getAPrimaryQlClass() { result = "PatternBindingDecl" }

    /**
     * Gets the `index`th init (0-based), if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Expr getImmediateInit(int index) {
      result =
        Synth::convertExprFromRaw(Synth::convertPatternBindingDeclToRaw(this)
              .(Raw::PatternBindingDecl)
              .getInit(index))
    }

    /**
     * Gets the `index`th init (0-based), if it exists.
     */
    final Expr getInit(int index) { result = getImmediateInit(index).resolve() }

    /**
     * Holds if `getInit(index)` exists.
     */
    final predicate hasInit(int index) { exists(getInit(index)) }

    /**
     * Gets any of the inits.
     */
    final Expr getAnInit() { result = getInit(_) }

    /**
     * Gets the `index`th pattern (0-based).
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Pattern getImmediatePattern(int index) {
      result =
        Synth::convertPatternFromRaw(Synth::convertPatternBindingDeclToRaw(this)
              .(Raw::PatternBindingDecl)
              .getPattern(index))
    }

    /**
     * Gets the `index`th pattern (0-based).
     */
    final Pattern getPattern(int index) { result = getImmediatePattern(index).resolve() }

    /**
     * Gets any of the patterns.
     */
    final Pattern getAPattern() { result = getPattern(_) }

    /**
     * Gets the number of patterns.
     */
    final int getNumberOfPatterns() { result = count(getAPattern()) }
  }
}
