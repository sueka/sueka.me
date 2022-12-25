import jsdom from 'https://jspm.dev/jsdom@20.0.1'
import type { Page } from 'lume/core.ts'

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

// TODO: Remove them
interface DocType {
  name: string
  publicId: string
  systemId: string
}

function tag(doctype: DocType) {
  let tagBuilder: string[] = []

  tagBuilder.push('!DOCTYPE', doctype.name)

  if (doctype.publicId != '') {
    tagBuilder.push('PUBLIC', doctype.publicId)

    if (doctype.systemId != '') {
      tagBuilder.push(doctype.systemId)
    }
  } else if (doctype.systemId != '') {
    tagBuilder.push('SYSTEM', doctype.systemId)
  }

  return `<${ tagBuilder.join(' ') }>`
}

function html(_strings: TemplateStringsArray, doctype: DocType, content: string) {
  return tag(doctype) + '\n' + content
}
