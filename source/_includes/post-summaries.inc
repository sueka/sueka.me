{% if paginator.posts.size > 0 %}
  {% assign lang = include.lang | default: page.lang | default: site.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  {% for post in paginator.posts %}
    {% assign post-lang = post.lang | default: site.lang %}
    <section class="post-summary" lang="{{ post-lang }}" itemscope="" itemtype="http://schema.org/Article">
      <header>
        <h2>
          <a href="{{ post.url }}">
            {{ post.title }}
          </a>
        </h2>
        <div class="post-meta">
          <time itemprop="datePublished" datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time>
        </div>
      </header>
      {% include tags.inc object=post %}
      {{ post.excerpt }}
      {% if post.excerpt != post.content %}
        <p>
          <a class="read-more" href="{{ post.url }}">{{ translation.read-more }}</a>
        </p>
      {% endif %}
    </section>
  {% endfor %}
  {% include pagination-nav.inc paginator=paginator %}
{% endif %}
