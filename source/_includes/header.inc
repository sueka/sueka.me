{% assign include-lang = include.lang | default: page-lang %}
<header>
  {% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
  {% case include-lang %}
  {% when 'en' %}
    {% assign home-path = '/' %}
    {% assign about-me-path = '/about-me.html' %}
    {% assign about-me-anchor-text = 'About me' %}
  {% when 'he' %}
    {% assign home-path = '/index.he.html' %}
    {% assign about-me-path = '/about-me.he.html' %}
    {% assign about-me-anchor-text = 'עליי' %}
  {% when 'ja' %}
    {% assign home-path = '/index.ja.html' %}
    {% assign about-me-path = '/about-me.ja.html' %}
    {% assign about-me-anchor-text = '作者について' %}
  {% endcase %}
  <h1 class="home">
    <a href="{{ home-path | relative_url }}">
      <img alt="home" width="24" height="24" src="{{ 'assets/images/favicon.svg' | relative_url }}" />
    </a>
  </h1>
  <nav>
    <ul>
      <li><a href="{{ about-me-path | relative_url }}">{{ about-me-anchor-text }}</a></li>
      <li><a href="{{ '/tag-list.html' | relative_url }}">{{ translation.tags }}</a></li>
      <li><a href="{{ '/archives-list.html' | relative_url }}">{{ translation.archives }}</a></li>
    </ul>
  </nav>
</header>
