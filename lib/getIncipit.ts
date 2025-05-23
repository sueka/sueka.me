import { DOMParser } from '@b-fuze/deno-dom'

export default function getIncipit(safeContent: string) {
  const document = new DOMParser().parseFromString(safeContent, 'text/html')!
  const incipit = document.querySelector('.incipit')?.textContent

  return incipit
}
