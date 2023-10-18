import { Node, Element } from '../deps.ts'

// TODO: Delete
export default function isElement(node: Node): node is Element {
  return node instanceof Element
}
