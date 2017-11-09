{% if page.tags %}

{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}
{% assign transitions = site.data.translations | where: 'langcode', page-lang %}
{% assign tags-in-native = translations[0].tags %}

<nav>
  <h3>{{ tags-in-native }}</h3>
  <ul>
    {% for tag in page.tags %}
      <li><a href="/tags/{{ tag }}/">{{ tag }}</a></li>
    {% endfor %}
  </ul>
</nav>

{% endif %}
