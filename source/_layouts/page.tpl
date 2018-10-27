<!DOCTYPE html>
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page.title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main>
      <h1>{{ page.title }}</h1>
      <div class="flexible-wrapper">
        {% if page.interlanguage-id or page.toc %}
          <div class="side-column">
            {% include languages.inc %}
            {% include toc.inc %}
          </div>
        {% endif %}
        <div class="main-column">
          {{ content }}
        </div>
      </div>
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
