<!DOCTYPE html>

{% assign page-lang = page.lang | default: site.lang %}

{% case page.url %}
{% when '/' %}
  {% assign page-title = page.title %}
{% when '/index-ja.html' %}
  {% assign page-title = page.title %}
{% when '/index-he.html' %}
  {% assign page-title = page.title %}
{% else %}
  {% assign page-title = page.title | append: ' - ' | append: site.title %}
{% endcase %}

<html {% if page-lang == 'he' %} dir="rtl" {% endif %} lang="{{ page-lang }}">
<head>
<title>{{ page-title }}</title>
{% include head.inc %}
</head>
<body>

{% include header.inc %}

<main>

<h1>{{ page.title }}</h1>

<div class="container">
  <div class="side-column">

    {% include languages.inc %}

    {% include toc.inc %}

  </div>
  <div class="main-column">

    {{ content }}

    {% include main-source.inc %}

  </div>
</div>

</main>

{% include recent-posts.inc %}

{% include footer.inc %}

{% include header-anchor-generator.inc %}

</body>
</html>
