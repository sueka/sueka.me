{% assign paginator = include.paginator %}
{% if paginator.total_pages != 1 %}
  {% assign routing-to-page = site.pagination.permalink %}
  <nav class="pagination-nav">
    <ul>
      <li>
        {% if paginator.previous_page %}
          <a href="{{ paginator.previous_page_path }}" class="previous">←</a>
        {% else %}
          ←
        {% endif %}
      </li>
      {% for paginator_page_num in (1..paginator.total_pages) %}
        {% if paginator_page_num == 1 %}
          {% assign paginator_page_path = paginator.first_page_path %}
        {% else %}
          {% assign paginator_page_path = routing-to-page | replace: ':num', paginator_page_num %}
        {% endif %}
        {% assign paginator_page_index_path = paginator_page_path | append: 'index.html' %}
        <li>
          {% if paginator_page_index_path != page.url %}
            <a href="{{ paginator_page_path }}">{{ paginator_page_num }}</a>
          {% else %}
            {{ paginator_page_num }}
          {% endif %}
        </li>
      {% endfor %}
      <li>
        {% if paginator.next_page %}
          <a href="{{ paginator.next_page_path }}" class="next">→</a>
        {% else %}
          →
        {% endif %}
      </li>
    </ul>
  </nav>
{% endif %}
