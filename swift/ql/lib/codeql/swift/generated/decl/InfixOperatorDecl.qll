// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.OperatorDecl
import codeql.swift.elements.decl.PrecedenceGroupDecl

module Generated {
  class InfixOperatorDecl extends Synth::TInfixOperatorDecl, OperatorDecl {
    override string getAPrimaryQlClass() { result = "InfixOperatorDecl" }

    /**
     * Gets the precedence group, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    PrecedenceGroupDecl getImmediatePrecedenceGroup() {
      result =
        Synth::convertPrecedenceGroupDeclFromRaw(Synth::convertInfixOperatorDeclToRaw(this)
              .(Raw::InfixOperatorDecl)
              .getPrecedenceGroup())
    }

    /**
     * Gets the precedence group, if it exists.
     */
    final PrecedenceGroupDecl getPrecedenceGroup() {
      result = getImmediatePrecedenceGroup().resolve()
    }

    /**
     * Holds if `getPrecedenceGroup()` exists.
     */
    final predicate hasPrecedenceGroup() { exists(getPrecedenceGroup()) }
  }
}
