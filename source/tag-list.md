---
layout: page
title: Tag list
---

{% assign page-lang = page.lang | default: site.lang %}
{% assign translation = site.data.translations | where: 'langcode', page-lang | first %}
{% assign routing-to-tag-archive = site.jekyll-archives.permalinks.tag %}
{% assign tags = site.tags | sort %}
{% for tag-posts-pair in tags %}
  {% assign tag = tag-posts-pair | first %}
  {% assign posts = tag-posts-pair | last | sort: 'date' | reverse %}
  <section id="tag_{{ tag }}">
    <h2>{{ tag }}</h2>
    <ul>
      {% for post in posts limit: 10 %}
        {% assign post-lang = post.lang | default: site.lang %}
        {% comment %} May specified "lang: en" in the post {% endcomment %}
        <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a {% if post-lang != page-lang %} lang="{{ post-lang }}" hreflang="{{ post-lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
      {% endfor %}
    </ul>
    {% if posts.size > 10 %}
      <p><a href="{{ routing-to-tag-archive | replace: ':name', tag }}">There</a> are all posts tagged with {{ tag }}.</p>
    {% endif %}
  </section>
{% endfor %}
