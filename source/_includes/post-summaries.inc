{% if paginator.posts.size > 0 %}
  {% assign lang = include.lang | default: page.lang | default: site.lang %}
  {% assign translation = site.data.translations | where: 'langcode', lang | first %}
  {% for post in paginator.posts %}
    {% assign post-lang = post.lang | default: site.lang %}
    <section class="post-summary" lang="{{ post-lang }}" itemscope="" itemtype="http://schema.org/Article">
      <header>
        <h1>
          <a href="{{ post.url }}">
            {{ post.title }}
          </a>
        </h1>
        {% include post-meta.inc date=post.date %}
      </header>
      {% include tags.inc object=post %}
      {{ post.excerpt }}
    </section>
  {% endfor %}
  {% include pagination-nav.inc paginator=paginator %}
{% endif %}
