---
layout: post
title: 画像からCSS Gradientのスタイルを抽出する
description: オンラインのツールを使い、アップロードした画像のグラデーションスタイルを抽出する。
categories:
  - notes
---
デザインカンプとして作られた画像のグラデーションをCSS化するために、PhotoshopやらFireworksで色を抽出してつくるは面倒くさい。単純にfromからtoまでの色を指定するだけであればそうでもないかもしれないが、すこし複雑な形状をしたグラデーションだと、正確に再現するのはむずかしい。

ただPhotoshopであれば、[.psdファイル上でスタイルを取得するスクリプト](http://www.skyward-design.net/blog/archives/000102.html)があったり、Fireworks CS6でも[オブジェクトのCSSを取得できる](http://stocker.jp/diary/fireworks-cs6/)らしい。

しかしこれらのような元のデザインデータが無いとか、基本的なフィルタのみで作られていないオブジェクトであればうまく抽出することができないこともあるので、画像（画像ファイル）そのものから抽出するツールを紹介する。

## 画像ファイルをアップロードして抽出する

[Ultimate CSS Gradient Generator - ColorZilla.com](http://www.colorzilla.com/gradient-editor/)

もしかしたら使ったことがある人も多いかもしれないが、このウェブサービスは、PhotoshopなどのツールライクなUIでグラデーションを指定し、スタイルを生成するサービスだ。

Presetsから用意されているパターンを選び、そこから色を変えることもできるし、ツマミを調整すれば独自のグラデーションをつくることができる。

変更はそのまますぐに右側にあるCSSに反映されるので、それをコピーすればいい。

今回はこのツールの使い方の説明は省き、表題の画像をアップロードして抽出する方法を紹介する。そもそも難しいツールでもないので、触れば今回紹介する機能含め、簡単に使えるので試してほしい。

## import from image からアップロードするだけ

![import from imageのキャプチャ](/images/posts/gradient-imports-from-image-import.png)

実は使い方として解説するということもなく、__import from image__をクリックして画像をアップするだけだ。

実際にアップロードしてみたものをいくつか挙げる。

### 単純なグラデーション

![単純なグラデーションのサンプル](/images/posts/gradient-imports-from-image-gradient.png)

{% highlight css %}
div {
	background: #669900;
	background: -moz-linear-gradient(top,  #669900 0%, #1d6176 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#669900), color-stop(100%,#1d6176));
	background: -webkit-linear-gradient(top,  #669900 0%,#1d6176 100%);
	background: -o-linear-gradient(top,  #669900 0%,#1d6176 100%);
	background: -ms-linear-gradient(top,  #669900 0%,#1d6176 100%);
	background: linear-gradient(to bottom,  #669900 0%,#1d6176 100%);
}
{% endhighlight %}

下記はこのスタイルを適用したもの。

<div id="gradient-imports-from-image-gradient">
<style scoped="scoped">
#gradient-imports-from-image-gradient div {
	display: block;
	width: 180px;
	height: 96px;
	background: #669900;
	background: -moz-linear-gradient(top,  #669900 0%, #1d6176 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#669900), color-stop(100%,#1d6176));
	background: -webkit-linear-gradient(top,  #669900 0%,#1d6176 100%);
	background: -o-linear-gradient(top,  #669900 0%,#1d6176 100%);
	background: -ms-linear-gradient(top,  #669900 0%,#1d6176 100%);
	background: linear-gradient(to bottom,  #669900 0%,#1d6176 100%);
}
</style>
	<div>&nbsp;</div>
</div>

どうでしょうか、だいたい一緒に見えますかね。

### 少し複雑なグラデーション

![少し複雑なグラデーションのサンプル](/images/posts/gradient-imports-from-image-complex.png)

ボタンのようなグラデーション。少し中央がずれてしまったけれど、とりあえず。

{% highlight css %}
div {
	background: #ff9966;
	background: -moz-linear-gradient(top,  #ff9966 0%, #ff7b57 52%, #ff4f41 54%, #ff3333 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ff9966), color-stop(52%,#ff7b57), color-stop(54%,#ff4f41), color-stop(100%,#ff3333));
	background: -webkit-linear-gradient(top,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
	background: -o-linear-gradient(top,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
	background: -ms-linear-gradient(top,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
	background: linear-gradient(to bottom,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
}
{% endhighlight %}

CSSを適用したのは下記。

<div id="gradient-imports-from-image-complex">
<style scoped="scoped">
#gradient-imports-from-image-complex div {
	display: block;
	width: 180px;
	height: 96px;
	background: #ff9966;
	background: -moz-linear-gradient(top,  #ff9966 0%, #ff7b57 52%, #ff4f41 54%, #ff3333 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ff9966), color-stop(52%,#ff7b57), color-stop(54%,#ff4f41), color-stop(100%,#ff3333));
	background: -webkit-linear-gradient(top,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
	background: -o-linear-gradient(top,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
	background: -ms-linear-gradient(top,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
	background: linear-gradient(to bottom,  #ff9966 0%,#ff7b57 52%,#ff4f41 54%,#ff3333 100%);
}
</style>
	<div>&nbsp;</div>
</div>

ちょっとずれた位置まで丁寧に再現されているものの、画像の方の中央のボケが無くなっている。

### 円形グラデーション

[円形グラデーションもサポートしている](http://www.colorzilla.com/gradient-editor/#whats-new)ようだが、画像アップロードの方はどうだろうか。

![円形グラデーションのサンプル](/images/posts/gradient-imports-from-image-circle.png)

{% highlight css %}
div {
	background: #ffcc00;
	background: -moz-radial-gradient(center, ellipse cover,  #ffcc00 0%, #ffcc00 100%);
	background: -webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%,#ffcc00), color-stop(100%,#ffcc00));
	background: -webkit-radial-gradient(center, ellipse cover,  #ffcc00 0%,#ffcc00 100%);
	background: -o-radial-gradient(center, ellipse cover,  #ffcc00 0%,#ffcc00 100%);
	background: -ms-radial-gradient(center, ellipse cover,  #ffcc00 0%,#ffcc00 100%);
	background: radial-gradient(ellipse at center,  #ffcc00 0%,#ffcc00 100%);
}
{% endhighlight %}

抽出したコードを見ても分かるとおもうが、色は1色しか抜けていない。

<div id="gradient-imports-from-image-circle">
<style scoped="scoped">
#gradient-imports-from-image-circle div {
	display: block;
	width: 180px;
	height: 180px;
	background: #ffcc00;
	background: -moz-radial-gradient(center, ellipse cover,  #ffcc00 0%, #ffcc00 100%);
	background: -webkit-gradient(radial, center center, 0px, center center, 100%, color-stop(0%,#ffcc00), color-stop(100%,#ffcc00));
	background: -webkit-radial-gradient(center, ellipse cover,  #ffcc00 0%,#ffcc00 100%);
	background: -o-radial-gradient(center, ellipse cover,  #ffcc00 0%,#ffcc00 100%);
	background: -ms-radial-gradient(center, ellipse cover,  #ffcc00 0%,#ffcc00 100%);
	background: radial-gradient(ellipse at center,  #ffcc00 0%,#ffcc00 100%);
}
</style>
	<div>&nbsp;</div>
</div>

つまりこうなる。

個人的には、線形のグラデーションと比べると、実用的にもあまり円形のCSSグラデーションを使う機会は少ないので、再現できなくてもとりあえずは気にしないでおく。

## 100%の再現とはいえない

円形はともかく、複雑なグラデーションのサンプルのように、完全に再現するためのコードは線形のものでも100%なものは生成されない。見た目の再現を重要視するなら、そのまま画像を使う方が良いかもしれない。それでもかなり簡単なものなのでおすすめする。

## 探せば他にもあるかも

[Nicole Sullivan](http://www.stubbornella.org/content/2011/04/25/css-3-gradients/)氏の記事で紹介されたもの中には[コマンドラインツール](https://github.com/bluesmoon/pngtocss)もある様子。おそらく同じようにコマンドラインで実行するのはあると思われるので、また見つけて試せたら記事にしたい。

