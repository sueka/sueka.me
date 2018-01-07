{% assign include-lang = include.lang | default: page-lang %}

{% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
{% assign date-format = translation.date-format %}

<ul>
  {% for post in page.posts | sort: 'date' %}
    {% assign post-lang = post.lang | default: site.lang %}
    <li>{{ post.date | date: date-format }} - <a {% if post-lang != page-lang %} lang="{{ post-lang }}" hreflang="{{ post-lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
