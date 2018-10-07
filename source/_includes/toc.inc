{% if page.toc %}
  {% assign lang = include.lang | default: page.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  <nav class="toc">
    <h3>{{ translation.contents }}</h3>
    {{ content | toc_only }}
  </nav>
{% endif %}
