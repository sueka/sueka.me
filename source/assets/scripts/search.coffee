---
---

unless Array::includes
  Object.defineProperty Array::, 'includes',
    value: (searchElement, fromIndex = 0) ->
      throw new TypeError("Cannot read property 'includes' of #{this}") if (this == null)
      fromIndex <= this.indexOf(searchElement)

array = (arrayLike) -> Array::slice.call(arrayLike)

search = (patterns, posts) ->
  posts.filter ({ title, textContent }) ->
    patterns.every (pattern) -> pattern.test(title) || pattern.test(textContent)

input = array document.querySelectorAll('input[name=q]')

fetch('/json/posts.json')
.then (response) -> response.json()
.then (posts) ->
  container = document.createElement('div')
  posts.forEach (post) ->
    container.innerHTML = post.content
    post.textContent = container.textContent

  window.addEventListener 'keyup', (event) ->
    if (input.includes event.target)
      q = event.target.value

      div = event.target.parentNode.querySelector('.search-result')
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
          li = document.createElement('li')
          a = document.createElement('a')
          a.href = post.url
          a.textContent = post.title
          pre = document.createElement('pre')
          if (post.lang)
            a.lang = post.lang
            a.hreflang = post.lang
            pre.lang = post.lang # FIXME: ignoring inline lang attributes
          optionalMatches = excerptPattern.exec(post.textContent)
          pre.innerHTML =
            if optionalMatches
              optionalMatches[0].replace(replacePattern, "<mark>$1</mark>")
            else
              ''

          li.appendChild(a)
          li.appendChild(pre)
          liContainer.appendChild(li)

        ul.appendChild(liContainer)
        div.appendChild(ul)
  , false
.catch (error) -> throw error
