{% if paginator.posts.size > 0 %}

{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% for post in paginator.posts %}
  <section class="post-summary" {% if post.lang != lang %} lang="{{ post.lang }}" {% endif %} itemscope="" itemtype="http://schema.org/Article">
    <header>
      <h2 itemprop="headline">
        <a href="{{ post.url }}">
          {{ post.title }}
        </a>
      </h2>
      {% include post-meta.inc object=post %}
      {% include tags.inc object=post lang=lang %}
    </header>
    {% assign id_for_fn = post.url | append: ':\1' %}
    {% assign href_for_fn = '#' | append: post.url | append: ':\1' %}
    {% assign other_href = post.url | append: '#\1' %}
    {{ post.excerpt
      | regexp_replace: '(?<=id=")(fn(?:ref)?:(?:[^"]|\\")*)(?=")', id_for_fn
      | regexp_replace: '(?<=href=")#(fn(?:ref)?:(?:[^"]|\\")*)(?=")', href_for_fn
      | regexp_replace: '(?<=href=")#(?!(?:(?:[^"]|\\")*:)?fn(?:ref)?:)((?:[^"]|\\")*)(?=")', other_href
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
