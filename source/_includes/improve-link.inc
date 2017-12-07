{% assign page-lang = include.this-lang | default: page.lang | default: site.lang %}

{% case page.layout %}
{% when 'post' %}
  {% assign main-source-url = "//github.com/" | append: site.github_repo | append: "/blob/posts/master/source/" | append: page.path %}
{% when 'page' %}
  {% assign main-source-url = "//github.com/" | append: site.github_repo | append: "/blob/master/source/" | append: page.path %}
{% endcase %}

<aside><p>

{% case page-lang %}
{% when 'ja' %}
  このページのメインソースは <a href="{{ main-source-url }}">{{ page.path }}</a> です。
{% else %}
  This page has been generated from <a href="{{ main-source-url }}">{{ page.path }}</a> and some templates.
{% endcase %}

</p></aside>
