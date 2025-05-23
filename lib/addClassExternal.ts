import { DOMParser } from '@b-fuze/deno-dom'
import { assert } from '@std/assert'
import { parse } from '@std/yaml'
import html from './html.ts'
import isElement from './isElement.ts'

const data = parse(await Deno.readTextFile('./src/_data/site.yaml'))

// TODO: Escape を普通の方法で
assert(
  typeof data === 'object' && data !== null && 'url' in data &&
  typeof data.url === 'string'
)
const internalPat = RegExp(`^(?:${ data.url.replace('.', '\\.') }\\b|(?!https?:\/\/))`)

export default function externalLink(page: Lume.Page) {
  assert(page.content)
  const document = new DOMParser().parseFromString(page.content.toString(), 'text/html')
  assert(document)
  const links = document.querySelectorAll('a:any-link')

  for (const link of links) {
    assert(isElement(link))

    // NOTE: 恐らく deno_dom の仕様で、link.getAttribute('href') は link.href 相当のもの（実際の href 属性の値がパスであっても、URL）を返す。
    if (internalPat.test(link.getAttribute('href')!)) {
      continue;
    }

    link.classList.add('external')
  }

  assert(document.doctype)
  assert(document.documentElement)
  page.content = html(document.doctype, document.documentElement.outerHTML)
}
