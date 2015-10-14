---
layout: 'notes'
title: Sass3.3の@at-rootで親のルールを指定する
description: Sass3.3の@at-rootを使ってちょっとしたことを試した。
date: 2014-02-16
tags: sass
---

先日登壇した[CSS Nite LP, Disk 32](http://cssnite.jp/lp/lp32/)のセッションで紹介されていた[SassのMixin](https://github.com/geckotang/cssnite-lp32/blob/master/scss/_trbl.scss)をSass3.3の@at-rootで少し手を加えてみる、という話。

紹介されていたのは、[天地左右中央に絶対配置するテクニック](http://codepen.io/shshaw/full/gEiDt)のMixin。

```css
@mixin trbl($width: null, $height: null) {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	width: $width;
	height: $height;
	margin: auto;
}

.tbrl {
  @include trbl(100px,50px);
}
```

```css
.tbrl {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  width: 100px;
  height: 50px;
  margin: auto;
}
```

この仕組については先の記事をみてもらうとして、このMixinの内容は、これらのコードを提供し、任意で`width`、`height`の値を渡せるようになっている。

このテクニックを使う条件として必要になるのは、`position:absolute`の基点、つまり`position:relative`が必要となる。  
（無論、`body`を基点とするならその限りではないが）

それを解決というか、それなりに利便性を考えるとすれば次のような方法が浮かぶ。

```css
.ref {
  position: relative
}

.tbrl {
  ...
}
```

```html
<div class="ref">
  <div class="tbrl">foo</div>
</div>
```

例えば`.ref`のような`position:relative`の汎用クラスを容易し、この`.tbrl`を使うときに基点を指定する場合には、`.ref`を使いましょう、とするような方法。

次に本題であるSass3.3の`@at-root`を使う方法。

```css
// ----
// Sass (v3.3.0.rc.3)
// Compass (v1.0.0.alpha.18)
// ----
 
@mixin trbl($width: null, $height: null, $parent: null) {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  width: $width;
  height: $height;
  margin: auto;
  @at-root #{$parent} {
    position: relative;
  }
}
 
.tbrl {
  @include trbl(100px, 50px, ".tbrl-wrapper");
}
```

```css
.tbrl {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  width: 100px;
  height: 50px;
  margin: auto;
}
.tbrl-wrapper {
  position: relative;
}
```

```
<div class="tbrl-wrapper">
  <div class="tbrl">foo</div>
</div>
```

`@mixin trbl()`に加えたのは`@at-root`の記述と、基点となる親のセレクタをつくるための引数。`@at-root`ディレクティブは記述上ネストされているが、コンパイルされたときにそれはネストされずに出力される。それを利用して、このような書き方ができる。

この例だと結局`position:relative`を持たせているだけなので、先に紹介した`.ref`みたいな汎用クラスを使うのと対して変わらないといえば変わらないが、tbrlというコンポーネントとしてルールをまとめるという設計で考えると、後者のような形の方が良いのではと考えた。  
（実際便利なのかどうか置いといて）

`@at-root`はよく[BEMなルールを書くときに役立ちそう](http://blog.ruedap.com/2013/10/29/block-element-modifier)だと紹介されているのをよく見るが、こんな使い方もできるな、という話でした。

あと気軽にSass3.3を試すなら[SassMeister](http://sassmeister.com/)が便利。