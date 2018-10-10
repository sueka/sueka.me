{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign page-posts = include.posts | default: page.posts | sort: 'date' | reverse %}
<ul>
  {% for post in page-posts %}
    <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a {% if post.lang != lang %} lang="{{ post.lang }}" hreflang="{{ post.lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
