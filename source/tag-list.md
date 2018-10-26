---
layout: archives-list
title: タグの一覧
lang: ja
header-hovered: tag-archives
---

{% assign tag-translation = site.data.tag-translations | where: 'langcode', page.lang | first %}
{% assign routing-to-tag-page = site.autopages.tags.permalink %}
{% assign tags = site.tags | sort %}
{% for tag-posts-pair in tags %}
  {% assign tag = tag-posts-pair | first %}
  {% assign posts = tag-posts-pair | last | sort: 'date' | reverse %}
  {% assign posts-limited = posts | limit: 10 %}
  <section>
    <h2>
      <a href="{{ routing-to-tag-page | replace: ':tag', tag }}">{{ tag-translation[tag] }}</a>
    </h2>
    {% comment %} May specified "lang: en" in the post {% endcomment %}
    {% include post-list.inc posts=posts-limited date-format-key='ymd-format' %}
    {% if posts.size > 10 %}
      <p>
        <a class="see-more" href="{{ routing-to-tag-page | replace: ':tag', tag }}">{{ translation.see-more }}</a>
      </p>
    {% endif %}
  </section>
{% endfor %}
