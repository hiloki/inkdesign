---
layout: post
title: Jekyll
description: 
---

{% highlight perl %}
my @ramen = qw/jekyll git/;
{% endhighlight %}

{% highlight css %}
body {
	background: red;
}
{% endhighlight %}

{% highlight html %}
    <div class="sc sc-1">
      <p class="entry-date small">{{ post.date | date: "%Y-%m-%d" }}</p>
    </div>
    <div class="sc sc-5">
      <h1 class="entry-title h2"><a href="{{ post.url }}">{{ post.title }}</a></h1>
    </div>
{% endhighlight %}