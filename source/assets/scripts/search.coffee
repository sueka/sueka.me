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
  posts.filter((post) -> patterns.every((pattern) -> pattern.test(post.title) || pattern.test(post.textContent)))

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
        excerptPattern = new RegExp("(?:^|\\n)(.*)(#{q.replace(' ', '|')})(.*)(?:\\n|$)", 'i')

        ul = document.createElement('ul')
        liContainer = document.createDocumentFragment()

        search(searchPatterns, posts).forEach (post) ->
          li = document.createElement('li')
          a = document.createElement('a')
          a.href = post.url
          a.textContent = post.title
          pre = document.createElement('pre')
          if (post.lang)
            a.lang = post.lang
            a.hreflang = post.lang
            pre.lang = post.lang # FIXME: ignoring inline lang attributes
          matches = excerptPattern.exec(post.textContent)
          pre.innerHTML = "#{matches[1]}<mark>#{matches[2]}</mark>#{matches[3]}"

          li.appendChild(a)
          li.appendChild(pre)
          liContainer.appendChild(li)

        ul.appendChild(liContainer)
        div.appendChild(ul)
  , false
.catch (error) -> throw error
