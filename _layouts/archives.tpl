<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

<html lang="{{ site.lang }}">
<head>
<title>{{ page.title }}</title>
{% include head.inc %}
</head>
<body>

{% include header.inc %}

<main>

{% if page.type == "year" %}
  <h1>Posts of {{ page.date | date: "%Y" }}</h1>
{% elsif page.type == "month" %}
  <h1>Posts on {{ page.date | date: "%B %Y" }}</h1>
{% elsif page.type == "tag" %}
  <h1>Posts tagged with <em>{{ page.title }}</em></h1>
{% endif %}

{% include archives.inc %}

</main>

{% include footer.inc %}

</body>
</html>
