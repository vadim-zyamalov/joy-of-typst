#import "@preview/hydra:0.6.3": hydra
#import "@preview/parize:0.2.1": par-indent
#import "@preview/breather:0.1.0": breathe
#import "@preview/equate:0.3.3": equate

#let neat-settings = (
  margin: (
    top: 1.5cm,
    bottom: 1.5cm,
    inside: 3cm,
    outside: 1.5cm,
  ),
  fonts: (
    main: "PT Astra Serif",
    sans: "PT Astra Sans",
    mono: "Cascadia Code",
    math: none,
    size: 14pt,
  ),
)

// Переопределение заголовков в приложениях.
#let appendix(body, supplement: [Приложение], numbering: "A.1") = {
  set heading(numbering: numbering, supplement: supplement)
  body
}

#let neat-document(
  indent: 2em,
  leading: 1em,
  fonts: (:),
  margin: (:),
  lang: "ru",
  refstyle: "chicago-author-date",
  doc,
) = {
  // Обновляем значения по умолчанию собственными значениями.
  let inner-settings = neat-settings
  inner-settings.margin += margin
  inner-settings.fonts += fonts

  let leading = calc.max(0.65em, leading)
  let h-leading = calc.max(0.65em, leading / 2)

  // Настройки страницы.
  set page(
    paper: "a4",
    header: context {
      let page_num = counter(page).at(here()).first()
      if page_num != 1 {
        if calc.even(page_num) {
          align(left)[#emph(document.title)]
        } else {
          align(right)[#emph(hydra(1))]
        }
      }
    },
    footer: context align(center)[#counter(page).display("1", both: false)],
    columns: 1,
    margin: inner-settings.margin,
  )

  // Настройки параграфов.
  set par(
    justify: true,
    leading: leading,
    first-line-indent: (amount: indent, all: true),
  )

  // Убираем переносы в заголовках документа.
  show title: set par(justify: false, leading: h-leading)
  show heading: set par(justify: false, leading: h-leading)

  // Отступы в списках
  set enum(indent: indent)
  set list(indent: indent)
  set terms(indent: indent, hanging-indent: -indent)

  // Делаем блочные матрицы более сжатыми по вертикали и разрешаем разрыв блока между страницами.
  show math.equation.where(block: true): set block(breakable: true)
  show math.equation.where(block: true): set par(leading: 0.75em)

  // Добавляем горизонтальное расстояние между колонками в матрицах.
  set math.mat(column-gap: 1em)

  // Делаем блоки сырого текста более сжатыми по вертикали.
  show raw.where(block: true): set par(leading: 0.75em)

  // Задаем шрифты.
  set text(lang: lang, font: inner-settings.fonts.main, size: inner-settings.fonts.size)
  show raw: set text(font: inner-settings.fonts.mono, size: inner-settings.fonts.size)
  show math.equation: set text(font: inner-settings.fonts.math) if inner-settings.fonts.math != none

  // Добавим вертикальный пробел после заголовков.
  show heading: it => block(it + v(0.5em))

  // Ссылки на уравнения в виде (1).
  // Данная функция предназначена для стандартных ссылок на формулы:
  // заменяет "Уравнение X" на "(X)".
  // https://typst.app/docs/reference/model/ref/
  show ref: it => {
    let el = it.element
    // Skip all other references.
    if el == none or el.func() != math.equation { return it }
    // Override equation references.
    link(el.location(), counter(math.equation).display(at: el.location()))
  }

  // То же самое, но для формул, нумерованных пакетом equate.
  // Это нужно делать специально, так как equate заново пересобирает все формулы,
  // в том числе и ссылки на них.
  // https://github.com/EpicEricEE/typst-equate/issues/11#issuecomment-2633709934
  set math.equation(supplement: none, numbering: (..nums) => numbering("(1)", ..nums))

  set cite(style: refstyle)

  // Применяем к документу функции из импортированных пакетов.
  show: par-indent
  show: equate.with(breakable: true, number-mode: "label")
  show: breathe

  // Размещаем заголовок документа.
  place(
    top + center,
    float: true,
    scope: "parent",
    clearance: 2em,
  )[#title()]

  // Тело документа.
  doc
}
