{% assign include-lang = include.lang | default: page-lang %}
{% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
{% if site.lsi and site.related_posts.size > 0 %}
  <nav class="related-posts">
    <h3>{{ translation.related-posts }}</h3>
    <ul>
      {% for post in site.related_posts %}
        {% assign post-lang = post.lang | default: site.lang %}
        <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a {% if post-lang != include-lang %} lang="{{ post-lang }}" hreflang="{{ post-lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
      {% endfor %}
    </ul>
  </nav>
{% endif %}
