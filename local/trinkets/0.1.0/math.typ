#import "@preview/quick-maths:0.2.1": shorthands

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

#let bigast = scale(200%)[$ast.op$]
#let nonumber = none

#let trinkets = doc => {
  show: shorthands.with(
    ($+-$, $plus.minus$),
    ($<=$, $lt.eq.slant$),
    ($>=$, $gt.eq.slant$),
  )

  doc
}
