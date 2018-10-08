<!DOCTYPE html>
{% assign translation = site.data.translations | where: 'langcode', page.lang | first %}
{% case page.type %}
{% when 'year' %}
  {% assign page-title = page.date | date: translation.year-format %}
{% when 'month' %}
  {% assign page-title = page.date | date: translation.month-format %}
{% endcase %}
<html lang="{{ page.lang }}">
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
