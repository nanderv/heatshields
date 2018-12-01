local a = core.filter.add
a("ship_component", { "componentType", "shipNumber", "position" })
a("massSoure", {"oX", "oY", "mass"})
a("orbital", {"oX", "oY", "dx", "dy", "ax", "ay", "mass"})
a("ship", {"isShip"})
a("planet", {"isPlanet"})
a("star", {"isStar"})