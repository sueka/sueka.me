{% if site.lsi %}
  {% assign lang = include.lang | default: page.lang %}
  {% assign related-posts = site.related_posts | select: 'lang', lang | reject: 'id', page.id | limit: 10 %}
  {% if related-posts.size > 0 %}
    {% assign translation = site.data.translations | where: 'langcode', lang | first %}
    <nav class="related-posts">
      <h3>{{ translation.related-posts }}</h3>
      {% include post-list.inc posts=related-posts date-format-key='ymd-format' %}
    </nav>
  {% endif %}
{% endif %}
