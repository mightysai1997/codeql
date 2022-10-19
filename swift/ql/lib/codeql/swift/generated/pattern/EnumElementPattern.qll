// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.EnumElementDecl
import codeql.swift.elements.pattern.Pattern

module Generated {
  class EnumElementPattern extends Synth::TEnumElementPattern, Pattern {
    override string getAPrimaryQlClass() { result = "EnumElementPattern" }

    /**
     * Gets the element.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    EnumElementDecl getImmediateElement() {
      result =
        Synth::convertEnumElementDeclFromRaw(Synth::convertEnumElementPatternToRaw(this)
              .(Raw::EnumElementPattern)
              .getElement())
    }

    /**
     * Gets the element.
     */
    final EnumElementDecl getElement() { result = getImmediateElement().resolve() }

    /**
     * Gets the sub pattern, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Pattern getImmediateSubPattern() {
      result =
        Synth::convertPatternFromRaw(Synth::convertEnumElementPatternToRaw(this)
              .(Raw::EnumElementPattern)
              .getSubPattern())
    }

    /**
     * Gets the sub pattern, if it exists.
     */
    final Pattern getSubPattern() { result = getImmediateSubPattern().resolve() }

    /**
     * Holds if `getSubPattern()` exists.
     */
    final predicate hasSubPattern() { exists(getSubPattern()) }
  }
}
