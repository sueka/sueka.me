<!DOCTYPE html>
<html lang="{{ page.lang | default: site.lang }}">
  <head>
    <title>{{ page.title }} - {{ site.title }}</title>
    {% include head.inc %}
  </head>
  <body>
    {% include header.inc %}
    <main itemscope="" itemtype="http://schema.org/Article">
      <header>
        <h1>{{ page.title }}</h1>
        <div class="post-meta">
          <time itemprop="datePublished" datetime="{{ page.date | date_to_xmlschema | slice: 0, 10 }}">{{ page.date | date: translation.date-format }}</time>
        </div>
      </header>
      <div class="flexible-wrapper">
        <div class="side-column">
          {% include tags.inc %}
          {% include languages.inc %}
          {% include toc.inc %}
        </div>
        <div class="main-column">
          {{ content }}
        </div>
      </div>
      {% include related-posts.inc %}
    </main>
    {% include footer.inc %}
    {% include scripts.inc %}
  </body>
</html>
