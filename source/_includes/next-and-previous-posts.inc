{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
<nav class="next-and-previous-posts">
  <h3>{{ translation.next-and-previous-posts }}</h3>
  <dl>
    {% if page.next %}
      <dt>{{ translation.later }}</dt>
      <dd>
        <a {% if page.next.lang != lang %} lang="{{ page.next.lang }}" {% endif %} href="{{ page.next.url }}" rel="next">
          {{ page.next.title }}
        </a>
      </dd>
    {% endif %}
    {% if page.previous %}
      <dt>{{ translation.earlier }}</dt>
      <dd>
        <a {% if page.previous.lang != lang %} lang="{{ page.previous.lang }}" {% endif %} href="{{ page.previous.url }}" rel="prev">
          {{ page.previous.title }}
        </a>
      </dd>
    {% endif %}
  </dl>
</nav>
