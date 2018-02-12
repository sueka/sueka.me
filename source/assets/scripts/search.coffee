---
---

array = (arrayLike) ->
  Array.prototype.slice.call(arrayLike)

search = (patterns, posts) ->
  posts.filter((post) -> patterns.every((pattern) -> pattern.test(post.content)))

input = array document.querySelectorAll('input[name=q]')

fetch('/json/posts.json').then((response) -> response.json()).then (posts) ->
  addEventListener 'keyup', (event) ->
    if (input.includes event.target)
      q = event.target.value

      div = event.target.parentNode.querySelector('.search-result')
      div.innerHTML = ''

      if (q != '')
        searchPatterns = q.split(' ').map((query) -> new RegExp(query, 'i'))

        ul = document.createElement('ul')
        liContainer = document.createDocumentFragment()

        search(searchPatterns, posts).forEach (post) ->
          li = document.createElement('li')
          a = document.createElement('a')
          a.href = post.url
          a.lang = post.lang
          a.hreflang = post.lang
          a.textContent = post.title

          li.appendChild(a)
          liContainer.appendChild(li)

        ul.appendChild(liContainer)
        div.appendChild(ul)
