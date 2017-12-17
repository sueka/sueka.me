{% assign include-lang = include.lang | default: page-lang %}

{% if page.tags %}

{% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
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
