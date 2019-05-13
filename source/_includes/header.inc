{% assign lang = include.lang | default: page.lang %}
{% assign hovered = include.hovered | default: page.header-hovered %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign page-url = page.url | replace: '/index.html', '/' %}
{% assign home-url = '/' | relative_url %}
{% assign about-url = '/about.html' | relative_url %}
{% assign tag-list-url = '/tag-list.html' | relative_url %}
{% assign archives-url = '/archives.html' | relative_url %}
<header class="header">
  <nav class="header-nav">
    <ul class="header-nav-list">
      <li class="header-nav-list-item">
        <a 
          {% if hovered == 'home' %} class="hover-like" {% endif %}
          href="{{ home-url }}"
        >
          {{ translation.home }}
        </a>
      </li>
      <li class="header-nav-list-item">
        <a
          {% if hovered == 'about' %} class="hover-like" {% endif %}
          href="{{ about-url }}"
        >
          {{ translation.about }}
        </a>
      </li>
      <li class="header-nav-list-item">
        <a
          {% if hovered == 'tag-archives' %} class="hover-like" {% endif %}
          href="{{ tag-list-url }}"
        >
          {{ translation.tags }}
        </a>
      </li>
      <li class="header-nav-list-item">
        <a
          {% if hovered == 'archives' %} class="hover-like" {% endif %}
          href="{{ archives-url }}"
        >
          {{ translation.archives }}
        </a>
      </li>
    </ul>
  </nav>
</header>
