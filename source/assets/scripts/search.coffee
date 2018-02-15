---
---

unless Array::includes
  Object.defineProperty Array::, 'includes',
    value: (searchElement, fromIndex = 0) ->
      throw new TypeError("Cannot read property 'includes' of #{this}") if (this == null)
      fromIndex <= this.indexOf(searchElement)

Element::matches = Element::oMatchesSelector || Element::msMatchesSelector unless Element::matches

array = (arrayLike) -> Array::slice.call(arrayLike)

search = (patterns, posts) ->
  posts.filter ({ title, textContent }) ->
    patterns.every (pattern) -> pattern.test(title) || pattern.test(textContent)

removeTags = (->
  container = document.createElement('div')
  (html) ->
    container.innerHTML = html
    container.textContent
)()

resultItem = (excerptPattern, replacePattern, { url, title, lang = undefined, textContent }) ->
  li = document.createElement('li')
  a = document.createElement('a')
  pre = document.createElement('pre')
  a.href = url
  a.textContent = title

  if (lang)
    a.lang = lang
    a.hreflang = lang
    pre.lang = lang # FIXME: ignoring inline lang attributes

  matchedsOrNull = excerptPattern.exec(textContent)
  pre.innerHTML =
    if matchedsOrNull != null
      [matched] = matchedsOrNull
      matched.replace(replacePattern, "<mark>$1</mark>")
    else
      ''
  li.appendChild(a)
  li.appendChild(pre)
  li

fetch('/json/posts.json')
.then (response) -> response.json()
.then (posts) ->
  container = document.createElement('div')
  posts.forEach (post) ->
    container.innerHTML = post.content
    post.textContent = container.textContent

  window.addEventListener('keyup', (event) ->
    if event.target.matches('.search-io > input')
      input = event.target
      q = input.value.trim().replace(/\s+/g, ' ')
      div = input.parentNode.querySelector('div')
      div.innerHTML = ''

      if (q != '')
        filterPatterns = q.split(' ').map((query) -> new RegExp(query, 'i'))
        findPatternString = q.trim().replace(/ /g, '|')
        excerptPattern = ///
          ^.*
          (?:#{findPatternString})
          .*$
        ///im

        replacePattern = ///
          (#{findPatternString})
        ///gi

        ul = document.createElement('ul')
        liContainer = document.createDocumentFragment()

        search(filterPatterns, posts).forEach (post) ->
          liContainer.appendChild resultItem(excerptPattern, replacePattern, post)
        ul.appendChild(liContainer)
        div.appendChild(ul)
  , false)
.catch (error) -> throw error
