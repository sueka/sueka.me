<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="{{ "assets/stylesheets/main.css" | relative_url }}" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.6.0/katex.min.css">
<link rel="canonical" href="{{ page.url | replace:"index.html","" | absolute_url }}" />

{% comment %} Languages {% endcomment %}
{% if page.interlanguage-id %}

{% if page.layout == 'post' %}
  {% assign objects = site.posts %}
{% else %}
  {% assign objects = site.pages %}
{% endif %}

{% for object in objects %}
  {% assign object-lang = object.lang | default: site.lang %}
  {% if object.interlanguage-id == page.interlanguage-id and object-lang != include.this-lang %}
    <link rel="alternate" href="{{ object.url }}" herflang="{{ object-lang }}" />
  {% endif %}
{% endfor %}

{% endif %}
