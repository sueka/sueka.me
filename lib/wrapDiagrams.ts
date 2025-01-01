import { DOMParser } from '@b-fuze/deno-dom'
import { assert } from '@std/assert'
import html from './html.ts'
import isElement from './isElement.ts'

export default function wrapDiagrams(page: Lume.Page) {
  assert(page.content)
  const document = new DOMParser().parseFromString(page.content.toString(), 'text/html')
  assert(document)
  const figures = [...document.querySelectorAll('figure')]
  assert(figures.every(isElement))
  const figuresMermaidWrappers = figures.filter(_ => _.querySelector(':scope > .mermaid') !== null)
  const mermaids = document.querySelectorAll('.mermaid')
  const diagrams = [...figuresMermaidWrappers, ...mermaids]
  // const diagrams = document.querySelectorAll('figure:has(> .mermaid), :not(figure) > .mermaid')

  for (const diagram of diagrams) {
    const diagramClone = diagram.cloneNode(true)
    const wrapper = document.createElement('div')

    wrapper.className = 'diagram-wrapper'
    wrapper.append(diagramClone)

    assert(isElement(diagram))
    diagram.replaceWith(wrapper)
  }

  assert(document.doctype)
  assert(document.documentElement)
  page.content = html(document.doctype, document.documentElement.outerHTML)
}
