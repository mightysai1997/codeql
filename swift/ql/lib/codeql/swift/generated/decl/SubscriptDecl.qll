// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.AbstractStorageDecl
import codeql.swift.elements.decl.GenericContext
import codeql.swift.elements.decl.ParamDecl
import codeql.swift.elements.type.Type

module Generated {
  class SubscriptDecl extends Synth::TSubscriptDecl, AbstractStorageDecl, GenericContext {
    override string getAPrimaryQlClass() { result = "SubscriptDecl" }

    /**
     * Gets the `index`th param (0-based).
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    ParamDecl getImmediateParam(int index) {
      result =
        Synth::convertParamDeclFromRaw(Synth::convertSubscriptDeclToRaw(this)
              .(Raw::SubscriptDecl)
              .getParam(index))
    }

    /**
     * Gets the `index`th param (0-based).
     */
    final ParamDecl getParam(int index) { result = getImmediateParam(index).resolve() }

    /**
     * Gets any of the params.
     */
    final ParamDecl getAParam() { result = getParam(_) }

    /**
     * Gets the number of params.
     */
    final int getNumberOfParams() { result = count(getAParam()) }

    /**
     * Gets the element type.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Type getImmediateElementType() {
      result =
        Synth::convertTypeFromRaw(Synth::convertSubscriptDeclToRaw(this)
              .(Raw::SubscriptDecl)
              .getElementType())
    }

    /**
     * Gets the element type.
     */
    final Type getElementType() { result = getImmediateElementType().resolve() }
  }
}
