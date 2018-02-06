{% assign include-lang = include.lang | default: page-lang %}
{% assign main-source-path = 'source/' | append: page.path %}
{% assign main-source-url = '//github.com/' | append: site.github_repo | append: '/blob/' | append: site.git.last_commit.long_sha | append: '/' | append: main-source-path %}
<hr />
<aside><p>
  {% case include-lang %}
  {% when 'he' %}
    דף זה נוצר מ-<a href="{{ main-source-url }}">{{ main-source-path }}</a> וכמה תבניות.
  {% when 'ja' %}
    このページは <a href="{{ main-source-url }}">{{ main-source-path }}</a> といくつかのテンプレートから生成されてゐます。
  {% else %}
    This page has been generated from <a href="{{ main-source-url }}">{{ main-source-path }}</a> and some templates.
  {% endcase %}
</p></aside>
