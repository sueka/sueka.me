<script src="https://cdnjs.cloudflare.com/ajax/libs/incremental-dom/{{ site.incremental_dom_version }}/incremental-dom-min.js"></script>
<script src="{{ 'assets/scripts/header-anchor-generator.js' | relative_url }}"></script>
<script src="{{ 'assets/scripts/scroll-indicator.js' | relative_url }}"></script>
{% if page.use-fetch %}
  <script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/{{ site.es6_promise_version }}/es6-promise.auto.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/fetch/{{ site.fetch_version }}/fetch.min.js"></script>
{% endif %}
{% for extra-script in page.extra-scripts %}
  <script src="{{ 'assets/scripts/' | append: extra-script | append: '.js' | relative_url }}"></script>
{% endfor %}
