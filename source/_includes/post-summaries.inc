{% if paginator.posts.size > 0 %}
  {% assign lang = include.lang | default: page.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  {% for post in paginator.posts %}
    <section class="post-summary" {% if post.lang != lang %} lang="{{ post.lang }}" {% endif %} itemscope="" itemtype="http://schema.org/Article">
      <header>
        <h2>
          <a href="{{ post.url }}">
            {{ post.title }}
          </a>
        </h2>
        {% include post-meta.inc object=post %}
      </header>
      {% include tags.inc object=post lang=lang %}
      {% assign href = 'href="#' | append: post.url | append: ':' %}
      {% assign id = 'id="' | append: post.url | append: ':' %}
      {{ post.excerpt
        | replace: 'href="#', href
        | replace: 'id="', id
      }}
      {% if post.excerpt != post.content %}
        <p>
          <a class="read-more" {% if post.lang != lang %} lang="{{ lang }}" {% endif %} href="{{ post.url }}">{{ translation.read-more }}</a>
        </p>
      {% endif %}
    </section>
  {% endfor %}
  {% include pagination-nav.inc paginator=paginator %}
{% endif %}
