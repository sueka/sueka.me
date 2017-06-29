<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

<html lang="{{ page-lang }}">
<head>
<title>{{ page.title }}</title>
{% include head.inc %}
</head>
<body>
<h1>{{ page.title }}</h1>

{% include languages.inc this-lang=page-lang %}

{{ content }}

{% include recent-posts.inc this-lang=page-lang %}

{% include footer.inc this-lang=page-lang %}

</body>
</html>
