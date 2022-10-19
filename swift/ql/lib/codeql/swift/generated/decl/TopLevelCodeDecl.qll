// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.stmt.BraceStmt
import codeql.swift.elements.decl.Decl

module Generated {
  class TopLevelCodeDecl extends Synth::TTopLevelCodeDecl, Decl {
    override string getAPrimaryQlClass() { result = "TopLevelCodeDecl" }

    /**
     * Gets the body.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    BraceStmt getImmediateBody() {
      result =
        Synth::convertBraceStmtFromRaw(Synth::convertTopLevelCodeDeclToRaw(this)
              .(Raw::TopLevelCodeDecl)
              .getBody())
    }

    /**
     * Gets the body.
     */
    final BraceStmt getBody() { result = getImmediateBody().resolve() }
  }
}
