{% assign include-lang = include.lang | default: page-lang %}
{% if page.toc %}
  {% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
  {% assign contents = translation.contents %}
  <nav class="toc">
    <h3>{{ contents }}</h3>
    {{ content | toc_only }}
  </nav>
{% endif %}
