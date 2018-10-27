{% assign recent-posts = site.posts | sort: 'date' | reverse | limit: 10 %}
{% if recent-posts.size > 0 %}

{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
<nav class="recent-posts">
  <h3>{{ translation.recent-posts }}</h3>
  {% include post-list.inc posts=recent-posts date-format-key='ymd-format' %}
</nav>

{% endif %}
