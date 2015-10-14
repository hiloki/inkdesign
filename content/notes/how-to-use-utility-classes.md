---
layout: 'notes'
title: 'CSSの汎用クラスのつかいどころ'
description: '.mts{margin-top:10px}のようなルールのつかいどころについて。'
date: 2014-01-13
---
OOCSSをはじめとするCSS設計におけるモジュール指向のアプローチの話になると、下記のような単一プロパティで定義されたルールを組み合わせたものを指す、というような説明がされる場合がある。

```css
.size1of4 {
  width: 25%;
}

.mrs {
  margin-right: 10px;
}

.font-small {
  font-size: 10px;
}

.text-left {
  text-align: left;
}
```

これらはUtilityとか、Helperとか、汎用クラスというように呼ばれ、あれば何かと便利なルールだ。

どういうときに便利かというのは、唐突なデザイン変更要求などに、都度そのためのルールを定義するよりも、これらの汎用クラスの組み合わせで対応できるということが挙げられるだろう。  

```
<div class="mts text-center">
  <img src="banner.png" alt="キャンペーンバナー">
</div>
```

これが本当に一時的に使われるものであれば許容範囲ではあると思うが、すべてのモジュールがこのように構築されていくと、混沌としたコードになることがある。

```css
.mr10 {
  margin-right: 10px;
}

.mr11 {
  margin-right: 11px;
}

.mr13 {
  margin-right: 13px;
}

.mr15 {
  margin-right: 15px;
}

/* etc,etc... */
```

対象のサイト、アプリケーションが数百、数千もの'margin-right: 10px;'を宣言しているような規模であれば、これをひとつのモジュールとしてしまうような方法はありかもしれない。が、多くのサイトはそんなことはない。いずれにせよ、1px刻みでルールが増えるような状態は健全ではないので、それはデザイナーと<del class="strike">殴りあう</del><ins>話しあう</ins>方が良いとは思う。

で、ここからが本題。

次のような[Mediaオブジェクト](http://www.stubbornella.org/content/2010/06/25/the-media-object-saves-hundreds-of-lines-of-code/)がある。これをひとつのモジュールとして定義したい。

<div class="entry__media">
  ![](/images/how-to-use-utility-classes/01.png)
</div>

```html
<div class="media">
  <img src="http://placesheen.com/88/88" class="media__image" />
  <div class="media__body">Charlie Sheen</div>
</div>
```

```css
.media__image {
  display: block;
  float: left;
  margin-right: 20px;
}
```

注目してほしいところは、写真と本文の間のマージンである`margin-right: 20px;`の部分。  
この部分を先ほどの汎用クラスとして置き換えるならこうなる。

```html
<div class="media">
  <img src="http://placesheen.com/88/88" class="media__image mrm" />
  <div class="media__body">Charlie Sheen</div>
</div>
```

```css
.media__image {
  display: block;
  float: left;
}
.mrm { // Margin Right Medium
  margin-right: 20px;
}
```

このようにすれば、マージンが状況に応じて狭くしたいときも、`.mrs`などに置き換えれば`margin-right: 10px;`のようにすることができるだろう。

これはこれで、そのように**意図的に**設計されているのであれば良いが、個人的には**好ましいとは思わない**。  
なぜならオブジェクト/モジュールとしてそのルールを含めておくべきだと考えているからだ。

では上記のように値を変える必要があるならばどのようにするか。

```html
<div class="media">
  <img src="http://placesheen.com/88/88" class="media__image media__image--small" />
  <div class="media__body">Charlie Sheen</div>
</div>
```

```css
.media__image {
  display: block;
  float: left;
  margin-right: 20px;
}
.media__image--small { // Modifier
  margin-right: 10px;
}
```

`.media__image`のモディファイア（修飾パターン）として、`.media__image--small`で定義する、というアプローチだ。 

またはオブジェクト全体として小さめのサイズのものをつくるというならば、次のようなパターンもある。

```html
<div class="media media--small">
  <img src="http://placesheen.com/88/88" class="media__image" />
  <div class="media__body">Charlie Sheen</div>
</div>
```

```css
.media--small media__image {
  margin-right: 10px;
}
```

この場合は`.media`のモディファイアとして、`.media--small`を定義し、その子である`.media__image`をスタイルを調整している。

これがもちろん**すべてのケースに置いて正しいとはいえない**のだが、モジュール設計においては、単純にルールを再利用したいという理由だけで汎用クラスをその中に組み込むべきではない、と考えている。

一方で**汎用クラスが使える**ケースもある。それは異なるモジュール間でのレイアウトのために使われるような時だ。

```html
<div class="photo mbs">...</div>
<div class="media mbm">...</div>
<div class="comment">...</div>
```

これも設計や実装によりけりだが、モジュール間のレイアウト関係に関するルールは、そのモジュール自体には持たせない方が良いこともある。つまりは次のように、`.media`モジュールに対し、`margin-bottom: 10px`といった値を持たせるべきではない、ということだ。

```css
.media {
  /* Some rules */
  margin-bottom: 10px;
}
```

このようにすべき、という兆しは、次のようなルールがいたるところで見えてきたときだ。

```html
<div class="media mb0">...</div>
```

```css
.media {
  /* Some rules */
  margin-bottom: 10px;
}

.mb0 {
  margin-bottom: 0;
}
```

これは`.media`に`margin-bottom`を持たせるべきではなかった、というのが明らかになっている。

## まとめ

こういう話をするたびに付け加えるのは、**これがすべてのケースにおいて正しい**わけではないということ。こういうことを一応書いておかないと、どこかのBEMのように変なひとり歩きをすることがあるので。

あと加えて汎用クラスを使った[きゅうきょくのしーえしゅえしゅ](http://t32k.me/mol/log/the-perfect-css-i-thought/)もあるが、これはこれで非常に面白い。  このフレームワークが誕生した経緯と、その成果を目にしているものとしては素晴らしいアプローチと評価する反面、下手にこのアプローチを採用することは、本記事でも書いたとおり、混沌しか生み出さないこともあるので気をつけよう。





