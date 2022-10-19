// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.AnyFunctionType
import codeql.swift.elements.type.GenericTypeParamType

module Generated {
  /**
   * The type of a generic function with type parameters
   */
  class GenericFunctionType extends Synth::TGenericFunctionType, AnyFunctionType {
    override string getAPrimaryQlClass() { result = "GenericFunctionType" }

    /**
     * Gets the `index`th generic parameter (0-based).
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    GenericTypeParamType getImmediateGenericParam(int index) {
      result =
        Synth::convertGenericTypeParamTypeFromRaw(Synth::convertGenericFunctionTypeToRaw(this)
              .(Raw::GenericFunctionType)
              .getGenericParam(index))
    }

    /**
     * Gets the `index`th generic parameter (0-based).
     */
    final GenericTypeParamType getGenericParam(int index) {
      result = getImmediateGenericParam(index).resolve()
    }

    /**
     * Gets any of the generic parameters.
     */
    final GenericTypeParamType getAGenericParam() { result = getGenericParam(_) }

    /**
     * Gets the number of generic parameters.
     */
    final int getNumberOfGenericParams() { result = count(getAGenericParam()) }
  }
}
