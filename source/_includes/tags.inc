{% assign include-lang = include.lang | default: page-lang %}
{% assign number-of-tags = page.tags | size %}
{% if number-of-tags != 0 %}
  {% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
  {% assign tags-in-native = translation.tags %}
  <nav class="tags">
    <h3>{{ tags-in-native }}</h3>
    <ul>
      {% for tag in page.tags %}
        <li><a href="/tags/{{ tag | slugify }}.html">{{ tag }}</a></li>
      {% endfor %}
    </ul>
  </nav>
{% endif %}
