{% if page.tags %}

{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}
{% assign translation = site.data.translations | where: 'langcode', page-lang | first %}
{% assign tags-in-native = translation.tags %}

<nav>
  <h3>{{ tags-in-native }}</h3>
  <ul>
    {% for tag in page.tags %}
      <li><a href="/tags/{{ tag }}.html">{{ tag }}</a></li>
    {% endfor %}
  </ul>
</nav>

{% endif %}
