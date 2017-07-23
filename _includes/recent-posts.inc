{% assign in-langs = site.data.translations | where: 'langcode', include.this-lang %}
{% for _ in in-langs %}{% assign in-lang = _ %}{% endfor %}

<nav>
  <h3>{{ in-lang.recent-posts }}</h3>
  <ul>
  {% for post in site.posts | sort: "date" %}
    {% assign post-lang = post.lang | default: site.lang %}
    {% if post-lang == include.this-lang %}
      <li>{{ post.date | date: in-lang.date-format }} - <a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
  </ul>
</nav>
