import truncate from 'truncate-html'

export default function truncateHtml(safeContent: string, length: number) {
  // @ts-expect-error: TS2349; truncate-html default-exports truncate().
  return truncate(safeContent, length)
}
