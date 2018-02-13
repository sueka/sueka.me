---
---

scrollIndicate = () ->
  scrollIndicator = document.querySelector('body > header + .scroll-indicator')

  scrollingElement = document.scrollingElement || document.documentElement
  scrollTop = Math.max(scrollingElement.scrollTop, document.body.scrollTop)
  scrollMaxY = window.scrollMaxY || (document.documentElement.scrollHeight - document.documentElement.clientHeight)

  scrollIndicator.style.width =
    if (scrollMaxY == 0)
      '0'
    else
      100 * (scrollTop / scrollMaxY) + '%'

window.addEventListener 'load', scrollIndicate, false
window.addEventListener 'scroll', scrollIndicate, false
window.addEventListener 'resize', scrollIndicate, false
