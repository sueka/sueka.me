{% assign object = include.object | default: page %}
{% assign number-of-tags = object.tags | size %}
{% if number-of-tags > 0 %}
  {% assign lang = include.lang | default: object.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  {% assign tag-translation = site.data.tag-translations | where: 'langcode', lang | first %}
  {% assign routing-to-tag-archives = site.autopages.tags.permalink %}
  <nav class="tags">
    <h3>{{ translation.tags }}</h3>
    <ul>
      {% for tag-name in object.tags %}
        {% assign tag-size = site.tags | map: tag-name | first | size %}
        <li><a href="{{ routing-to-tag-archives | replace: ':tag', tag-name }}" class="tag">
          {{ tag-translation[tag-name] }}
          <span class="tag-size">{{ tag-size }}</span>
        </a></li>
      {% endfor %}
    </ul>
  </nav>
{% endif %}
