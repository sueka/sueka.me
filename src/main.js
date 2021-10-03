---
url: /assets/scripts/main.js
templateEngine: njk
---

window.addEventListener('touchstart', () => {})

import('https://ga.jspm.io/npm:bowser@2.11.0/es5.js').then(({ default: Bowser }) => {
  const browser = Bowser.getParser(navigator.userAgent)

  const isGecko = browser.isEngine('Gecko')
  const isBlink = browser.isEngine('Blink')

  if (!isGecko && !isBlink) {
    return
  }

  const links = document.querySelectorAll('link[href$="{{ '~/horizontal.css' | url }}"], link[href$="{{ '~/vertical.css' | url }}"]')

  for (const link of links) {
    if (isGecko) {
      const linkForGecko = link.cloneNode()

      linkForGecko.href = linkForGecko.getAttribute('href').replace(/(?=\.css$)/, '-gecko')
      document.head.insertBefore(linkForGecko, link.nextSibling)
    }

    if (isBlink) {
      const linkForBlink = link.cloneNode()

      linkForBlink.href = linkForBlink.getAttribute('href').replace(/(?=\.css$)/, '-blink')
      document.head.insertBefore(linkForBlink, link.nextSibling)
    }
  }
})
