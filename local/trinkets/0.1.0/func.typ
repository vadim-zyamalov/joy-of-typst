// Функция для автоматического выбора размера текста такого,
// что соответствующий элемент будет вписываться по ширине в страницу/слайд.
// See https://forum.typst.app/t/how-to-auto-size-text-and-images/1290/3
#let fill-height-with-text(min: 0.3em, max: 5em, eps: 0.1em, it) = layout(size => {
  let fits(text-size, it) = {
    (
      measure(width: size.width, {
        set text(text-size)
        it
      }).height
        <= size.height
    )
  }

  if not fits(min, it) { panic("Content doesn't fit even at minimum text size") }
  if fits(max, it) {
    set text(max)
    it
  }

  let (a, b) = (min, max)
  while b - a > eps {
    let new = 0.5 * (a + b)
    if fits(new, it) {
      a = new
    } else {
      b = new
    }
  }

  set text(a)
  it
})

#let fill-width-with-text(min: 0.3em, max: 5em, eps: 0.1em, it) = layout(size => {
  let fits(text-size, it) = {
    (
      measure({
        set text(text-size)
        it
      }).width
        <= size.width
    )
  }

  if not fits(min, it) { panic("Content doesn't fit even at minimum text size") }
  if fits(max, it) {
    set text(max)
    it
  }

  let (a, b) = (min, max)
  while b - a > eps {
    let new = 0.5 * (a + b)
    if fits(new, it) {
      a = new
    } else {
      b = new
    }
  }

  set text(a)
  it
})
