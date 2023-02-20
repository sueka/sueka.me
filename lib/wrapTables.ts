import { Page, DOMParser } from '../deps.ts'
import html from './html.ts'

export default function wrapTables(page: Page) {
  const document = new DOMParser().parseFromString(page.content, 'text/html')!
  const tables = document.querySelectorAll('table')

  for (const table of tables) {
    const tableClone = table.cloneNode(true)
    const wrapper = document.createElement('div')

    wrapper.className = 'table-wrapper'
    wrapper.append(tableClone)

    table.replaceWith(wrapper)
  }

  page.content = html`
    ${ document.doctype }
    ${ document.documentElement.outerHTML }
  `
}
