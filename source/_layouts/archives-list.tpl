<!DOCTYPE html>
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page.title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    {{ content }}
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
