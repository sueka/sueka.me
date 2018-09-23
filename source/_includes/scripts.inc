<script src="https://cdnjs.cloudflare.com/ajax/libs/incremental-dom/{{ site.incremental_dom_version }}/incremental-dom-min.js"></script>
<script src="{{ 'assets/scripts/header-anchor-generator.js' | relative_url }}"></script>
<script src="{{ 'assets/scripts/scroll-indicator.js' | relative_url }}"></script>
{% if page.use-katex %}
  <script src="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/{{ site.katex_version }}/katex.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/{{ site.katex_version }}/contrib/auto-render.min.js"></script>
  <script src="{{ 'assets/scripts/katex-renderer.js' | relative_url }}"></script>
{% endif %}
{% for extra-script in page.extra-scripts %}
  <script src="{{ 'assets/scripts/' | append: extra-script | append: '.js' | relative_url }}"></script>
{% endfor %}
