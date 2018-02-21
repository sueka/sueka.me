{% assign include-lang = include.lang | default: page-lang %}
{% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
<aside class="post-meta">
  <time datetime="{{ page.date | date_to_xmlschema | slice: 0, 10 }}">{{ page.date | date: translation.date-format }}</time>
</aside>
