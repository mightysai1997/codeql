// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.Element
import codeql.swift.elements.Location

module Generated {
  class Locatable extends Synth::TLocatable, Element {
    /**
     * Gets the location, if it exists.
     * This includes nodes from the "hidden" AST and can be used to be overridden by subclasses.
     */
    Location getImmediateLocation() {
      result =
        Synth::convertLocationFromRaw(Synth::convertLocatableToRaw(this)
              .(Raw::Locatable)
              .getLocation())
    }

    /**
     * Gets the location, if it exists.
     */
    final Location getLocation() { result = getImmediateLocation().resolve() }

    /**
     * Holds if `getLocation()` exists.
     */
    final predicate hasLocation() { exists(getLocation()) }
  }
}
