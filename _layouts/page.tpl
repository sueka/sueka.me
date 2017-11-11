<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

<html lang="{{ page-lang }}">
<head>
<title>{{ page.title }}</title>
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
