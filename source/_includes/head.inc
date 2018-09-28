{% assign lang = include.lang | default: page.lang | default: site.lang %}
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="preload" href="{{ 'assets/stylesheets/main.css' | relative_url }}" as="style" />
<link rel="stylesheet" href="{{ 'assets/stylesheets/main.css' | relative_url }}" />
{% for extra-stylesheet in page.extra-stylesheets %}
  <link rel="preload" href="{{ 'assets/stylesheets/' | append: extra-stylesheet | append: '.css' | relative_url }}" as="style" />
  <link rel="stylesheet" href="{{ 'assets/stylesheets/' | append: extra-stylesheet | append: '.css' | relative_url }}" />
{% endfor %}
{% if page.use-katex %}
  <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/{{ site.katex_version }}/katex.min.css" as="style" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/{{ site.katex_version }}/katex.min.css" />
{% endif %}
{% if page.interlanguage-id %}
  {% assign objects = site.posts | concat: site.pages | where: 'interlanguage-id', page.interlanguage-id %}
  {% for object in objects %}
    {% assign object-lang = object.lang | default: site.lang %}
    {% if object-lang != lang %}
      <link rel="alternate" href="{{ object.url }}" hreflang="{{ object-lang }}" />
    {% endif %}
  {% endfor %}
{% endif %}
<link rel="icon" href="{{ '/assets/images/favicon.svg' | relative_url }}" type="image/svg+xml" />
{% feed_meta %}
