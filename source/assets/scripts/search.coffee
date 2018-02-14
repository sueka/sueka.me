---
---

if (!Array.prototype.includes)
  Object.defineProperty Array.prototype, 'includes', {
    value: (searchElement, fromIndex = 0) ->
      if (this == null)
        throw new TypeError("Cannot read property 'includes' of #{this}")

      fromIndex <= this.indexOf(searchElement)
  }

array = (arrayLike) ->
  Array.prototype.slice.call(arrayLike)

search = (patterns, posts) ->
  posts.filter((post) -> patterns.every((pattern) -> pattern.test(post.textContent)))

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
        searchPatterns = q.split(' ').map((query) -> new RegExp(query, 'i'))
        # exceprtPattern = new RegExp('(?:[^>](?!<))+' + q.replace(' ', '|') + '[^<]+(?:</)', 'i')

        ul = document.createElement('ul')
        liContainer = document.createDocumentFragment()

        search(searchPatterns, posts).forEach (post) ->
          li = document.createElement('li')
          a = document.createElement('a')
          a.href = post.url
          a.lang = post.lang
          a.hreflang = post.lang
          a.textContent = post.title
          # div = document.createElement('div')
          #     div.innerHTML = exceprtPattern.exec(post.content)[0]

          li.appendChild(a)
          liContainer.appendChild(li)

        ul.appendChild(liContainer)
        div.appendChild(ul)
  , false
.catch (error) -> throw error
