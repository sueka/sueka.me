import jsdom from 'https://dev.jspm.io/jsdom'

export default function text(safeContent: string) {
  return new jsdom.JSDOM(safeContent).window.document.documentElement.textContent
}
