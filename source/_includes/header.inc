{% assign lang = include.lang | default: page.lang | default: site.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% case lang %}
{% when 'en' %}
  {% assign home-path = '/' %}
  {% assign about-path = '/about.html' %}
  {% assign about-anchor-text = 'About' %}
{% when 'ja' %}
  {% assign home-path = '/index.ja.html' %}
  {% assign about-path = '/about.ja.html' %}
  {% assign about-anchor-text = 'About' %}
{% endcase %}
{% assign about-url = about-path | relative_url %}
{% assign tag-list-url = '/tag-list.html' | relative_url %}
{% assign archives-list-url = '/archives-list.html' | relative_url %}
{% assign search-url = '/search.html' | relative_url %}
<header>
  <h1 class="home">
    <a href="{{ home-path | relative_url }}">
      <img alt="home" width="24" height="24" src="{{ 'assets/images/favicon.svg' | relative_url }}" />
    </a>
  </h1>
  <nav>
    <ul>
      <li><a {% if page.url == about-url %} class="hover-like" {% endif %} href="{{ about-url }}">{{ about-anchor-text }}</a></li>
      <li><a {% if page.url == tag-list-url %} class="hover-like" {% endif %} href="{{ tag-list-url }}">{{ translation.tags }}</a></li>
      <li><a {% if page.url == archives-list-url %} class="hover-like" {% endif %} href="{{ archives-list-url }}">{{ translation.archives }}</a></li>
      <li><a {% if page.url == search-url %} class="hover-like" {% endif %} href="{{ search-url }}">{{ translation.search }}</a></li>
    </ul>
  </nav>
</header>
<div class="scroll-indicator"></div>
