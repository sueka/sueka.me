{% if page.tags %}

{% assign in-langs = site.data.translations | where: 'langcode', include.this-lang %}
{% for _ in in-langs %}{% assign tags-in-lang = _.tags %}{% endfor %}

<nav>
  <h3>{{ tags-in-lang }}</h3>
  <ul>
    {% for tag in page.tags %}
      <li><a href="/tag/{{ tag }}/">{{ tag }}</a></li>
    {% endfor %}
  </ul>
</nav>

{% endif %}
