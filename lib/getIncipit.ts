import { jsdom } from '../deps.ts'

export default function getIncipit(safeContent: string) {
  const dom = new jsdom.JSDOM(safeContent)

  const incipit = dom.window.document.querySelector('.incipit').textContent

  return incipit
}
