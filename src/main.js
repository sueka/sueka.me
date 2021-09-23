---
url: /assets/scripts/main.js
templateEngine: njk
---

window.addEventListener('touchstart', () => {})

function loadStylesheet(href, options) {
  const link = document.createElement('link')

  link.rel = 'stylesheet'
  link.href = href
  link.media = options?.media

  document.head.insertBefore(link, null)
}

// TODO:
import('https://ga.jspm.io/npm:bowser@2.11.0/es5.js').then(({ default: Bowser }) => {
  const browser = Bowser.getParser(navigator.userAgent)

  const isFirefox = browser.is('Firefox')
  const isChrome = browser.is('Chrome')

  if (isFirefox) {
    loadStylesheet('{{ '~/gecko.css' | url(true) }}', {
      media: '(min-height: 526px)', // Same as the link to vertical.css
    })
  }

  if (isChrome) {
    loadStylesheet('{{ '~/blink.css' | url(true) }}', {
      media: '(min-height: 526px)', // Same as the link to vertical.css
    })
  }
})
