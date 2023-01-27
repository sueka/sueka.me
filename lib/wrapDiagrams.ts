import jsdom from 'https://jspm.dev/jsdom@20.0.1'
import type { Page } from 'lume/core.ts'

import html from './html.ts'

export default function wrapDiagrams(page: Page) {
  const dom = new jsdom.JSDOM(page.content)
  const figures =
    [...dom.window.document.querySelectorAll('figure')]
    .filter(_ => _.querySelector(':scope > .mermaid') !== null)
  const mermaids = dom.window.document.querySelectorAll('.mermaid')
  const diagrams = [...figures, ...mermaids]
  // const diagrams = dom.window.document.querySelectorAll('figure:has(> .mermaid), :not(figure) > .mermaid')

  for (const diagram of diagrams) {
    const diagramClone = diagram.cloneNode(true)
    const wrapper = dom.window.document.createElement('div')

    wrapper.className = 'diagram-wrapper'
    wrapper.append(diagramClone)

    diagram.replaceWith(wrapper)
  }

  page.content = html`
    ${ dom.window.document.doctype }
    ${ dom.window.document.documentElement.outerHTML }
  `
}
