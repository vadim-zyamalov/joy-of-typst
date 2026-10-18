#import "@preview/zero:0.7.1": *

#let Ex = math.op([E])
#let Var = math.op([Var])
#let SE = math.op([SE])
#let Cov = math.op([Cov])
#let Corr = math.op([Corr])
#let Pr = math.op([P])
#let plim = math.op([plim], limits: true)
#let rank = math.op([rank])
#let Vect = el => math.bold(math.upright(el))
#let vv = Vect
#let vert = math.mid(sym.bar.v)

#let pm = sym.plus.minus
#let bigast = scale(200%)[$ast.op$]
#let nonumber = none

#let Re = math.op([Re])
#let Im = math.op([Im])

#let trinkets = doc => {
  set-num(decimal-separator: ",")
  show sym.lt.eq: sym.lt.eq.slant
  show sym.gt.eq: sym.gt.eq.slant
  show regex("\d+(\.|,)\d+"): it => num[#it]

  doc
}
