#let Ex = math.op("E")
#let Var = math.op("Var")
#let SE = math.op("SE")
#let Cov = math.op("Cov")
#let Corr = math.op("Corr")
#let Pr = math.op("P")
#let plim = math.op("plim", limits: true)
#let rank = math.op("rank")
#let Vect = el => math.bold(math.upright(el))
#let vv = Vect

#let pm = sym.plus.minus
#let bigast = scale(200%)[$ast.op$]
#let nonumber = none

#let trinkets = doc => {
  show sym.lt.eq: sym.lt.eq.slant
  show sym.gt.eq: sym.gt.eq.slant

  doc
}
