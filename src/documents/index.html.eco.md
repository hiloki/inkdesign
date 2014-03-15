---
layout: 'default'
---

<% for post in @getFilesAtPath('posts',[date: -1]).toJSON()[0..0]: %>
<article class="entry l-container">
	<header class="entry__header">
		<h1 class="entry__title"><a href="<%= post.url %>"><%= post.title %></a></h1>
		<p class="entry__date brand-type"><i class="icon icon--drop"></i> <span class="quiet">Published on</span> <%= post.humanDate %></h1>
	</header>
	<div class="entry__body entry__body--excerpt">
		<p><%= post.description %></p>
	</div>
</article>
<% end %>

<ul class="entry-list l-container">
<% for post in @getFilesAtPath('posts',[date: -1]).toJSON()[1..20]: %>
	<li>
		<a href="<%= post.url %>">
			<div class="entry-list__date brand-type"><%= post.humanDate %></div>
			<div class="entry-list__title"><%= post.title %></div>
		</a>
	</li>
<% end %>
</ul>
