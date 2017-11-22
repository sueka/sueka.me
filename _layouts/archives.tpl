<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}
{% if page.type == "year" %}
  {% assign page-title = page.date | date: "Posts of %Y" %}
{% elsif page.type == "month" %}
  {% assign page-title = page.date | date: "Posts on %B %Y" %}
{% elsif page.type == "tag" %}
  {% assign page-title = 'Posts tagged with ' | append: page.title %}
{% endif %}

<html lang="{{ page-lang }}">
<head>
<title>{{ page-title }}</title>
{% include head.inc %}
</head>
<body>

{% include header.inc %}

<main>

<h1>{{ page-title }}</h1>

{% include archives.inc %}

</main>

{% include footer.inc %}

</body>
</html>
