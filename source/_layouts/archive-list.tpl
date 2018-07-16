<!DOCTYPE html>
<html lang="{{ page.lang | default: site.lang }}">
  <head>
    <title>{{ page.title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main>
      <h1>{{ page.title }}</h1>
      {{ content }}
      {% include main-source.inc %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
