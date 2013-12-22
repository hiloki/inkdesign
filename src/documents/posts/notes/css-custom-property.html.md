---
layout: 'notes'
title: 'CSSカスタムプロパティとMythの話'
description: 'カスケード変数のためのCSSカスタムプロパティを試してみた。本記事は CSS Property Advent Calendar 2013 の記事。'
date: 2013-12-23
tags: css
---

[CSS Custom Properties for Cascading Variables Module](http://dev.w3.org/csswg/css-variables/)はCSSで変数を使うために、その変数を定義するためのプロパティについての仕様だ。

これが先日[Firefox Nightly 29](http://nightly.mozilla.org/)で実装されたらしく、ちょっとお触りしてみた。これについては同じようにお触りされた記事、[Playing around with CSS variables - "custom properties"](http://thatemil.com/blog/2013/12/15/playing-around-with-css-variables-custom-properties/)が良かったのでこっちも参照するのをおすすめする。

## 基本的な使い方

CSSで変数というと、[Sass](http://sass-lang.com/)や[LESS](http://lesscss.org/)などのプリプロセッサとして使うことができ、そのあたりで使ったことがあるのであれば、CSSerの人でもなんとなく馴染みやすい仕様かもしれない。とはいえ定義とその参照方法はSassやLESSのそれとは全然異なる。

```css
/*
変数を定義する。
`var-`の後が参照する時のキーになる。
 */
:root {
  var-box-padding: 20px;
  var-background-color: green;
  var-text-color: white;
}

/*
`var()`で参照する。
*/

.box {
  padding: var(box-padding);
  background-color: var(background-color);
  color: var(text-color);
}
```

上記のように書けば、次のようなCSSを書いたときと同等になる。

<div class="entry__media">
![](/images/css-custom-property/01.png)
</div>

```css
.box {
  padding: 20px;
  background-color: green;
  color: white;
}
```

## 変数をどう使うか

Sassの時でもあんまり自分は変数をそれほど有用性のある使い方をしているとは思わない。が、その中でも使えると思うのは、そのプロジェクトのキーカラーの定義を`$keyColor: red`とするような使い方がまず一つ。カスタムプロパティでは`var-key-color: red`というように。

他にはメディアクエリで特定のスクリーンサイズ向けの定義を各所でおこないたい場合には、その条件を変数として定義することがある。

```css
$tablet: 40em;

@media only screen and (max-width: $tablet) {
  body {
    color: blue;
  }
}
```

しかしこのノリでカスタムプロパティで実現しようとしても上手くいかなかった。

```
:root {
  var-query-tablet: 40em;
}

@media only screen and (max-width: var(query-tablet)) {
  body {
    color: blue;
  }
}
```

これを実現する方法は今のところ浮かんでない。閃けばまたの機会に。

あとおまけで、次のページにアクセスすると、[対象ブラウザがカスタムプロパティに対応しているかどうか分かる](http://cdpn.io/Dfbng)ようにしてみた。すごく馬鹿げたような方法でやってみたので、FirefoxのNightly 29をもしインストールしたならば覗いてみてほしい。

## スコープとポストプロセッサーMyth

先に紹介した記事ではあまり触れられていなかったスコープについて検証してみる。Sassなどではネストの中で変数に違う値が入れば、そちらが優先される。

```scss
$color: blue;

h1 {
  color: $color; // blue
}

.first {
  $color: green;
  h1 {
    color: $color; // green
  }
}
```

次のようになる。

```css
h1 {
  color: blue;
}

.first h1 {
  color: green;
}
```

ではカスタムプロパティでの変数のスコープはどうなっているのか。同じようなコードを用意する。

```
:root {
  var-color: blue;
}

h1 {
  color: var(color); /* blue */
}

.first {
  var-color: green;
}
```

この結果は[次のようになる](http://codepen.io/hiloki/pen/JgvIr)。

<div class="entry__media">
![](/images/css-custom-property/02.png)
</div>

ここで注目したいところは、Sassの例のように`.first h1 {...}`というように再度`h1`ルールを定義しなおしていない点だ。これによってはSassにおける変数と、カスタムプロパティにおける変数の扱いに違いがあるのがわかる。

さてここで先日登場した[Myth](http://www.myth.io/)というプリプロセッサの話を絡める。Mythは従来のプリプロセッサとは異なり、CSS Polyfillといったアプローチでつくられている。構文も独自のものではなく、進行中の仕様と同様の構文で書くことができる。その中には本記事のテーマであるカスタムプロパティも含まれており、Mythを介して非対応ブラウザでも使えるように**みえる**。

このアプローチは面白いなぁと思っていたところ、[@cssradar](https://twitter.com/cssradar)から、CompassのChrisが[インチキだとお怒り](https://gist.github.com/chriseppstein/8016527)であることを聞いた。

その具体的な例として、先ほどのスコープのくだりで説明したコードをそのままMythに通してみる。そうすると次のようなコードになる。

```css
body {
  text-align: center;
}

h1 {
  color: blue;
}

.first {
  var-color: green;
}
```

これは本来のカスタムプロパティの仕様として期待されるものではない。つまりはMythは一見はCSSの仕様通りに振るまいそうな打ち出し方であったものの実際には異なるということだ。
そもそもMythの内部は、Sass、LESSに次いて使われているであろう[Stylus](http://learnboost.github.io/stylus/)の開発者である[TJがつくったRework](http://tjholowaychuk.com/post/44267035203/modular-css-preprocessing-with-rework)の機能を元にしている。その中の[変数](https://github.com/visionmedia/rework-vars)の機能での説明では下記のように補足されている。

> N.B. This is not a polyfill. This plugin aims to provide a future-proof way of using a limited subset of the features provided by native CSS variables.

あくまでこの機能で提供されるのはグローバルの変数のみだということだ。（少なくとも現状は。）
とはいえ、Mythには期待をしてるので、引き続き様子をみて触ってみたい。

## なかなか奥が深いカスタムプロパティ

色々と試してみたものの、まだあまり上手く使える気はしないものの、これが他のブラウザでも実装されるようになれば色々とアイデアを考えてみたいものだ。

## というわけで

本記事は[CSS Property Advent Calendar 2013](http://www.adventar.org/calendars/57)の23日目の記事として書いた。  
次は[noha_koさん](http://www.adventar.org/users/2499)です。


