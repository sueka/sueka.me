{% if site.lsi %}
  {% assign include-lang = include.lang | default: page-lang %}
  {% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
  <nav class="related-posts">
    <h3>{{ translation.related-posts }}</h3>
    <ul>
      {% for post in site.related_posts %}
        {% assign post-lang = post.lang | default: site.lang %}
        {% if post-lang == include-lang and post.id != page.id %}
          <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
      {% endfor %}
    </ul>
  </nav>
{% endif %}
