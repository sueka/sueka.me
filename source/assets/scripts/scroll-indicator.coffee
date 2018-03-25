---
---

scrollIndicator = document.querySelector 'body > header + .scroll-indicator'

scrollIndicate = () ->
  scrollingElement = document.scrollingElement || document.documentElement
  scrollTop = Math.max scrollingElement.scrollTop, document.body.scrollTop
  scrollMaxY = document.documentElement.scrollHeight - window.innerHeight

  scrollIndicator.style.width =
    if scrollMaxY == 0
      '0'
    else
      100 * Math.min(1, scrollTop / scrollMaxY) + '%'

window.addEventListener 'load', scrollIndicate, false
window.addEventListener 'scroll', scrollIndicate, false
window.addEventListener 'resize', scrollIndicate, false
