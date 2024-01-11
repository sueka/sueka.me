;(() => {
  const observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      if (mutation.type === 'childList') {
        for (const node of mutation.addedNodes) {
          if (node instanceof SVGSVGElement) {
            mutation.target.dataset.intrinsicWidth = node.width.baseVal.value
          }
        }
      }
    }
  })

  window.addEventListener('DOMContentLoaded', () => {
    const mermaids = document.querySelectorAll('.mermaid')

    for (const mermaid of mermaids) {
      observer.observe(mermaid, { childList: true })

      resizeMermaid(mermaid)

      window.addEventListener('resize', () => {
        resizeMermaid(mermaid)
      })
    }
  })

  function resizeMermaid(mermaid) {
    const root = document.querySelector(':root')
    const rem = window.getComputedStyle(root).fontSize

    const svg = mermaid.querySelector('svg')
    const intrinsicWidth = mermaid.dataset.intrinsicWidth

    if (svg === null || intrinsicWidth === undefined) {
      return
    }

    svg.style.width = `calc(${ intrinsicWidth } * ${ rem } / 16)`
  }
})()
