{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign object = include.object | default: page %}
<div class="post-meta">
  <time {% if object.lang != lang %} lang="{{ lang }}" {% endif %} itemprop="datePublished" datetime="{{ object.date | date_to_xmlschema | slice: 0, 10 }}">{{ object.date | date: translation.ymd-format }}</time>
</div>
