{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign page-url = page.url | replace: '/index.html', '/' %}
{% assign home-url = '/' | relative_url %}
{% assign about-url = '/about.html' | relative_url %}
{% assign tag-list-url = '/tag-list.html' | relative_url %}
{% assign archives-list-url = '/archives-list.html' | relative_url %}
<header>
  <nav>
    <ul>
      <li><a {% if page-url == home-url %} class="hover-like" {% endif %} href="{{ home-url }}">{{ translation.home }}</a></li>
      <li><a {% if page-url == about-url %} class="hover-like" {% endif %} href="{{ about-url }}">{{ translation.about }}</a></li>
      <li><a {% if page-url == tag-list-url %} class="hover-like" {% endif %} href="{{ tag-list-url }}">{{ translation.tags }}</a></li>
      <li><a {% if page-url == archives-list-url %} class="hover-like" {% endif %} href="{{ archives-list-url }}">{{ translation.archives }}</a></li>
    </ul>
  </nav>
</header>
<div class="scroll-indicator"></div>
