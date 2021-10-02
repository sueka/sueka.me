---
url: /assets/scripts/main.js
templateEngine: njk
---

window.addEventListener('touchstart', () => {})

import('https://ga.jspm.io/npm:bowser@2.11.0/es5.js').then(({ default: Bowser }) => {
  const browser = Bowser.getParser(navigator.userAgent)

  const isGecko = browser.isEngine('Gecko')
  const isBlink = browser.isEngine('Blink')

  const linksToVerticalCss = document.querySelectorAll('link[href$="{{ '~/vertical.css' | url }}"]')

  for (const link of linksToVerticalCss) {
    if (isGecko) {
      const linkToVerticalGeckoCss = link.cloneNode()

      linkToVerticalGeckoCss.href = '{{ '~/vertical-gecko.css' | url(true) }}'

      document.head.insertBefore(linkToVerticalGeckoCss, link.nextSibling)
    }

    if (isBlink) {
      const linkToVerticalBlinkCss = link.cloneNode()

      linkToVerticalBlinkCss.href = '{{ '~/vertical-blink.css' | url(true) }}'

      document.head.insertBefore(linkToVerticalBlinkCss, link.nextSibling)
    }
  }
})
