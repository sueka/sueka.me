---
---

{ patchOuter, elementOpen, elementClose, text } = IncrementalDOM

array = (arrayLike) -> Array::slice.call arrayLike

flatten = (xss) -> Array::concat.apply [], xss

mains = array document.querySelectorAll 'main'

anchorageAndIds = flatten [
  flatten mains.map (main) -> array main.querySelectorAll 'h1, h2, h3, h4, h5, h6'
  .filter (hn) -> hn.hasAttribute 'id'
  .map (hn) -> { anchorage: hn, id: hn.id }
  flatten mains.map (main) -> array main.querySelectorAll 'section, article, nav, aside'
  .filter (section) -> section.hasAttribute 'id'
  .map (section) -> { anchorage: section.querySelector('h1, h2, h3, h4, h5, h6'), id: section.id }
]

anchorageAndIds.forEach ({ anchorage, id }) ->
  headerAnchor = document.createElement 'div'
  anchorage.appendChild headerAnchor

  patchOuter headerAnchor, () ->
    text ' '
    elementOpen 'a', null, [
      'class', 'header-anchor'
      'href', '#' + id
    ]
    text '#'
    elementClose 'a'

window.addEventListener 'touchstart', (->), false
