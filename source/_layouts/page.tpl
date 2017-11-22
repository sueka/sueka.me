<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}
{% if page.path == '/' %}
  {% assign page-title = page.title %}
{% else %}
  {% assign page-title = page.title | append: ' | ' | append: site.title %}
{% endif %}

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

{{ content }}

</main>

{% include recent-posts.inc %}

{% include footer.inc %}

</body>
</html>
