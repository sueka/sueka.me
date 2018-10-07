<!DOCTYPE html>
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page.title | default: site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main>
      <h1>{{ page.title }}</h1>
      {% include post-summaries.inc %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
