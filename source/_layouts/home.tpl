<!DOCTYPE html>
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page.title | default: site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc hovered='home' %}
    {% include post-summaries.inc %}
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
