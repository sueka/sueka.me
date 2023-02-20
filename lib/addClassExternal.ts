import { DOMParser, Page, parse } from '../deps.ts'
import html from './html.ts'

const data = parse(await Deno.readTextFile('./src/_data/site.yaml'))

// TODO: Escape を普通の方法で
const internalPat = RegExp(`^(${ data.url.replace('.', '\\.') }\\b|/|\\.|(|about:blank)(\$|#))`)

export default function externalLink(page: Page) {
  const document = new DOMParser().parseFromString(page.content, 'text/html')!
  const links = document.querySelectorAll('a:any-link')

  for (const link of links) {
    if (internalPat.test(link.href)) {
      continue;
    }

    link.classList.add('external')
  }

  page.content = html`
    ${ document.doctype }
    ${ document.documentElement.outerHTML }
  `
}
