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
  {% assign about-me-url = about-me-path | relative_url %}
  {% assign tag-list-url = '/tag-list.html' | relative_url %}
  {% assign archives-list-url = '/archives-list.html' | relative_url %}
  {% assign search-url = '/search.html' | relative_url %}
  <h1 class="home">
    <a href="{{ home-path | relative_url }}">
      <img alt="home" width="24" height="24" src="{{ 'assets/images/favicon.svg' | relative_url }}" />
    </a>
  </h1>
  <nav>
    <ul>
      <li><a {% if page.url == about-me-url %} class="hover-like" {% endif %} href="{{ about-me-url }}">{{ about-me-anchor-text }}</a></li>
      <li><a {% if page.url == tag-list-url %} class="hover-like" {% endif %} href="{{ tag-list-url }}">{{ translation.tags }}</a></li>
      <li><a {% if page.url == archives-list-url %} class="hover-like" {% endif %} href="{{ archives-list-url }}">{{ translation.archives }}</a></li>
      <li><a {% if page.url == search-url %} class="hover-like" {% endif %} href="{{ search-url }}">{{ translation.search }}</a></li>
    </ul>
  </nav>
</header>
<div class="scroll-indicator"></div>
