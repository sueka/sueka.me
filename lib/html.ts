interface DocType {
  name: string
  publicId: string
  systemId: string
}

function tag(doctype: DocType) {
  const tagBuilder: string[] = []

  tagBuilder.push('!DOCTYPE', doctype.name)

  if (doctype.publicId != '') {
    tagBuilder.push('PUBLIC', doctype.publicId)

    if (doctype.systemId != '') {
      tagBuilder.push(doctype.systemId)
    }
  } else if (doctype.systemId != '') {
    tagBuilder.push('SYSTEM', doctype.systemId)
  }

  return `<${ tagBuilder.join(' ') }>`
}

export default function html(doctype: DocType, content: string) {
  return tag(doctype) + '\n' + content
}
