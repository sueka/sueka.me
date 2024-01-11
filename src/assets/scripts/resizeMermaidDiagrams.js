;(() => {
  const observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      if (mutation.type === 'childList') {
        for (const node of mutation.addedNodes) {
          if (node instanceof SVGSVGElement) {
            resizeMermaid(node)

            window.addEventListener('resize', () => {
              resizeMermaid(node)
            })
          }
        }
      }
    }
  })

  window.addEventListener('DOMContentLoaded', () => {
    const mermaids = document.querySelectorAll('.mermaid')

    for (const mermaid of mermaids) {
      observer.observe(mermaid, { childList: true })
    }
  })

  function resizeMermaid(svg) {
    const root = document.querySelector(':root')
    const rem = window.getComputedStyle(root).fontSize

    const intrinsicWidth = svg.width.baseVal.value

    if (intrinsicWidth === undefined) {
      return
    }

    svg.style.width = `calc(${ intrinsicWidth } * ${ rem } / 16)`
  }
})()
