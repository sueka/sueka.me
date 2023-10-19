import truncate from 'html-truncator'

export default function truncateHtml(safeContent: string, length: number) {
  return truncate(safeContent, length)
}
