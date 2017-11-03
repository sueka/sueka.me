{% if page.tags %}

{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}
{% assign in-langs = site.data.translations | where: 'langcode', page-lang %}
{% for _ in in-langs %}{% assign tags-in-lang = _.tags %}{% endfor %}

<nav>
  <h3>{{ tags-in-lang }}</h3>
  <ul>
    {% for tag in page.tags %}
      <li><a href="/tags/{{ tag }}/">{{ tag }}</a></li>
    {% endfor %}
  </ul>
</nav>

{% endif %}
