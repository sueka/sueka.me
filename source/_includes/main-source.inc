{% assign lang = include.lang | default: page.lang | default: site.lang %}
{% if site.source != '' %}
  {% assign jekyll-source-dir = site.source | append: '/' | replace: '//', '/' %}
{% endif %}
{% assign main-source-path = jekyll-source-dir | append: page.path %}
{% assign main-source-url = '//github.com/' | append: site.github_repo | append: '/blob/' | append: site.git.last_commit.long_sha | append: '/' | append: main-source-path %}
<hr />
<aside><p>
  {% case lang %}
  {% when 'ja' %}
    このページは <a href="{{ main-source-url }}">{{ main-source-path }}</a> といくつかのテンプレートから生成されてゐます。
  {% else %}
    This page has been generated from <a href="{{ main-source-url }}">{{ main-source-path }}</a> and some templates.
  {% endcase %}
</p></aside>
