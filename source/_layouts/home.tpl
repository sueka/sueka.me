<!DOCTYPE html>
{% assign page-lang = page.lang | default: site.lang %}
<html lang="{{ page-lang }}">
  <head>
    <title>{{ page.title | default: site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main>
      <h1>{{ page.title }}</h1>
      <div class="flexible-wrapper">
        <div class="side-column">
          {% include languages.inc %}
          {% include toc.inc %}
        </div>
        <div class="main-column">
          {{ content }}
          {% include main-source.inc %}
        </div>
      </div>
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
