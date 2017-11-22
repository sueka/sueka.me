<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

<html lang="{{ page-lang }}">
<head>
<title>{{ page.title }} | {{ site.title }}</title>
{% include head.inc %}
</head>
<body>
<main>

{{ content }}

</main>

<script src="./main.js"></script>

</body>
</html>
