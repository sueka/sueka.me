{% assign lang = include.lang | default: page.lang %}
{% capture license %}<a href="{{ site.license_url }}" rel="license">{{ site.license }}</a>{% endcapture %}
{% capture repository %}<a href="https://github.com/{{ site.github_repo }}">{{ site.github_repo }}</a>{% endcapture %}
<footer class="footer">
  <p>
    {% case lang %}
    {% when 'ja' %}
      <a href="/">{{ site.title }}</a> のソースコードは {{ license }} でライセンスされ、 GitHub 上のリポジトリ {{ repository }} で公開されてゐます。
    {% else %}
      The source code of <a href="/">{{ site.title }}</a> is available on GitHub at {{ repository }} under the {{ license }}.
    {% endcase %}
  </p>
</footer>
