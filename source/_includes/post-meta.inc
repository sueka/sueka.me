{% assign date = include.date | default: page.date %}
{% assign lang = include.lang | default: page.lang | default: site.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
<div class="post-meta">
  <time itemprop="datePublished" datetime="{{ date | date_to_xmlschema | slice: 0, 10 }}">{{ date | date: translation.date-format }}</time>
</div>
