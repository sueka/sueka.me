<!DOCTYPE html>
<html lang="{{ page.lang }}">
  <head>
    <title>{{ page.title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main itemscope="" itemtype="http://schema.org/Article">
      <header>
        <h1 itemplop="headline">{{ page.title }}</h1>
        {% include post-meta.inc %}
      </header>
      <div class="flexible-wrapper">
        <div class="side-column">
          {% include languages.inc %}
          {% include toc.inc %}
        </div>
        <div class="main-column">
          {{ content }}
          {% include next-and-previous-posts.inc %}
          {% include related-posts.inc %}
        </div>
      </div>
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
