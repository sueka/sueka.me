{% assign site-posts = site.posts | sort: 'date' | reverse %}
{% if site-posts.size > 0 %}
  {% assign include-lang = include.lang | default: page-lang %}
  {% assign translation = site.data.translations | where: 'langcode', include-lang | first %}
  <nav class="recent-posts">
    <h3>{{ translation.recent-posts }}</h3>
    <ul>
      {% for post in site-posts limit: 10 %}
        {% assign post-lang = post.lang | default: site.lang %}
        <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a {% if post-lang != include-lang %} lang="{{ post-lang }}" hreflang="{{ post-lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
      {% endfor %}
    </ul>
    {% if site-posts.size > 10 %}
      <p>There are <a href="{{ '/archives-list.html' | relative_url }}">more</a>.</p>
    {% endif %}
  </nav>
{% endif %}
