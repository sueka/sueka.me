<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

{% case page.type %}
{% when 'year' %}
  {% assign page-title = page.date | date: 'Posts of %Y' %}
{% when 'month' %}
  {% assign page-title = page.date | date: 'Posts on %B %Y' %}
{% when 'tag' %}
  {% assign page-title = 'Posts tagged with ' | append: page.title %}
{% endcase %}

<html lang="{{ page-lang }}">
<head>
<title>{{ page-title }} - {{ site.title }}</title>
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
