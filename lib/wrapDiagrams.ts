import { Page, DOMParser } from '../deps.ts'
import html from './html.ts'

export default function wrapDiagrams(page: Page) {
  const document = new DOMParser().parseFromString(page.content, 'text/html')!
  const figures =
    [...document.querySelectorAll('figure')]
    .filter(_ => _.querySelector(':scope > .mermaid') !== null)
  const mermaids = document.querySelectorAll('.mermaid')
  const diagrams = [...figures, ...mermaids]
  // const diagrams = document.querySelectorAll('figure:has(> .mermaid), :not(figure) > .mermaid')

  for (const diagram of diagrams) {
    const diagramClone = diagram.cloneNode(true)
    const wrapper = document.createElement('div')

    wrapper.className = 'diagram-wrapper'
    wrapper.append(diagramClone)

    diagram.replaceWith(wrapper)
  }

  page.content = html`
    ${ document.doctype }
    ${ document.documentElement.outerHTML }
  `
}
