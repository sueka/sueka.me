<!DOCTYPE html>
{% case page.type %}
{% when 'year' %}
  {% assign page-title = page.date | date: 'Posts of %Y' %}
{% when 'month' %}
  {% assign page-title = page.date | date: 'Posts on %B %Y' %}
{% when 'tag' %}
  {% assign page-title = 'Posts tagged with ' | append: page.title %}
{% endcase %}
<html lang="{{ page.lang | default: site.lang }}">
  <head>
    <title>{{ page-title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main>
      <h1>{{ page-title }}</h1>
      {% include archive.inc %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
