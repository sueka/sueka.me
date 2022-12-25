import jsdom from 'https://jspm.dev/jsdom@20.0.1'

export default function getIncipit(safeContent: string) {
  const dom = new jsdom.JSDOM(safeContent)

  const incipit = dom.window.document.querySelector('.incipit').textContent

  return incipit
}
