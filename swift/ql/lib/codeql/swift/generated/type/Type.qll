// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.Element

module Generated {
  class Type extends Synth::TType, Element {
    /**
     * Gets the name.
     */
    string getName() { result = Synth::convertTypeToRaw(this).(Raw::Type).getName() }

    /**
     * Gets the canonical type.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Type getImmediateCanonicalType() {
      result =
        Synth::convertTypeFromRaw(Synth::convertTypeToRaw(this).(Raw::Type).getCanonicalType())
    }

    /**
     * Gets the canonical type.
     */
    final Type getCanonicalType() { result = getImmediateCanonicalType().resolve() }
  }
}
