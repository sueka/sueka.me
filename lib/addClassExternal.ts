import jsdom from 'https://jspm.dev/jsdom@20.0.1'
import type { Page } from 'lume/core.ts'
import { parse } from '../deps.ts'

import html from './html.ts'

const data = parse(await Deno.readTextFile('./src/_data/site.yaml'))

// TODO: Escape を普通の方法で
const internalPat = RegExp(`^(${ data.url.replace('.', '\\.') }\\b|/|\\.|(|about:blank)(\$|#))`)

export default function externalLink(page: Page) {
  const dom = new jsdom.JSDOM(page.content)
  const links = dom.window.document.querySelectorAll('a:any-link')

  for (const link of links) {
    if (internalPat.test(link.href)) {
      continue;
    }

    link.classList.add('external')
  }

  page.content = html`
    ${ dom.window.document.doctype }
    ${ dom.window.document.documentElement.outerHTML }
  `
}
