{% if page.interlanguage-id %}

{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}
{% assign in-langs = site.data.translations | where: 'langcode', page-lang %}
{% for _ in in-langs %}{% assign languages-in-lang = _.languages %}{% endfor %}

{% if page.layout == "post" %}
  {% assign objects = site.posts %}
{% else %}
  {% assign objects = site.pages %}
{% endif %}

<nav>
  <h3>{{ languages-in-lang }}</h3>
  <ul>
    {% for object in objects %}
      {% assign object-lang = object.lang | default: site.lang %}
      {% if object.interlanguage-id == page.interlanguage-id and object-lang != page-lang %}
        {% assign in-langs = site.data.translations | where: 'langcode', object-lang %}
        {% for _ in in-langs %}{% assign in-lang = _ %}{% endfor %}
        <li><a lang="{{ object-lang }}" title="{{ object.title }}" rel="alternate" href="{{ object.url }}" hreflang="{{ object-lang }}">{{ in-lang.name }}</a></li>
      {% endif %}
    {% endfor %}
  </ul>
</nav>

{% endif %}
