{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
<nav class="next-and-previous-posts">
  <h3>{{ translation.next-and-previous-posts }}</h3>
  <dl>
    <dt>{{ translation.future }}</dt>
    <dd title="{{ translation.future }}">
      {% if page.next %}
        <a {% if page.next.lang != lang %} lang="{{ page.next.lang }}" {% endif %} href="{{ page.next.url }}" rel="next">
          {{ page.next.title }}
        </a>
      {% endif %}
    </dd>
    <dt>{{ translation.past }}</dt>
    <dd title="{{ translation.past }}">
      {% if page.previous %}
        <a {% if page.previous.lang != lang %} lang="{{ page.previous.lang }}" {% endif %} href="{{ page.previous.url }}" rel="prev">
          {{ page.previous.title }}
        </a>
      {% endif %}
    </dd>
  </dl>
</nav>
