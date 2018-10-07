---
layout: archive-list
title: アーカイブ
lang: ja
---

{% assign translation = site.data.translations | where: 'langcode', page.lang | first %}
{% assign routing-to-year-archive = site.jekyll-archives.permalinks.year %}
{% assign years = site.posts | group_by_exp: 'post', 'post.date | date: "%Y"' | sort: 'name' | reverse %}
{% for year in years %}
  {% assign posts = year.items %}
  {% assign posts-limited = posts | limit: 10 %}
  <section id="year_{{ year.name }}">
    <h2>{{ year.name | append: '-01-01' | date: translation.year-format }}</h2>
    {% include archive.inc posts=posts-limited %}
    {% if posts.size > 10 %}
      <p><a href="{{ routing-to-year-archive | replace: ':year', year.name }}">There</a> are all posts of {{ year.name }}.</p>
    {% endif %}
  </section>
{% endfor %}
