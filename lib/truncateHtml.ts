import { truncate } from '../deps.ts'

export default function truncateHtml(safeContent: string, length: number) {
  return truncate(safeContent, length)
}
