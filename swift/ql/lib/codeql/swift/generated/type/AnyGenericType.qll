// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.Decl
import codeql.swift.elements.type.Type

module Generated {
  class AnyGenericType extends Synth::TAnyGenericType, Type {
    /**
     * Gets the parent, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Type getImmediateParent() {
      result =
        Synth::convertTypeFromRaw(Synth::convertAnyGenericTypeToRaw(this)
              .(Raw::AnyGenericType)
              .getParent())
    }

    /**
     * Gets the parent, if it exists.
     */
    final Type getParent() { result = getImmediateParent().resolve() }

    /**
     * Holds if `getParent()` exists.
     */
    final predicate hasParent() { exists(getParent()) }

    /**
     * Gets the declaration.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Decl getImmediateDeclaration() {
      result =
        Synth::convertDeclFromRaw(Synth::convertAnyGenericTypeToRaw(this)
              .(Raw::AnyGenericType)
              .getDeclaration())
    }

    /**
     * Gets the declaration.
     */
    final Decl getDeclaration() { result = getImmediateDeclaration().resolve() }
  }
}
