// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.NominalOrBoundGenericNominalType
import codeql.swift.elements.type.Type

module Generated {
  class BoundGenericType extends Synth::TBoundGenericType, NominalOrBoundGenericNominalType {
    /**
     * Gets the `index`th arg type (0-based).
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Type getImmediateArgType(int index) {
      result =
        Synth::convertTypeFromRaw(Synth::convertBoundGenericTypeToRaw(this)
              .(Raw::BoundGenericType)
              .getArgType(index))
    }

    /**
     * Gets the `index`th arg type (0-based).
     */
    final Type getArgType(int index) { result = getImmediateArgType(index).resolve() }

    /**
     * Gets any of the arg types.
     */
    final Type getAnArgType() { result = getArgType(_) }

    /**
     * Gets the number of arg types.
     */
    final int getNumberOfArgTypes() { result = count(getAnArgType()) }
  }
}
