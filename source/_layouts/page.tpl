<!DOCTYPE html>
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page.title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main>
      {% if page.h1 %}
        <h1>{{ page.title }}</h1>
      {% endif %}
      {% if page.interlanguage-id or page.toc %}
        <div class="flexible-wrapper">
          <div class="side-column">
            {% include languages.inc %}
            {% include toc.inc %}
          </div>
          <div class="main-column">
            {{ content }}
          </div>
        </div>
      {% else %}
        {{ content }}
      {% endif %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
