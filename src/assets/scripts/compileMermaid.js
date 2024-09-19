// Mermaid の theme をカラースキームに合わせて切り替える。 https://github.com/mermaid-js/mermaid/issues/1945#issuecomment-1661264708 を参考にした。
;(() => {
  const compileMermaid = (() => {
    let mermaid // memo

    return async (selector, config) => {
      if (mermaid === undefined) {
        ;({ default: mermaid } = await import('https://cdnjs.cloudflare.com/ajax/libs/mermaid/10.9.1/mermaid.esm.min.mjs'))
      }

      mermaid.initialize({
        startOnLoad: false,
        flowchart: {
          useMaxWidth: false,
        },
        ...config
      })

      mermaid.run({
        querySelector: selector,
      })
    }
  })()

  window.addEventListener('DOMContentLoaded', () => {
    const mermaids = document.querySelectorAll('.mermaid')
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)')

    for (const mermaid of mermaids) {
      mermaid.dataset.mmd = mermaid.innerHTML
    }

    compileMermaid('.mermaid', {
      theme: prefersDark.matches ? 'dark' : 'default',
      darkMode: prefersDark.matches,
    })

    prefersDark.addEventListener('change', (event) => {
      for (const mermaid of mermaids) {
        mermaid.innerHTML = mermaid.dataset.mmd
        delete mermaid.dataset.processed
      }

      compileMermaid('.mermaid', {
        theme: event.matches ? 'dark' : 'default',
        darkMode: event.matches,
      })
    })
  })
})()
