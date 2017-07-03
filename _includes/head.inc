<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="{{ "assets/stylesheets/main.css" | relative_url }}" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.6.0/katex.min.css">
<link rel="canonical" href="{{ page.url | replace:"index.html","" | absolute_url }}" />

{% comment %} Languages {% endcomment %}
{% if page.ref %}

{% if page.layout == 'page' %}
  {% assign objects = site.pages %}
{% else %}
  {% assign objects = site.posts %}
{% endif %}

{% for object in objects %}
  {% if object.ref == page.ref and object.lang != page.lang %}
    <link rel="alternate" href="{{ object.url }}" herflang="{{ object.lang | default: site.lang }}" />
  {% endif %}
{% endfor %}

{% endif %}
