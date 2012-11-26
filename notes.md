---
layout: default
---
<div class="entries">
  {% for post in site.posts %}

  {% if post.categories contains 'notes' %}

  <article class="sc-row entry">
    <div class="sc sc-1">
      <p class="entry-date small">{{ post.date | date: "%Y-%m-%d" }}</p>
    </div>
    <div class="sc sc-5">
      <!--  {{ post.content | strip_html }} -->
      <h1 class="entry-title h2"><a href="{{ post.url }}">{{ post.title }}</a></h1>
    </div>
  </article>
  
  {% endif %}

  {% endfor %}
</div>
