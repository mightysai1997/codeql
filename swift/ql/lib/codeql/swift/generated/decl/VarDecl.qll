// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.AbstractStorageDecl
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.pattern.Pattern
import codeql.swift.elements.type.Type

module Generated {
  class VarDecl extends Synth::TVarDecl, AbstractStorageDecl {
    /**
     * Gets the name.
     */
    string getName() { result = Synth::convertVarDeclToRaw(this).(Raw::VarDecl).getName() }

    /**
     * Gets the type.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Type getImmediateType() {
      result = Synth::convertTypeFromRaw(Synth::convertVarDeclToRaw(this).(Raw::VarDecl).getType())
    }

    /**
     * Gets the type.
     */
    final Type getType() { result = getImmediateType().resolve() }

    /**
     * Gets the attached property wrapper type, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Type getImmediateAttachedPropertyWrapperType() {
      result =
        Synth::convertTypeFromRaw(Synth::convertVarDeclToRaw(this)
              .(Raw::VarDecl)
              .getAttachedPropertyWrapperType())
    }

    /**
     * Gets the attached property wrapper type, if it exists.
     */
    final Type getAttachedPropertyWrapperType() {
      result = getImmediateAttachedPropertyWrapperType().resolve()
    }

    /**
     * Holds if `getAttachedPropertyWrapperType()` exists.
     */
    final predicate hasAttachedPropertyWrapperType() { exists(getAttachedPropertyWrapperType()) }

    /**
     * Gets the parent pattern, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Pattern getImmediateParentPattern() {
      result =
        Synth::convertPatternFromRaw(Synth::convertVarDeclToRaw(this)
              .(Raw::VarDecl)
              .getParentPattern())
    }

    /**
     * Gets the parent pattern, if it exists.
     */
    final Pattern getParentPattern() { result = getImmediateParentPattern().resolve() }

    /**
     * Holds if `getParentPattern()` exists.
     */
    final predicate hasParentPattern() { exists(getParentPattern()) }

    /**
     * Gets the parent initializer, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Expr getImmediateParentInitializer() {
      result =
        Synth::convertExprFromRaw(Synth::convertVarDeclToRaw(this)
              .(Raw::VarDecl)
              .getParentInitializer())
    }

    /**
     * Gets the parent initializer, if it exists.
     */
    final Expr getParentInitializer() { result = getImmediateParentInitializer().resolve() }

    /**
     * Holds if `getParentInitializer()` exists.
     */
    final predicate hasParentInitializer() { exists(getParentInitializer()) }
  }
}
