<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}
{% capture page-title %}
  {% if page.type == "year" %}
    Posts of {{ page.date | date: "%Y" }}
  {% elsif page.type == "month" %}
    Posts on {{ page.date | date: "%B %Y" }}
  {% elsif page.type == "tag" %}
    Posts tagged with {{ page.title }}
  {% endif %}
{% endcapture %}

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
