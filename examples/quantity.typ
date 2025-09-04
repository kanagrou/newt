#import "../lib.typ": n
#let qty(number, unit, ..rest) = n(number, u: unit, ..rest)

#set page(width: auto, height: auto)

#let G = 6.67430 * 1/100000000000
#let uncertainty = G * 2 * 1/100000

$ G = #qty(G, pm: uncertainty, "N m2/kg2", e: auto) $

$ #n(0.00655, pm: .0002, e: -3) $

