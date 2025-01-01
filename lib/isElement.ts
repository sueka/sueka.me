import { Node, Element } from '@b-fuze/deno-dom'

// TODO: Delete
export default function isElement(node: Node): node is Element {
  return node instanceof Element
}
