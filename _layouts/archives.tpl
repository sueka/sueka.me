<!DOCTYPE html>

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

<ul class="posts">
{% for post in page.posts %}
  <li>
    <span class="post-date">{{ post.date | date: "%b %-d, %Y" }}</span>
    <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
  </li>
{% endfor %}
</ul>

</main>

{% include footer.inc %}

</body>
</html>
