<script src="{{ 'assets/scripts/header-anchor-generator.js' | relative_url }}"></script>
{% for extra-script in page.extra-scripts %}
  <script src="{{ 'assets/scripts/' | append: extra-script | append: '.js' | relative_url }}"></script>
{% endfor %}
