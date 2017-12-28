{% assign include-lang = include.lang | default: page-lang %}

{% if page.toc %}

{% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
{% assign table-of-contents = translation.table-of-contents %}

<nav class="toc">
  <h3>{{ table-of-contents }}</h3>
  {{ content | toc_only }}
</nav>

{% endif %}
