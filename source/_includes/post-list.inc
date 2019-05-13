{% if include.posts and include.date-format-key %}

{% assign lang = include.lang | default: page.lang %}
{% assign translation = site.data.translations | where: 'langcode', lang | first %}
{% assign date-format = translation[include.date-format-key] %}
<ul class="post-list">
  {% for post in include.posts %}
    <li class="post-list-item">
      <dl>
        <dt class="post-list-item-term">{{ translation.posted-on }}</dt>
        <dd class="post-list-item-details">
          <time datetime="{{ post.date | date_to_xmlschema | slice: 0, 10 }}">{{ post.date | date: date-format }}</time>
        </dd>
        <dt class="post-list-item-term">{{ translation.post }}</dt>
        <dd class="post-list-item-details">
          <a {% if post.lang != lang %} lang="{{ post.lang }}" hreflang="{{ post.lang }}" {% endif %} href="{{ post.url }}">{{ post.title }}</a>
        </dd>
      </dl>
    </li>
  {% endfor %}
</ul>

{% endif %}
