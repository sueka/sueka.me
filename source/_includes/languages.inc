{% if page.interlanguage-id %}
  {% assign lang = include.lang | default: page.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  {% assign objects = site.posts | concat: site.pages | sort: 'lang' | where: 'interlanguage-id', page.interlanguage-id %}
  <nav class="languages">
    <h3>{{ translation.languages }}</h3>
    <ul>
      {% for object in objects %}
        {% if object.lang != lang %}
          {% assign translation = site.data.translations | where: 'langcode', object.lang | first %}
          <li><a lang="{{ object.lang }}" title="{{ object.title }}" rel="alternate" href="{{ object.url }}" hreflang="{{ object.lang }}">{{ translation.name }}</a></li>
        {% endif %}
      {% endfor %}
    </ul>
  </nav>
{% endif %}
