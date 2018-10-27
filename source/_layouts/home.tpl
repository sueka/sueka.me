<!DOCTYPE html>
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page.title | default: site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc hovered='home' %}
    <main>
      {{ content }}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
