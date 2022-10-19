// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.pattern.Pattern

module Generated {
  class OptionalSomePattern extends Synth::TOptionalSomePattern, Pattern {
    override string getAPrimaryQlClass() { result = "OptionalSomePattern" }

    /**
     * Gets the sub pattern.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Pattern getImmediateSubPattern() {
      result =
        Synth::convertPatternFromRaw(Synth::convertOptionalSomePatternToRaw(this)
              .(Raw::OptionalSomePattern)
              .getSubPattern())
    }

    /**
     * Gets the sub pattern.
     */
    final Pattern getSubPattern() { result = getImmediateSubPattern().resolve() }
  }
}
