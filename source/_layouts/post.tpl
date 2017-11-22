<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

<html lang="{{ page-lang }}">
<head>
<title>{{ page.title }} - {{ site.title }}</title>
{% include head.inc %}
</head>
<body>

{% include header.inc %}

<main>

<h1>{{ page.title }}</h1>

{% include tags.inc %}

{% include languages.inc %}

{% include toc.inc %}

{{ content }}

</main>

{% include footer.inc %}

</body>
</html>
