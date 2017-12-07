<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

{% case page.url %}
{% when '/' %}
  {% assign page-title = page.title %}
{% when '/index-ja.html' %}
  {% assign page-title = page.title %}
{% else %}
  {% assign page-title = page.title | append: ' - ' | append: site.title %}
{% endcase %}

<html lang="{{ page-lang }}">
<head>
<title>{{ page-title }}</title>
{% include head.inc %}
</head>
<body>

{% include header.inc %}

<main>

<h1>{{ page.title }}</h1>

{% include languages.inc %}

{% include improve-link.inc %}

{{ content }}

</main>

{% include recent-posts.inc %}

{% include footer.inc %}

</body>
</html>
