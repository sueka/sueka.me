{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}
{% assign translation = site.data.translations | where: 'langcode', page-lang | first %}

<nav class="recent-posts">
  <h3>{{ translation.recent-posts }}</h3>
  <ul>
    {% for post in site.posts | sort: "date" %}
      {% assign post-lang = post.lang | default: site.lang %}
      {% if post-lang == page-lang %}
        <li>{{ post.date | date: translation.date-format }} - <a href="{{ post.url }}">{{ post.title }}</a></li>
      {% endif %}
    {% endfor %}
  </ul>
</nav>
