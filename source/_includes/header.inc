{% assign include-lang = include.lang | default: page-lang %}
<header>
  {% case include-lang %}
  {% when 'he' %}
    <h1 class="home">
      <a href="{{ '/index.he.html' | relative_url }}">
        <img alt="home" width="24" height="24" src="{{ 'assets/images/favicon.svg' | relative_url }}" />
      </a>
    </h1>
    <nav>
      <ul>
        <li><a href="{{ "/about-me.he.html" | relative_url }}">עליי</a></li>
        <li><a href="{{ "/tag-list.html" | relative_url }}" hreflang="{{ site.lang }}">תגים</a></li>
        <li><a href="{{ "/archives-list.html" | relative_url }}" hreflang="{{ site.lang }}">ארכיון</a></li>
      </ul>
    </nav>
  {% when 'ja' %}
    <h1 class="home">
      <a href="{{ '/index.ja.html' | relative_url }}">
        <img alt="home" width="24" height="24" src="{{ 'assets/images/favicon.svg' | relative_url }}" />
      </a>
    </h1>
    <nav>
      <ul>
        <li><a href="{{ '/about-me.ja.html' | relative_url }}">作者について</a></li>
        <li><a href="{{ '/tag-list.html' | relative_url }}" hreflang="{{ site.lang }}">タグ</a></li>
        <li><a href="{{ '/archives-list.html' | relative_url }}" hreflang="{{ site.lang }}">アーカイブ</a></li>
      </ul>
    </nav>
  {% else %}
    <h1 class="home">
      <a href="{{ '/' | relative_url }}">
        <img alt="home" width="24" height="24" src="{{ 'assets/images/favicon.svg' | relative_url }}" />
      </a>
    </h1>
    <nav>
      <ul>
        <li><a href="{{ '/about-me.html' | relative_url }}">About me</a></li>
        <li><a href="{{ '/tag-list.html' | relative_url }}">Tags</a></li>
        <li><a href="{{ '/archives-list.html' | relative_url }}">Archives</a></li>
      </ul>
    </nav>
  {% endcase %}
</header>
