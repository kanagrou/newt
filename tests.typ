#import "util.typ"
#import "strnum.typ"
#import "richnum.typ"
#import "strunit.typ"
#import "lib.typ"

= tests

#assert.eq(strnum.strnum("123"), (integer: "123", decimal: none, sign: "+"))
#assert.eq(strnum.strnum("1.23"), (integer: "1", decimal: "23", sign: "+"))
#assert.eq(strnum.strnum("-.1"), (integer: "0", decimal: "1", sign: "-"))
#assert.eq(strnum.strnum("-00.1"), (integer: "0", decimal: "1", sign: "-"))
#assert.eq(strnum.strnum("-00.0"), (integer: "0", decimal: "0", sign: "-"))
#assert.eq(strnum.first-sigfig(strnum.strnum(.00123)), -2)
#assert.eq(strnum.first-sigfig(strnum.strnum(.23)), 0)
#assert.eq(strnum.first-sigfig(strnum.strnum(1.23)), 1)

#assert.eq(util.half-round("245", 1), "25")
#assert.eq(util.half-round("299", 2), "300")
#assert.eq(util.half-round("999", 2), "1000")
#assert.eq(util.half-round("999", 1), "100")
#assert.eq(util.half-round("25", 0), "3")
#assert.eq(util.half-round("9", 0, carry: r => (util.half-round("99", 1), r)), ("100", "0"))
#assert.eq(util.half-round("8", 0, carry: r => (util.half-round("99", 1), r)), "9")
#assert.eq(strnum.round(strnum.strnum("12"), 0), strnum.strnum("12.0"))
#assert.eq(strnum.round(strnum.strnum("12.3"), 1), strnum.strnum("12"))
#assert.eq(strnum.round(strnum.strnum("12.5"), 1), strnum.strnum("13"))
#assert.eq(strnum.round(strnum.strnum("12.3"), 2), strnum.strnum("10"))
#assert.eq(strnum.round(strnum.strnum("12.3"), 3), strnum.strnum("10"))
#assert.eq(strnum.round(strnum.strnum("123.4"), 3), strnum.strnum("100"))
#assert.eq(strnum.round(strnum.strnum("12.345"), -1), strnum.strnum("12.35"))
#assert.eq(strnum.round(strnum.strnum("12.340"), -1), strnum.strnum("12.34"))
#assert.eq(strnum.round(strnum.strnum(12.4505), -2), strnum.strnum("12.451"))
#assert.eq(strnum.round(strnum.strnum("1.23"), 0), strnum.strnum("1.2"))
#assert.eq(strnum.round(strnum.strnum("1.25"), 0), strnum.strnum("1.3"))

#assert.eq(strnum.shift(strnum.strnum("123.45"), 2), strnum.strnum("1.2345"))
#assert.eq(strnum.shift(strnum.strnum("123.45"), 3), strnum.strnum("0.12345"))
#assert.eq(strnum.shift(strnum.strnum("123.45"), 4), strnum.strnum("0.012345"))
#assert.eq(strnum.shift(strnum.strnum(".12"), 2), strnum.strnum(".0012"))
#assert.eq(strnum.shift(strnum.strnum("1"), 1), strnum.strnum(".1"))
#assert.eq(strnum.shift(strnum.strnum("12.345"), -2), strnum.strnum("1234.5"))
#assert.eq(strnum.shift(strnum.strnum("12.345"), -4), strnum.strnum("123450"))
#assert.eq(strnum.shift(strnum.strnum(".12"), -2), strnum.strnum("12"))
#assert.eq(strnum.shift(strnum.strnum(".012"), -2), strnum.strnum("1.2"))
#assert.eq(strnum.shift(strnum.strnum(".0012"), -2), strnum.strnum(".12"))
#assert.eq(strnum.shift(strnum.strnum(".0012"), -2), strnum.strnum(".12"))
#assert.eq(strnum.shift(strnum.strnum(".00012"), -2), strnum.strnum(".012"))
#assert.eq(strnum.shift(strnum.strnum("12"), -2), strnum.strnum("1200"))
#assert.eq(strnum.shift(strnum.strnum("0"), -2), strnum.strnum("0"))

#assert.eq(richnum.richnum("15"), (r: "15", pm: none, e: none, u: none, point: ",", explicit-sign: false, compact: false))
#assert.eq(richnum.richnum("+1.5+-.2e1"), (r: "1.5", pm: ".2", e: 1, u: none, point: ".", explicit-sign: true, compact: false))
#assert.eq(richnum.richnum(".1+-.3e2 kg m/s"), (r: ".1", pm: ".3", e: 2, u: "kg m/s", point: ".", explicit-sign: false, compact: false))
#assert.eq(richnum.richnum("1,0 kg m/s2"), (r: "1.0", pm: none, e: none, u: "kg m/s2", point: ",", explicit-sign: false, compact: false))

#assert.eq(strunit.strunit("o-"), (coef: 1, ident: "Ω", per: true, exp: 1, desc: none))
#assert.eq(strunit.strunit("kg2(alu)"), (coef: 1, ident: "kg", per: false, exp: 2, desc: "alu"))
#assert.eq(strunit.strunit("2kg-2(alu)"), (coef: 2, ident: "kg", per: true, exp: 2, desc: "alu"))
#assert.eq(strunit.strunits("m/s2"), ((coef: 1, ident: "m", per: false, exp: 1, desc: none), (coef: 1, ident: "s", per: true, exp: 2, desc: none)))

#assert.eq(lib.number("123.45", precision: none, point: ","), math.equation[123,45])
#assert.eq(lib.number(".45", precision: none, point: ","), math.equation[0,45])
#assert.eq(lib.number("00.45", precision: none, point: ","), math.equation[0,45])
#assert.eq(lib.number("123.45+-.06", point: ","), math.equation([123,45] + [±] + [0,06]))
#assert.eq(lib.number("123.45e3", precision: none, point: ","), math.equation([123,45] + [×] + math.attach(t: [3])[10]))
#assert.eq(lib.number("123,45+-,06e3"), math.equation([(] + [123,45] + [±] + [0,06] + [)] + [×] + math.attach(t: [3])[10]))
#assert.eq(lib.number("123.45 kg m/s2", u-opts: (product: ".", per-mode: "/")), math.equation([123] + [ ] + math.upright([kg] + [⋅] + [m] + [ ] + [/] + [ ] + math.attach(t: [2])[s])))
//#assert.eq(lib.number("123.45e3+-.06 kg m / s2"), math.equation([(] + [(] + [123,45] + [±] + [0,06] + [)] + [×] + math.attach(t: [3])[10] + [)] + [ ] + math.upright([kg] + [⋅] + [m] + [ /] + [ ] + math.attach(t: [2], b: none)[s])))
// #assert.eq(lib.number("123.45", precision: 3), lib.number(123))
// #assert.eq(lib.number(".45"), lib.number(.4501))
// #assert.eq(lib.number("00.45"), lib.number(.45))
// #assert.eq(lib.number("123.45+-.06"), lib.number(123.45, pm: .06))
// #assert.eq(lib.number("123.45e3"), lib.number(123.45 * 1000, e: 3))
// #assert.eq(lib.number("123.45e3+-.06"), math.equation([(] + [123,45] + [±] + [0,06] + [)] + [×] + math.attach(t: [3])[10]))
// #assert.eq(lib.number("123.45 kg m/s2", precision: none, per-mode: "power"), math.equation([123,45] + [ ] + math.upright([kg] + [⋅] + [m] + [⋅] + math.attach(t: "-2", b: none)[s])))
// 
// 
// #assert.eq(lib.number("10000"), math.equation("10 000"))
// #assert.eq(lib.number(calc.pi, precision: none), math.equation("3,14159 26535 89793"))
// #assert.eq(lib.number(123456.7891011, precision: none), math.equation("123 456,78910 11"))


#lib.number("1.99 /kg", precision: none)

#math.equation([123] + [ ] + math.upright([kg] + [⋅] + [m] + [ ] + [/] + [ ] + math.attach(t: [2], b: none)[s]))

#lib.number("123.45 kg m/s2", u-opts: (product: ".", per-mode: "/"))

#lib.number("123.45+-0.5", compact: true, precision: none)

#lib.number("123.45+6.2-7.1e3 kg m/s", precision: none)

#lib.number("123,45(5) kg m", precision: none)

#lib.number(1044, pm: 86, e: 2, fixed: false)

#lib.number(0.0000001249, e:auto, precision: 3, u: "cm2")
