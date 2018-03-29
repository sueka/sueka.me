---
---

{ patch, elementOpen, elementOpenStart, elementOpenEnd, elementClose, text, attr } = IncrementalDOM

unless Array::includes
  Object.defineProperty Array::, 'includes',
    value: (searchElement, fromIndex = 0) ->
      throw new TypeError "Cannot read property 'includes' of #{this}" if this == null
      fromIndex <= this.indexOf searchElement

Element::matches = Element::oMatchesSelector || Element::msMatchesSelector unless Element::matches

truncate = (str, length, omission) ->
  if str.length <= length - omission.length
    str
  else
    "#{ str.slice(0, length - omission.length).trim() }#{ omission }"

removeTags = (->
  container = document.createElement 'div'
  (html) ->
    container.innerHTML = html
    container.textContent
)()

try_ = (errorClass, tryClause) ->
  try
    right = tryClause()
  catch ex
    if ex instanceof errorClass
      left = ex
    else
      throw ex
  { left, right }

class BreakingError extends Error

breakable = (procedure) ->
  try
    procedure()
  catch ex
    throw ex unless ex instanceof BreakingError
  true

break_ = () -> throw new BreakingError

unless String::byteLength
  Object.defineProperty String::, 'byteLength',
    enumerable: true
    get: () ->
      this.split ''
      .map (c) -> c.charCodeAt(0).toString(16).length / 2
      .reduce ((res, x) -> res + x), 0

if window.URLSearchParams
  URLSearchParams = window.URLSearchParams
  URL = window.URL
else
  class URLSearchParams
    _urlSearchParams = null

    convertSearchStringToMap = (searchString) ->
      searchMap = new Map
      searchString.replace(/^\?/, '').split('&')
      .map (kv) -> kv.split '='
      .forEach ([key, value = '']) ->
        if key
          searchMap.set key, value
      searchMap

    convertSearchMapToString = (searchMap) ->
      searchString = ''
      searchMap.forEach (value, key) ->
        searchString += "&#{key}=#{value}"
      searchString.replace /^&/, '?'

    constructor: (search) ->
      _urlSearchParams = convertSearchStringToMap search

    get: (key) ->
      value = _urlSearchParams.get key
      if value == undefined
        null
      else
        value

    set: (key, value) ->
      _urlSearchParams.set key, value

    delete: (key) ->
      _urlSearchParams.delete key

    toString: ->
      convertSearchMapToString _urlSearchParams

  class URL
    _location = null

    constructor: (location) ->
      _location = location
      @searchParams = new URLSearchParams _location.search

    toString: ->
      userinfo =
        if _location.username and _location.password
          "#{_location.username}:#{_location.password}"
        else
          ''
      authority =
        if userinfo
          "#{userinfo}@#{_location.host}"
        else
          "#{_location.host}"
      "#{_location.protocol}//#{authority}#{_location.pathname}#{@searchParams}#{_location.hash}"

rendering = false
inputting = false

fetch '/json/posts.json'
.then (response) -> response.json()
.then (posts) ->
  posts.forEach (post) ->
    post.textContent = removeTags(post.content).replace(/ {2,}/g, ' ').replace /^ | $/gm, ''

  url = new URL location

  filterAndSort = ({ posts, q }) ->
    { _: left, right } = try_ SyntaxError, () ->
      filterPattern: /// #{q} ///gim

    if right
      { filterPattern } = right

      posts.map (post) ->
        { title, textContent } = post
        matchRate =
          1 - (1 - (title.match(filterPattern) || []).join('').byteLength / title.byteLength) *
              (1 - (textContent.match(filterPattern) || []).join('').byteLength / textContent.byteLength)
        { post, matchRate }
      .filter ({ matchRate }) -> matchRate > 0
      .sort ({ matchRate: left }, { matchRate: right }) -> right - left
      .map ({ post }) -> post
    else
      []

  render = ({ posts, q }) ->
    rendering = true

    { _: left, right } = try_ SyntaxError, () ->
      excerptPattern: /// ^.* (?:#{q}) .*$ ///im
      replacePattern: /// (#{q}) ///gi

    if right
      { excerptPattern, replacePattern } = right

      breakable () ->
        posts.forEach ({ url, lang = "{{ site.lang }}", title, textContent, excerpt }) ->
          break_() if inputting and rendering

          elementOpen 'section'
          elementOpen 'h3'
          elementOpenStart 'a'
          attr 'href', url
          if lang != document.documentElement.lang
            attr 'lang', lang
            attr 'hreflang', lang
          elementOpenEnd 'a'
          titleExcerptOrNull = excerptPattern.exec title
          text title unless titleExcerptOrNull
          a = elementClose 'a'
          if titleExcerptOrNull
            [matched] = titleExcerptOrNull
            a.innerHTML = matched.replace replacePattern, '<mark>$1</mark>'
          elementClose 'h3'
          elementOpenStart 'p', '', ['class', 'search-result-excerpt']
          attr 'lang', lang if lang != document.documentElement.lang # FIXME: ignoring inline lang attributes
          elementOpenEnd 'p'
          textContentExcerptOrNull = excerptPattern.exec textContent
          text truncate removeTags(excerpt), 256, ' ...' unless textContentExcerptOrNull
          p = elementClose 'p'
          if textContentExcerptOrNull
            [matched] = textContentExcerptOrNull
            p.innerHTML = truncate(matched, 256, ' ...\n').replace replacePattern, '<mark>$1</mark>'
          elementClose 'section'

    rendering = false

  window.addEventListener 'input', (event) ->
    if event.target.matches '.search-io > input'
      inputting = true

      input = event.target
      output = input.parentElement.querySelector 'output'

      q = input.value

      if !q
        url.searchParams.delete 'q'
        history.pushState { q }, document.title, url
      else
        url.searchParams.set 'q', q
        history.pushState { q }, "Posts including /#{q}/ - {{ site.title }}", url

      filteredPosts = filterAndSort { posts, q }
      patch output, render, { posts: filteredPosts, q }

      inputting = false
  , false

  (->
    q = url.searchParams.get 'q'

    if !q
      url.searchParams.delete 'q'
      history.replaceState { q }, document.title, url
    else
      history.replaceState { q }, "Posts including /#{q}/ - {{ site.title }}", url

      input = document.querySelector '.search-io > input'
      output = input.nextElementSibling
      input.value = q

      filteredPosts = filterAndSort { posts, q }
      patch output, render, { posts: filteredPosts, q }
  )()

  window.addEventListener 'popstate', ({ state: { q } }) ->
    input = document.querySelector '.search-io > input'
    output = input.nextElementSibling
    input.value = q

    filteredPosts = filterAndSort { posts, q }
    patch output, render, { posts: filteredPosts, q }
  , false
.catch (error) -> throw error
