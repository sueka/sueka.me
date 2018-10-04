---
layout: archive-list
title: アーカイブ
lang: ja
---

{% assign translation = site.data.translations | where: 'langcode', site.lang | first %}
{% assign routing-to-year-archive = site.jekyll-archives.permalinks.year %}
{% assign years = site.posts | group_by_exp: 'post', 'post.date | date: "%Y"' | sort: 'name' | reverse %}
{% for year in years %}
  <section id="year_{{ year.name }}">
    <h2>{{ year.name | append: '-01-01' | date: translation.year-format }}</h2>
    <ul>
      {% assign posts = year.items | sort: 'date' | reverse %}
      {% for post in posts limit: 10 %}
        {% assign post-lang = post.lang | default: site.lang %}
        <li><time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: translation.date-format }}</time> - <a {% if post-lang != site.lang %} lang="{{ post-lang }}" hreflang="{{ post-lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a></li>
      {% endfor %}
    </ul>
    {% if posts.size > 10 %}
      <p><a href="{{ routing-to-year-archive | replace: ':year', year.name }}">There</a> are all posts of {{ year.name }}.</p>
    {% endif %}
  </section>
{% endfor %}
