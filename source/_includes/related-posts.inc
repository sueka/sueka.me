{% if site.lsi %}
  {% assign lang = include.lang | default: page.lang %}
  {% assign related_posts = site.related_posts | select: 'lang', lang | reject: 'id', page.id %}
  {% if related_posts.size > 0 %}
    {% assign translation = site.data.translations | where: 'langcode', lang | first %}
    <nav class="related-posts">
      <h3>{{ translation.related-posts }}</h3>
      <ul>
        {% for post in related_posts %}
          <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endfor %}
      </ul>
    </nav>
  {% endif %}
{% endif %}
