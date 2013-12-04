---
layout: 'note'
title: 'Sass,LESS,StylusのColor functionsのコンパイル結果を比べてみた'
description: '色系ファンクションのdarken()の結果に差がある気がしたので、調べてみた。'
date: 2012-11-28
tags: css
outDirPath: notes
---
[Sass](http://sass-lang.com/)、[LESS](http://lesscss.org/)、[Stylus](http://learnboost.github.com/stylus/)といったCSSプリプロセッサには、色を扱うビルトインファンクションがある。	

それらの機能はプリプロセッサごとにさまざまだが、共通して存在するファンクションの一つとして、`lighten(color,percentage)`、`darken(color,percentage)`といった引数に指定した色を明るく/暗くするというのがある。

明るく/暗く、といっても単純に明度を操作するのか、色々とごにょごにょしているのかは分からないが、とりあえず同じ書き方をするなら同じ値を返すだろう、という期待をしたくなるが、実際のところどうだろうか。

## ところでこれらの使い所はある？

結論からいうと、実務では色系のファンクションなかなかお世話になることはない。というのも現状Photoshopのデザインカンプを元に、そのカンプ上の色を抽出して、文字色や背景色とする。

ただHTMLのプロトタイプ先行での開発や、色に関して一定のルールや計算・設計をしている場合には、プリプロセッサの持つ色系ファンクションの機能を活用できるかもしれない。

非常に簡易的な例であげると、ボタンのように少し立体的に魅せるためのグラデーション表現などに、`darken(color,percentage)`は使える。

```scss
button {
	background-image: -webkit-linear-gradient(top,#EFEFEF,darken(#EFEFEF,30%));
}
```

このように、メインカラー（明るい方のカラー）の色に対し、`darken`を使って暗い色をつくるようにすれば、グラデーションをつくることができる。結果は下記。（例はSass）

```scss
button {
  background-image: -webkit-linear-gradient(top, #efefef, #a3a3a3);
}
```

## darkenのコンパイル後の結果を比べる

では本題ということで、例にもつかった`darken`をSass,LESS,Stylusそれぞれで使ってみる。ドキュメントを簡単に見る限りでは同じ効果を出すものに見えるが、結果はどうだろうか。

基本色、`darken`のパーセンテージをまったく一緒にして比べてみる。

### Sass

```scss
p {
  $textColor: #FF9933;
  color: darken($textColor,30%);
}
```

コンパイル結果：

```css
p {
  color: #994c00;
}
```

### LESS

```css
p {
  textColor: #FF9933;
  color: darken(@textColor,30%);
}
```

コンパイル結果：

```css
p {
  color: #994d00;
}
```

### Stylus

```css
p {
  textColor = #FF9933;
  color: darken(textColor,30%);
}
```

コンパイル結果：

```css
p {
  color: #d66b00;
}
```

### ということでまとめると、

- 元の色 : <span style="color:#FF9933">#FF9933</span>
- __Sass__ : <span style="color:#994c00">#994c00</span>
- __LESS__ : <span style="color:#994d00">#994d00</span>
- __Stylus__ : <span style="color:#d66b00">#d66b00</span>

## Stylusでは値の違いが顕著

特に理由なく、__<span style="color:#FF9933">#FF9933</span>__という色を選んでみた結果では、Stylusだけ大幅に異なる。
ちなみに元の色を__<span style="color:#DDDDDD">#DDDDDD</span>__としてみると、その違いの幅は小さい。

今回は`darken`の仕様を調べたわけではないので、この理由については今回説明しないが、気をつけるべきことは、これらのファンクションを使っていて、他のプリプロセッサに乗り換える場合だ。

同じようなファンクションだからといって、そのまま持ち込むと、このようにコンパイルしたあとCSSの値が変わることがあるということ。

これらプリプロセッサの内部仕様をあまりちゃんと読む機会がなかったので、これを機にみてみると面白いかもしれない。今回とりあげたファンクションについては、次のリンク先を参照してほしい。

- [Module: Sass::Script::Functions](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html#darken-instance_method)
- [LESS « The Dynamic Stylesheet language](http://lesscss.org/#-color-functions)
- [Stylus](http://learnboost.github.com/stylus/docs/bifs.html)

