function findRecur(needle: number, haystack: number[]): boolean {
  if (haystack.length === 0) {
    return false
  }

  const [head, ...tail] = haystack

  if (needle === head) {
    return true
  }

  return findRecur(needle, tail)
}
