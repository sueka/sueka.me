---
url: /assets/scripts/main.js
templateEngine: njk
---

window.addEventListener('touchstart', () => {})

import('https://ga.jspm.io/npm:bowser@2.11.0/es5.js').then(({ default: Bowser }) => {
  const browser = Bowser.getParser(navigator.userAgent)

  const isGecko = browser.isEngine('Gecko')
  const isBlink = browser.isEngine('Blink')

  const linkToVerticalCss = document.querySelector('link[href$="{{ '~/vertical.css' | url }}"]')

  if (linkToVerticalCss === null) {
    return
  }

  if (isGecko) {
    const linkToVerticalGeckoCss = linkToVerticalCss.cloneNode()

    linkToVerticalGeckoCss.href = '{{ '~/vertical-gecko.css' | url(true) }}'

    document.head.insertBefore(linkToVerticalGeckoCss, linkToVerticalCss.nextSibling)
  }

  if (isBlink) {
    const linkToVerticalBlinkCss = linkToVerticalCss.cloneNode()

    linkToVerticalBlinkCss.href = '{{ '~/vertical-blink.css' | url(true) }}'

    document.head.insertBefore(linkToVerticalBlinkCss, linkToVerticalCss.nextSibling)
  }
})
