import { DOMParser } from '@b-fuze/deno-dom'
import { assert } from '@std/assert'
import html from './html.ts'
import isElement from './isElement.ts'

export default function wrapTables(page: Lume.Page) {
  assert(page.content)
  const document = new DOMParser().parseFromString(page.content.toString(), 'text/html')
  assert(document)
  const tables = document.querySelectorAll('table')

  for (const table of tables) {
    const tableClone = table.cloneNode(true)
    const wrapper = document.createElement('div')

    wrapper.className = 'table-wrapper'
    wrapper.append(tableClone)

    assert(isElement(table))
    table.replaceWith(wrapper)
  }

  assert(document.doctype)
  assert(document.documentElement)
  page.content = html(document.doctype, document.documentElement.outerHTML)
}
