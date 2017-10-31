{% capture license %}<a href="{{ site.license_url }}">{{ site.license }}</a>{% endcapture %}
{% capture repository %}<a href="https://github.com/{{ site.github_repo }}">{{ site.github_repo }}</a>{% endcapture %}

<header>

{% if include.this-lang == "ja" %}
  <h1 class="home">
    <a href="{{ "/index-ja.html" | relative_url }}">
      <img alt="home" width="24" height="24" src="{{ "assets/images/favicon.svg" | relative_url }}" />
    </a>
  </h1>
  <nav>
    <ul>
      <li><a href="{{ "/about-me-ja.html" | relative_url }}">作者について</a></li>
    </ul>
  </nav>
{% else %}
  <h1 class="home">
    <a href="{{ "/" | relative_url }}">
      <img alt="home" width="24" height="24" src="{{ "assets/images/favicon.svg" | relative_url }}" />
    </a>
  </h1>
  <nav>
    <ul>
      <li><a href="{{ "/about-me.html" | relative_url }}">About me</a></li>
    </ul>
  </nav>
{% endif %}

</header>
