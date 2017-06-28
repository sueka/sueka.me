<!DOCTYPE html>

{% assign self-lang = page.lang | default: site.lang %}

<html lang="{{ self-lang }}">
<head>
<title>{{ page.title }}</title>
{% include head.inc %}
</head>
<body>
<h1>{{ page.title }}</h1>

{% include languages.inc this-lang=self-lang %}

{{ content }}

{% include recent-posts.inc this-lang=self-lang %}

{% include footer.inc this-lang=self-lang %}

</body>
</html>
