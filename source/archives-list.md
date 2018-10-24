---
layout: archives-list
title: アーカイブ
lang: ja
hovered: archives
---

{% assign translation = site.data.translations | where: 'langcode', page.lang | first %}
{% assign routing-to-year-archives = site.jekyll-archives.permalinks.year %}
{% assign years = site.posts | group_by_exp: 'post', 'post.date | date: "%Y"' | sort: 'name' | reverse %}
{% for year in years %}
  {% assign posts = year.items %}
  {% assign posts-limited = posts | limit: 10 %}
  <section>
    <h2>
      <a href="{{ routing-to-year-archives | replace: ':year', year.name }}">{{ year.name | append: '-01-01' | date: translation.y-format }}</a>
    </h2>
    {% include archives.inc posts=posts-limited date-format-key='md-format' %}
    {% if posts.size > 10 %}
      <p>
        <a class="see-more" href="{{ routing-to-year-archives | replace: ':year', year.name }}">{{ translation.see-more }}</a>
      </p>
    {% endif %}
  </section>
{% endfor %}
