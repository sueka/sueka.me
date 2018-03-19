{% assign number-of-tags = page.tags | size %}
{% if number-of-tags != 0 %}
  {% assign lang = include.lang | default: page.lang | default: site.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  <nav class="tags">
    <h3>{{ translation.tags }}</h3>
    <ul>
      {% for tag-name in page.tags %}
        {% assign tag-size = site.tags | map: tag-name | first | size %}
        <li><a href="/tags/{{ tag-name | slugify }}.html">
          {{ tag-name }}
          <span class="tag-size">{{ tag-size }}</span>
        </a></li>
      {% endfor %}
    </ul>
  </nav>
{% endif %}
