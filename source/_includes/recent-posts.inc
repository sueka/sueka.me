{% assign site-posts = site.posts | sort: 'date' | reverse %}
{% if site-posts.size > 0 %}
  {% assign lang = include.lang | default: page.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  <nav class="recent-posts">
    <h3>{{ translation.recent-posts }}</h3>
    <ul>
      {% for post in site-posts limit: 10 %}
        {% assign post-lang = post.lang %}
        <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a {% if post-lang != lang %} lang="{{ post-lang }}" hreflang="{{ post-lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
      {% endfor %}
    </ul>
    {% if site-posts.size > 10 %}
      <p><a href="{{ '/archives-list.html' | relative_url }}">There</a> are more.</p>
    {% endif %}
  </nav>
{% endif %}
