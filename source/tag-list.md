---
layout: archive-list
title: タグの一覧
lang: ja
---

{% assign translation = site.data.translations | where: 'langcode', page.lang | first %}
{% assign tag-translation = site.data.tag-translations | where: 'langcode', page.lang | first %}
{% assign routing-to-tag-archive = site.jekyll-archives.permalinks.tag %}
{% assign tags = site.tags | sort %}
{% for tag-posts-pair in tags %}
  {% assign tag = tag-posts-pair | first %}
  {% assign posts = tag-posts-pair | last | sort: 'date' | reverse %}
  {% assign posts-limited = posts | limit: 10 %}
  <section>
    <h2>
      <a href="{{ routing-to-tag-archive | replace: ':name', tag }}">{{ tag-translation[tag] }}</a>
    </h2>
    {% comment %} May specified "lang: en" in the post {% endcomment %}
    {% include archive.inc posts=posts-limited %}
  </section>
{% endfor %}
