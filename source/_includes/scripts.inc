<script src="{{ 'assets/scripts/header-anchor-generator.js' | relative_url }}"></script>
<script src="{{ 'assets/scripts/scroll-indicator.js' | relative_url }}"></script>
{% for extra-script in page.extra-scripts %}
  <script src="{{ 'assets/scripts/' | append: extra-script | append: '.js' | relative_url }}"></script>
{% endfor %}
