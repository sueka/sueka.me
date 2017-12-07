{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}

{% assign main-source-path = "source/" | append: page.path %}

{% case page.layout %}
{% when 'post' %}
  {% assign main-source-url = "//github.com/" | append: site.github_repo | append: "/blob/posts/master/" | append: main-source-path %}
{% when 'page' %}
  {% assign main-source-url = "//github.com/" | append: site.github_repo | append: "/blob/master/" | append: main-source-path %}
{% endcase %}

<aside><p>

{% case page-lang %}
{% when 'ja' %}
  このページのメインソースは <a href="{{ main-source-url }}">{{ main-source-path }}</a> です。
{% else %}
  This page has been generated from <a href="{{ main-source-url }}">{{ main-source-path }}</a> and some templates.
{% endcase %}

</p></aside>
