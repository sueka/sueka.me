{% assign page-lang = page.lang | default: site.lang %}
<!DOCTYPE html>
<html lang="{{ page-lang }}">
  <head>
    <title>{{ page.title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main itemscope="" itemtype="http://schema.org/Article">
      <header>
        <h1>{{ page.title }}</h1>
        {% include post-meta.inc %}
      </header>
      <div class="container">
        <div class="side-column">
          {% include tags.inc %}
          {% include languages.inc %}
          {% include toc.inc %}
        </div>
        <div class="main-column">
          {{ content }}
          {% include main-source.inc %}
        </div>
      </div>
      {% include related-posts.inc %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
