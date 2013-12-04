---
layout: 'note'
title: 'スタイルガイド'
ignored: true
---

# 大見出し

## 中見出し

### 小見出し

段落段落段落段落段落段落

> 引用引用引用引用引用引用
> 引用引用引用引用引用引用
> 引用引用引用引用引用引用

- リスト
- リスト
- リスト

1. リスト
2. リスト
3. リスト

<small class="datetime">2013-11-10</small>

```
<div class="note-header">
	<p class="note-datetime"><%= @document.date() %></p>
	<h1 class="note-title"><%= @document.title %></h1>
</div>
<div class="note-content">
	<%- @content %>
</div>
```