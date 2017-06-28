{% if page.ref %}

{% assign in-langs = site.data.languages | where: 'langcode', include.this-lang %}
{% for _ in in-langs %}{% assign languages-in-lang = _.languages %}{% endfor %}

{% if page.layout == "post" %}
  {% assign objects = site.posts %}
{% else %}
  {% assign objects = site.pages | where: "layout", page.layout %}
{% endif %}

<nav>
  <h3>{{ languages-in-lang }}</h3>
  <ul>
  {% for object in objects %}
    {% assign object-lang = object.lang | default: site.lang %}
    {% if object.ref == page.ref and object-lang != include.this-lang %}
      {% assign in-langs = site.data.languages | where: 'langcode', object-lang %}
      {% for _ in in-langs %}{% assign in-lang = _ %}{% endfor %}
      <li><a lang="{{ object-lang }}" rel="alternate" href="{{ object.url }}" hreflang="{{ object-lang }}">{{ in-lang.name }}</a></li>
    {% endif %}
  {% endfor %}
  </ul>
</nav>

{% endif %}
