---
---

scrollIndicate = () ->
  scrollIndicator = document.querySelector('body > header + .scroll-indicator')

  scrollTop = document.documentElement.scrollTop
  scrollMaxY = window.scrollMaxY | (document.documentElement.scrollHeight - document.documentElement.clientHeight)

  scrollIndicator.style.width = 100 * (scrollTop / scrollMaxY) + '%'

window.addEventListener 'scroll', scrollIndicate, false
window.addEventListener 'resize', scrollIndicate, false
