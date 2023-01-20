import jsdom from 'https://jspm.dev/jsdom@20.0.1'
import type { Page } from 'lume/core.ts'

import html from './html.ts'

export default function wrapTables(page: Page) {
  const dom = new jsdom.JSDOM(page.content)
  const tables = dom.window.document.querySelectorAll('table')

  for (const table of tables) {
    const tableClone = table.cloneNode(true)
    const wrapper = dom.window.document.createElement('div')

    wrapper.className = 'table-wrapper'
    wrapper.append(tableClone)

    table.replaceWith(wrapper)
  }

  page.content = html`
    ${ dom.window.document.doctype }
    ${ dom.window.document.documentElement.outerHTML }
  `
}
