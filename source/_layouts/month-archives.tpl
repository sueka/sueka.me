<!DOCTYPE html>
{% assign translation = site.data.translations | where: 'langcode', page.lang | first %}
{% assign month = page.date | date: translation.ym-format %}
{% assign page-title = translation.posts-on-month | replace: ':month', month %}
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page-title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc hovered='archives' %}
    <main>
      <h1>{{ page-title }}</h1>
      {% include post-list.inc posts=page.posts date-format-key='d-format' %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
