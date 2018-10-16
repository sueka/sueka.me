<!DOCTYPE html>
{% assign translation = site.data.translations | where: 'langcode', page.lang | first %}
{% assign tag-translation = site.data.tag-translations | where: 'langcode', page.lang | first %}
{% assign tag-translated = tag-translation[page.title] %}
{% assign page-title = translation.posts-tagged-with-tag | replace: ':tag', tag-translation[page.title] %}
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page-title | strip_html }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main>
      <h1>{{ page-title }}</h1>
      {% include post-summaries.inc %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
