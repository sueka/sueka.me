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

search = (patterns, posts) ->
  posts.filter ({ title, textContent }) ->
    patterns.every (pattern) -> pattern.test(title) || pattern.test(textContent)

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

renderResultItem = (excerptPattern, replacePattern, { url, title, lang = undefined, textContent, excerpt }) ->
  () ->
    elementOpen('li')
    elementOpenStart('a')
    attr('href', url)
    if lang
      attr('lang', lang)
      attr('hreflang', lang)
    elementOpenEnd('a')
    text(title)
    elementClose('a')
    pre = elementOpenStart('pre')
    attr('lang', lang) if lang # FIXME: ignoring inline lang attributes
    elementOpenEnd('pre')
    matchedsOrNull = excerptPattern.exec(textContent)
    text truncate(removeTags(excerpt), 256, ' ...') unless matchedsOrNull
    pre = elementClose('pre')
    if matchedsOrNull
      [matched] = matchedsOrNull
      pre.innerHTML = truncate(matched, 256, ' ...').replace(replacePattern, "<mark>$1</mark>")
    elementClose('li')

fetch('/json/posts.json')
.then (response) -> response.json()
.then (posts) ->
  posts.forEach (post) ->
    post.textContent = removeTags(post.content)
  window.addEventListener('keyup', (event) ->
    if event.target.matches('.search-io > input')
      input = event.target
      q = input.value
      div = input.parentNode.querySelector('div')
      patch(div, ({ q }) ->
        if (q != '')
          { success, failure } = Try () ->
            filterPatterns = [/// #{q} ///i]
            excerptPattern = /// ^.* (?:#{q}) .*$ ///im
            replacePattern = /// (#{q}) ///gi
            { filterPatterns, excerptPattern, replacePattern }
          if success
            { filterPatterns, excerptPattern, replacePattern } = success
            elementOpen('ul')
            search(filterPatterns, posts).forEach (post) ->
              renderResultItem(excerptPattern, replacePattern, post)()
            elementClose('ul')
      , { q })
  , false)
.catch (error) -> throw error
