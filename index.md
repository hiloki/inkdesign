---
layout: default
---
<!-- {% assign first_post = site.posts.first %}
<h1><a href="{{ first_post.url }}">{{ first_post.title }}</a></h1>
<p class="meta">{{ first_post.date | date_to_string }}</p>
{{ first_post.content }} -->

<div class="entries">
  {% for post in site.posts %}
  <article class="sc-row entry">
<!--     <div class="sc sc-5 sc-1-off entry-header">
      <h1 class="entry-title h2"><a href="{{ post.url }}">{{ post.title }}</a></h1>
    </div> -->
    <div class="sc sc-1">
      <p class="entry-date small">{{ post.date | date: "%Y-%m-%d" }}</p>
    </div>
    <div class="sc sc-5">
      <!--  {{ post.content | strip_html }} -->
      <h1 class="entry-title h2"><a href="{{ post.url }}">{{ post.title }}</a></h1>
    </div>
  </article>
  {% endfor %}
</div>
