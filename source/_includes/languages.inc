{% if page.interlanguage-id %}

{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}
{% assign translation = site.data.translations | where: 'langcode', page-lang | first %}
{% assign languages = translation.languages %}

{% assign objects = site.posts | concat: site.pages | sort: "lang" | where: "interlanguage-id", page.interlanguage-id %}

<nav>
  <h3>{{ languages }}</h3>
  <ul>
    {% for object in objects %}
      {% assign object-lang = object.lang | default: site.lang %}
      {% if object-lang != page-lang %}
        {% assign translation = site.data.translations | where: 'langcode', object-lang | first %}
        <li><a lang="{{ object-lang }}" title="{{ object.title }}" rel="alternate" href="{{ object.url }}" hreflang="{{ object-lang }}">{{ translation.name }}</a></li>
      {% endif %}
    {% endfor %}
  </ul>
</nav>

{% endif %}
