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
    elementOpenStart('pre')
    attr('lang', lang) if lang
    pre = elementVoid 'pre', ['lang', lang] # FIXME: ignoring inline lang attributes
    matchedsOrNull = excerptPattern.exec(textContent)
    pre.innerHTML =
      if matchedsOrNull
        [matched] = matchedsOrNull
        truncate(matched, 256, ' ...').replace(replacePattern, "<mark>$1</mark>")
      else
        truncate(removeTags(excerpt), 256, ' ...')
    pre
    elementClose 'li'

fetch('/json/posts.json')
.then (response) -> response.json()
.then (posts) ->
  posts.forEach (post) ->
    post.textContent = removeTags(post.content)
  window.addEventListener('keyup', (event) ->
    if event.target.matches('.search-io > input')
      input = event.target
      q = input.value.trim().replace(/\s+/g, ' ')
      div = input.parentNode.querySelector('div')
      patch(div, ({ q }) ->
        if (q != '')
          findPatternString = q.replace(/ /g, '|')
          filterPatterns = q.split(' ').map (query) -> /// #{query} ///i
          excerptPattern = /// ^.* (?:#{findPatternString}) .*$ ///im
          replacePattern = /// (#{findPatternString}) ///gi
          elementOpen('ul')
          search(filterPatterns, posts).forEach (post) ->
            renderResultItem(excerptPattern, replacePattern, post)()
          elementClose('ul')
      , { q })
  , false)
.catch (error) -> throw error
