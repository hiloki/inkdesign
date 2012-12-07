---
layout: post
title: iOS6とかでのborder-imageではfillのことを忘れないように
description: iOS6のMobile Safariでborder-imageの中身が塗りつぶされていないことに気づいたので調べた。
categories:
  - notes
---

`border-image`プロパティは一般的によく使われているのか使われていないのかわからないが、個人的にはモバイル向けWeb開発で結構使っている。

例えば次のような、スケーラブルであることが必要となるところには大体使う。

