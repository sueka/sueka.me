export default function upright(safeContent: string | number) {
  let result = safeContent.toString() // Support number literal, {{ 12 | v | safe }}

  result = result.replaceAll(/(?<!\d)\d{2}(?!\d)/g, '<span class="tate-chu-yoko">$&</span>')
  result = result.replaceAll(/(?<!\d)\d(?!\d)|\d{3,}/g, '<span class="upright">$&</span>')
  result = result.replace(/^\D+$/, '<span class="upright">$&</span>')

  return result
}
