<!DOCTYPE html>
{% assign lang = page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign tag-translation = site.data.tag-translations | where: 'langcode', lang | first %}
{% case page.type %}
{% when 'year' %}
  {% assign page-title = page.date | date: translation.year-format %}
{% when 'month' %}
  {% assign page-title = page.date | date: translation.month-format %}
{% when 'tag' %}
  {% assign page-title = tag-translation[page.title] %}
{% endcase %}
<html lang="{{ lang }}">
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
