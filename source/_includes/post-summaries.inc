{% if paginator.posts.size > 0 %}
  {% assign lang = include.lang | default: page.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  {% for post in paginator.posts %}
    {% assign post-lang = post.lang %}
    <section class="post-summary" {% if post-lang != lang %} lang="{{ post-lang }}" {% endif %} itemscope="" itemtype="http://schema.org/Article">
      <header>
        <h2>
          <a href="{{ post.url }}">
            {{ post.title }}
          </a>
        </h2>
        <div class="post-meta">
          <time {% if post-lang != lang %} lang="{{ lang }}" {% endif %} itemprop="datePublished" datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time>
        </div>
      </header>
      {% include tags.inc object=post lang=lang %}

      {% assign href-fn = 'href="#fn:' | append: post.url | append: ':' %}
      {% assign href-fnref = 'href="#fnref:' | append: post.url | append: ':' %}
      {% assign id-fn = 'id="fn:' | append: post.url | append: ':' %}
      {% assign id-fnref = 'id="fnref:' | append: post.url | append: ':' %}

      {{ post.excerpt
        | replace: 'href="#fn:', href-fn
        | replace: 'href="#fnref:', href-fnref
        | replace: 'id="fn:', id-fn
        | replace: 'id="fnref:', id-fnref
      }}

      {% if post.excerpt != post.content %}
        <p>
          <a class="read-more" {% if post-lang != lang %} lang="{{ lang }}" {% endif %} href="{{ post.url }}">{{ translation.read-more }}</a>
        </p>
      {% endif %}
    </section>
  {% endfor %}
  {% include pagination-nav.inc paginator=paginator %}
{% endif %}
