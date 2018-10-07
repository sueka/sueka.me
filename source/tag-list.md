---
layout: archive-list
title: タグの一覧
lang: ja
---

{% assign lang = page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign tag-translation = site.data.tag-translations | where: 'langcode', lang | first %}
{% assign routing-to-tag-archive = site.jekyll-archives.permalinks.tag %}
{% assign tags = site.tags | sort %}
{% for tag-posts-pair in tags %}
  {% assign tag = tag-posts-pair | first %}
  {% assign posts = tag-posts-pair | last | sort: 'date' | reverse %}
  {% assign posts-limited = posts | limit: 10 %}
  <section id="tag_{{ tag }}">
    <h2>{{ tag-translation[tag] }}</h2>
    {% comment %} May specified "lang: en" in the post {% endcomment %}
    {% include archive.inc posts=posts-limited %}
    {% if posts.size > 10 %}
      <p><a href="{{ routing-to-tag-archive | replace: ':name', tag }}">There</a> are all posts tagged with {{ tag }}.</p>
    {% endif %}
  </section>
{% endfor %}
