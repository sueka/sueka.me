{% assign in-langs = site.data.translations | where: 'langcode', include.this-lang %}
{% for _ in in-langs %}{% assign date-format-in-lang = _.date-format %}{% endfor %}

<ul>
  {% for post in page.posts | sort: "date" %}
    {% assign post-lang = post.lang | default: site.lang %}
    <li>{{ post.date | date: date-format-in-lang }} - <a {% if post-lang != self-lang %} lang="{{ post-lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
