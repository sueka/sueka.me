{% if include.posts and include.date-format-key %}

{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign date-format = translation[include.date-format-key] %}
<ul>
  {% for post in include.posts %}
    <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: date-format }}</time> - <a {% if post.lang != lang %} lang="{{ post.lang }}" hreflang="{{ post.lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

{% endif %}
