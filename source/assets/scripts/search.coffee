---
---

{ patch, elementOpen, elementOpenStart, elementOpenEnd, elementClose, elementVoid, text, attr } = IncrementalDOM

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

fetch('/json/posts.json')
.then (response) -> response.json()
.then (posts) ->
  posts.forEach (post) ->
    post.textContent = removeTags(post.content)
  window.addEventListener('keyup', (event) ->
    if event.target.matches('.search-io > input')
      input = event.target
      output = input.nextElementSibling
      q = input.value

      patch(output, ({ q, posts }) ->
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
                1 - (1 - (title.match(filterPattern) || []).join('').length / title.length) *
                    (1 - (textContent.match(filterPattern) || []).join('').length / textContent.length)
              { post, matchRate }
            .filter ({ matchRate }) -> matchRate > 0
            .sort ({ matchRate: left }, { matchRate: right }) -> right - left
            .forEach ({ post: { url, lang, title, textContent, excerpt } }) ->
              elementOpen('section')
              elementOpen('h6')
              elementOpenStart('a')
              attr('href', url)
              if lang
                attr('lang', lang)
                attr('hreflang', lang)
              elementOpenEnd('a')
              text(title)
              elementClose('a')
              elementClose('h6')
              elementOpenStart('p', '', ['class', 'search-result-excerpt'])
              attr('lang', lang) if lang # FIXME: ignoring inline lang attributes
              elementOpenEnd('p')
              matchedsOrNull = excerptPattern.exec(textContent)
              if matchedsOrNull
                p = elementClose('p')
                [matched] = matchedsOrNull
                p.innerHTML = truncate(matched, 256, ' ...').replace(replacePattern, "<mark>$1</mark>")
              else
                text truncate(removeTags(excerpt), 256, ' ...')
                elementClose('p')
              elementClose('section')
      , { q, posts })
  , false)
.catch (error) -> throw error
