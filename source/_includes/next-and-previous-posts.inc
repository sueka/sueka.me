{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
<nav class="next-and-previous-posts">
  <h3>{{ translation.next-and-previous-posts }}</h3>
  <dl>
    <dt>{{ translation.later }}</dt>
    <dd>
      {% if page.next %}
        <a {% if page.next.lang != lang %} lang="{{ page.next.lang }}" {% endif %} href="{{ page.next.url }}" rel="next">
          {{ page.next.title }}
        </a>
      {% else %}
        <p>
          <i>{{ translation.no-posts-newer-than-this }}</i>
        </p>
      {% endif %}
    </dd>
    <dt>{{ translation.earlier }}</dt>
    <dd>
      {% if page.previous %}
        <a {% if page.previous.lang != lang %} lang="{{ page.previous.lang }}" {% endif %} href="{{ page.previous.url }}" rel="prev">
          {{ page.previous.title }}
        </a>
      {% else %}
        <p>
          <i>{{ translation.no-posts-older-than-this }}</i>
        </p>
      {% endif %}
    </dd>
  </dl>
</nav>
