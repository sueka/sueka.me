---
---

{ patch, elementOpen, elementOpenStart, elementOpenEnd, elementClose, text, attr } = IncrementalDOM

unless Array::includes
  Object.defineProperty Array::, 'includes',
    value: (searchElement, fromIndex = 0) ->
      throw new TypeError("Cannot read property 'includes' of #{this}") if (this == null)
      fromIndex <= this.indexOf(searchElement)

Element::matches = Element::oMatchesSelector || Element::msMatchesSelector unless Element::matches

array = (arrayLike) -> Array::slice.call(arrayLike)

truncate = (str, length, omission) ->
  if (str.length <= length - omission.length)
    str
  else
    "#{ str.slice(0, length - omission.length).trim() }#{ omission }"

removeTags = (->
  container = document.createElement('div')
  (html) ->
    container.innerHTML = html
    container.textContent
)()

Try = (tryClause) ->
  try
    success = tryClause()
  catch ex
    failure = ex
  { success, failure }

url = new URL(location)

nBytes = (str) ->
  str.split('')
  .map (c) -> c.charCodeAt(0).toString(16).length / 2
  .reduce ((res, x) -> res + x), 0

fetch('/json/posts.json')
.then (response) -> response.json()
.then (posts) ->
  posts.forEach (post) ->
    post.textContent = removeTags(post.content)

  renderSearchResult = ({ q, posts }) ->
    if (q != '')
      { success, failure } = Try () ->
        filterPattern = /// #{q} ///gi
        excerptPattern = /// ^.* (?:#{q}) .*$ ///im
        replacePattern = /// (#{q}) ///gi
        { filterPattern, excerptPattern, replacePattern }
      if success
        { filterPattern, excerptPattern, replacePattern } = success
        posts.map (post) ->
          { title, textContent } = post
          matchRate =
            1 - (1 - nBytes((title.match(filterPattern) || []).join('')) / nBytes(title)) *
                (1 - nBytes((textContent.match(filterPattern) || []).join('')) / nBytes(textContent))
          { post, matchRate }
        .filter ({ matchRate }) -> matchRate > 0
        .sort ({ matchRate: left }, { matchRate: right }) -> right - left
        .forEach ({ post: { url, lang, title, textContent, excerpt } }) ->
          elementOpen('section')
          elementOpen('h3')
          elementOpenStart('a')
          attr('href', url)
          if lang
            attr('lang', lang)
            attr('hreflang', lang)
          elementOpenEnd('a')
          titleExcerptOrNull = excerptPattern.exec(title)
          text(title) unless titleExcerptOrNull
          a = elementClose('a')
          if titleExcerptOrNull
            [matched] = titleExcerptOrNull
            a.innerHTML = matched.replace(replacePattern, "<mark>$1</mark>")
          elementClose('h3')
          elementOpenStart('p', '', ['class', 'search-result-excerpt'])
          attr('lang', lang) if lang # FIXME: ignoring inline lang attributes
          elementOpenEnd('p')
          textContentExcerptOrNull = excerptPattern.exec(textContent)
          text truncate(removeTags(excerpt), 256, ' ...') unless textContentExcerptOrNull
          p = elementClose('p')
          if textContentExcerptOrNull
            [matched] = textContentExcerptOrNull
            p.innerHTML = truncate(matched, 256, ' ...').replace(replacePattern, "<mark>$1</mark>")
          elementClose('section')

  window.addEventListener('input', (event) ->
    if event.target.matches('.search-io > input')
      input = event.target
      output = input.nextElementSibling

      q = input.value

      patch(output, renderSearchResult, { q, posts })

      if q
        url.searchParams.set('q', q)
      else
        url.searchParams.delete('q')

      history.pushState({ q }, "Posts including /#{q}/ - {{ site.title }}", url)
  , false)

  (->
    q = url.searchParams.get('q')

    if !q
      url.searchParams.delete('q')
      history.replaceState({ q }, document.title, url)
    else
      history.replaceState({ q }, "Posts including /#{q}/ - {{ site.title }}", url)

      input = document.querySelector('.search-io > input')
      output = input.nextElementSibling
      input.value = q

      patch(output, renderSearchResult, { q, posts })
  )()

  window.addEventListener('popstate', ({ state: { q } }) ->
    input = document.querySelector('.search-io > input')
    output = input.nextElementSibling
    input.value = q

    patch(output, renderSearchResult, { q, posts })
  , false)
.catch (error) -> throw error
