---
layout: 'notes'
title: 擬似要素のCSSアニメーションはinheritを使えば有効になる
description: 擬似要素に対するアニメーションは一部のブラウザを除いて無効となるが、該当のプロパティを親から継承させると有効となるらしい。
date: 2012-12-01
tags: css
---
Joshua Hibbert氏の記事、[Don't Forget the CSS Value 'inherit' - Joshua Hibbert](http://joshnh.com/2012/10/25/dont-forget-the-css-value-inherit/)では忘れられがちな`inherit`による値の継承について説明している。

`inherit`を使えば親要素のスタイルの継承ができるが、これは要素とその擬似要素の関係においても、擬似要素が継承させることができる。

で、この記事における本題としては、Bonus transition trickとして紹介されている、<q>inheritを使えば、擬似要素でもCSSアニメーションが有効になる</q>という話のこと。

## 擬似要素では"基本的に"アニメーションが無効となる

[Hibbert氏の記事にあるbasic sample](http://jsfiddle.net/joshnh/Fa9PH/)を見てもらうとわかるのだが、右側（赤い方）では擬似要素に大しては継承を使っておらず、そのためアニメーションになっていない。大して一方では擬似要素もアニメーションをしており、該当のスタイルをみると`inherit`を使っているのが確認できる。		

```css
div {
  border: 2px solid black;
  -webkit-transition: .5s;
  transition: .5s;
}
div:hover {
  /* マウスオーバー時に背景色とボーダーの線の色を変える */
  background: blue;
  border-color: white;
}
.yay {
  background-color: green;
}
.yay:after {
  background-color: inherit; /* 継承 */
  border: inherit; /* 継承 */
}
```

## 覚えておいて損はないかも

実務上ではあまりこれにハマることは少ないかもしれないが、同記事の[別のサンプル](http://jsfiddle.net/joshnh/ELDet/)のようなギミックを仕込むときなどには使そう。
