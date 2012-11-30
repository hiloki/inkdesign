---
layout: post
title: CSSが速くかけるようになるSublime Text2 パッケージ Hayakuで、世界が変わるらしい
description: CSSを速く書くためのSublime Text2パッケージ、Hayakuを試してみた。
categories:
  - notes
---
[Zen CodingもといEmmet](/notes/2012/11/27/zencoding-to-emmet.html)を使いこなすとまでいかなくとも、それなりに使ってはいるが、実はCSSではあんまり活用していなかった。

というもCSSに関しては、多少Emmetや他のコード補完プラグイン（パッケージ）の支援はあるものの、HTMLよりも手グセというか、自然とプロパティなり値なりをさっさと書いてしまうし、それほどありがたい、と思えるほどでもない。

またZen Codingにせよ、Emmetにせよ、短縮形のルールが決まっているし、それらを覚えないといけないので少し大変だ。

<ins datetime="2012-11-30">__追記（2012-11-30）:__ Emmetでも若干[ファジーに書ける](http://docs.emmet.io/css-abbreviations/fuzzy-search/)様子。
</ins>

## そこでHayaku、らしい

二度見しそうな名前だが、これは[Hayaku](http://hayakubundle.com/)というSublime Text2のパッケージ。Emmetと違い、対象になるのはCSS（とCSSプリプロセッサ）であり、前述の通りCSSの記述に関してはこれといったツールを使っていない自分でも感動した。

ちなみにHayakuについてはもうすでに[Sublime Text2を布教しているエライ人](https://gist.github.com/4135513)によって簡潔にまとめられているが、とりあえずひと通りやってみた、ってことで書いていく。

## とりあえずHayakuで何ができるのか

CSSで`overflow:hidden`と書きたいとき、どうタイプするか？

もちろんCSSとして書くならもちろんそのまま書くでしょうが、
これをEmmetで書く場合はこう。

{% highlight css %}
div {
	/* ov:h とタイプして、Tabキーとか */
	overflow: hidden;
}
{% endhighlight %}

`ov:h`とタイプするのはEmmetパッケージにある、__snippet.json__というファイルで定義されていて、この書き方じゃないと展開しない（はず）。

で、Hayakuです。

{% highlight css %}
div {
	/* oh とタイプして、Tabキーとか */
	overflow: hidden;
}
{% endhighlight %}

これはHayai。

Hayakuがすごいのは実はこれじゃない。

{% highlight css %}
div {
	/* oh とタイプして、Tabキーとか */
	/* o:h とタイプして、Tabキーとか */
	/* o:h とタイプして、Tabキーとか */
	/* ov:h とタイプして、Tabキーとか */
	/* overfl:hidn とタイプして、Tabキーとか */
	overflow: hidden;
}
{% endhighlight %}

これはHidoi。いやSugoi。

なんかもうノリでタイプすれば、それが出る。
これでもうHayakuが気になった人は、次へ進んでください。

## Hayakuのインストール

多くは語るまい。Sublime Text2な人なおなじみの、__Install Package__から__"Hayaku"__と叩けばOK。

## Emmetとの共用

この手のパッケージはキーバインドがぶつかりやすいので気をつけること。<kbd>Tab</kbd>キーでの展開がHayakuでもEmmetでもデフォルトとなっているので、あらかじめそれを回避しておく。これはEmmetの方のパッケージ設定でおこなう。

__Preference__ > __Package Settings__ > __Emmet__ > __Setting - User__

何も手を入れてなければ、おそらくこの中は空っぽであるはずなので、ここに下記のような設定をいれておく。

{% highlight json %}
{
	// TABキーによる展開を対象の言語（ファイル）のときに無効化する
	"disable_tab_abbreviations_for_scopes": "css,less,sass,scss,stylus"
}
{% endhighlight %}

ちなみにこれを見て、もしかして、思ったかもしれないが、CSSを書くときだけでなく、SassやLESSなどのCSSプリプロセッサで書く場合にもHayakuは使える。

ここで少しSublime Text2の設定についての補足をしておくと、前述の設定までのパスを追っていくと、__Users__ではなく、__Default__というのも参照できるが、設定を変える場合には__Default__を書き換えるのではなく、__Users__の方に書くようにする。そうすることで__Default__の設定を上書きすることができる。

## Hayakuの機能をいくつか紹介

ではHayakuでの書き方をいくつか紹介する。

{% highlight css %}
div {
	/* wd */
	wd → width: 100%;
}
{% endhighlight %}

それっぽい二文字くらいで大体展開。

{% highlight css %}
div {
	/* wd */
	wd → width: 100%;
	/* m10 */
	margin: 10px;
	/* pt-10 */
	padding-top: -10px;
	/* fs1.5 小数点をつけるとem */
	font-size: 1.5em;
	/* cF */
	color: #FFF;
	/* bx0.5 */
	-webkit-box-shadow: rgba(0,0,0,.5);
	        box-shadow: rgba(0,0,0,.5);
	/* di! */
	display: inline !important;
}
{% endhighlight %}

{% highlight css %}
div {
	/* m10 */
	margin: 10px;
	/* pt-10 */
	padding-top: -10px;
	/* fs1.5 小数点をつけるとem */
	font-size: 1.5em;
}
{% endhighlight %}

数字をいれるとこんな感じ。Emmetに近いけど、少しだけ違う。Emmetだとショートハンドで書きたいときに、`w10-8`みたいな書き方で展開できる。Hayakuでは今のところそれができないのでちょっと不便。

{% highlight css %}
div {
	/* cF */
	color: #FFF;
	/* bx0.5 */
	-webkit-box-shadow: rgba(0,0,0,.5);
	        box-shadow: rgba(0,0,0,.5);
}
{% endhighlight %}

色の指定を加えるならこんな感じ。`rgba`の書き方はちょっと感動。

{% highlight css %}
div {
	/* di! */
	display: inline !important;
}
{% endhighlight %}

`!`をつければ、`!important`を追加。たまーに使う。

## とりあえず入れてて損はない

設定を変えないとEmmetなどとぶつかるというのはあるとして、基本的には邪魔をするものでもないし、ミスタイプをしたときも勢いでカバーできるっていうイメージで導入してみるとどうでしょうか。

