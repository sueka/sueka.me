import jsdom from 'https://jspm.dev/jsdom@20.0.1'
import type { Page } from 'lume/core.ts'

import html from './html.ts'

export default function wrapDiagrams(page: Page) {
  const dom = new jsdom.JSDOM(page.content)
  const diagrams = dom.window.document.querySelectorAll('.mermaid')

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
