---
layout: post
title: CSSプリプロセッサでスタイルガイド
description: サイトおよびページを構成するコンポーネントをスタイルガイド化するツールを紹介。
categories:
  - notes
---

※この記事は、[CSS Preprocessor Advent Calendar 2012](http://www.adventar.org/calendars/1)の7日目の記事です。

[CSS PreprocessorとIAの親和性](http://www.hitoyam.com/web/2012/12/04_1752.html)、という記事の影響を受けまして、こちらの記事で書かれていた、

> CSS Preprocessor そのものを共通ドキュメントにしてしまうとか

という点を拾わせていただき、__スタイルガイド__のツールを紹介しようとおもう。

## スタイルガイドとはなにか

スタイルガイドは簡単にいうと、[モバイル時代におけるCSSの設計と実装](http://ameblo.jp/ca-1pixel/entry-11413319214.html)から引用させてもらうと、ページ上の部品（コンポーネント）をあつめたリスト、ページのこと。デザインパターンと呼ばれることもあるかもしれない。

具体的な成果物としてどういったものを指すのかというのは実際のページをみてもらう方が早いとおもうので、一度下記のページも参照してほしい。

- [MailChimp Design Patterns](http://www.flickr.com/photos/aarronwalter/5579386649/sizes/o/in/photostream/)
- [Starbucs Style Guide](http://www.starbucks.com/static/reference/styleguide/)
- [Github Styleguide](https://github.com/styleguide/css)
- [Gimme Bar : Front end styleguides](https://gimmebar.com/collection/4ecd439c2f0aaad734000022/front-end-styleguides)

## スタイルガイドをどうやって作るか

あらかじめコンポーネント設計ができているという前提で、ソレを元にこうしたスタイルガイドをつくるにはどうすれば良いか。

ガイドラインやドキュメントというと、別途そうしたものをパワーポイントなり他のツールでそれらしいものをつくる、という方向に走ってしまうかもしれない。

それ自体は問題はないが、問題は__メンテナンスされるかどうか__だ。

開発上の仕様変更もあれば、運用をはじめてから発生する変更もある。それにともないデザインもコードも書き換わるわけなので、仮にスタイルガイドにあたるドキュメントをつくっていたとしても、そちらが更新されていないと意味がなく、より混乱をさせてしまうものになるかもしれない。

## スタイルガイドは"生きている"ドキュメントでなければいけない

スタイルガイドそのものはCSSにおけるスタイルということではなく、他の言語でもあるものだが、ここではCSSスタイルガイドということで話を進める。

CSSに記述されたルールセットが何を意味するのか、何をするものなのか、というのは__コメント__という形で書くことができる。

{% highlight css %}
/*
基本的なボタンのスタイル。

<button class="btn">次へ</button>
 */
.btn {
	display: inline-block;
	background-color: #CCC;
	...
}
/*
"保存"や"完了"など主要なボタンのスタイル。
.btnをベースとし、拡張する。

<button class="btn btn-primary">次へ</button>
*/
.btn-primary {
	display: inline-block;
	background-color: #33FF00;
	...
}
{% endhighlight %}

CSSの設計としてのわかりやすさを保つことはもちろん、このように第三者がみてもわかるようなコメントを残しておくのはスタイルガイドうんぬんとは別で残しておく方が好ましい。

しかしコードだけではこれがどのような見た目・表現となるのかはわからない。ではそれをカバーするために、サンプルのHTMLファイルを用意して…となると、これはまた先程のドキュメントが分割されることデメリットを招くことになる。

このような、スタイルガイドをつくる上で課題となる要素をカバーしてくれるのが、[StyleDocco](http://jacobrask.github.com/styledocco/)、[KSS](http://warpspire.com/kss/)や、といった、スタイルガイドジェネレータだ。これらを使うことで、先に紹介した実例ようなコンポーネントスタイルをデザインとして見せることも、コードサンプルを明示することもできる。

StyleDoccoはNode.jsで実装されており、KSSはRubyで実装されている。

KSSは、先程のスタイルガイドの実例であげたGithubの[Kyle Neath](http://warpspire.com/posts/kss/)氏が開発したものだ。KSSに関連した、彼のプレゼンテーションスライドも是非一度見てほしい。

[A better future with KSS // Speaker Deck](https://speakerdeck.com/kneath/a-better-future-with-kss)

## StyleDocco

とりあえず試してみるのなら、おそらくStyleDoccoの方が容易なので、StyleDoccoを使った例で紹介する。今回はStyledoccoのインストールの詳細などは省くので、[StyleDocco](http://jacobrask.github.com/styledocco/)の__Installation__の節を参照してほしい。省くといっても、__node.js__および__npm__がインストールされている前提であれば、`npm install -fg styledocco`と、ターミナルなどの黒い画面で叩くだけだが。

### 成果物

結論的に、__何をすればどうなるのか__、というのを先に出すと、次のようなコードを書いたCSSファイルに対して、StyleDoccoのコマンドを実行すれば[こういう形](/images/posts/styledocco-sample.png)のものができる。

もちろんこのCSSというのは、ドキュメント用のCSSファイルといったものではなく、実際のページを構成するCSSファイルを指す。

{% highlight css %}
/*
# アイコン
アイコン用モジュール。

`ico`をベースとし、サイズ用のclass、アイコン画像のclassで拡張する。

```
<div class="the-footer">
  <div class="center">
    <i class="ico ico-24 ico-twitter"></i>
    <i class="ico ico-36 ico-twitter"></i>
  </div>
  <div class="center">
    <i class="ico ico-24 ico-github"></i>
    <i class="ico ico-36 ico-github"></i>
  </div>
</div>
```
*/
.ico {
	display: inline-block;
	-webkit-background-size: 100% 100%;
	background-size: 100% 100%;
}

.ico-24 {
	width: 24px;
	height: 24px;
}

.ico-36 {
	width: 36px;
	height: 36px;
}
.ico-twitter {
	background: url(../images/ico-twitter.png);
}
.ico-github {
	background: url(../images/ico-github.png);
}
{% endhighlight %}


### CSSファイルのコメントをHTML化する

StyleDoccoはCSSファイルに書かれたコメントを__Markdown__という形式で書くことにより、対応したHTMLへと変換する。

[Markdownの文法](http://blog.2310.net/archives/6)はたくさんあるが、ここではよく使われるものをピックアップする。例を次にあげる。

{% highlight css %}
/*
# 頭に`#`をつけると見出しになる

ここに説明文を書く。

```
<!-- コードブロックは、バックティックを3つつけて囲むと、<pre/>でマークアップされる -->
<div>
  ...
</div>
```
*/
{% endhighlight %}

ポイントをいくつか挙げる。

`#`であれば`<h1>`、
`##`であれば`<h2>`、となる。

`（バックティック）は '（シングルコーテーション）とは異なるので注意してほしい。またここに各コードはエスケープする必要はない。

## StyleDoccoを実行する

このような形式のコメントを書いたCSSファイル（仮に`style.css`とする）に対し、StyleDoccoを実行する。

一応どのように実行するのかというのを少し補足しておく。例えばコマンドラインツール上（シェル上）で、次のようなディレクトリにいるとする・

{% highlight python %}
$ cd /Users/myname/projects/mywebsite/
{% endhighlight %}

そしてこの__mywebsite__ディレクトリの下に、先ほどの__/css/style.css__が展開されているとする。

この状態で、下記のようなコマンドを実行する。
（コマンドのオプションにある`-n`は、プロジェクト名を書く。）

{% highlight python %}
$ styledocco -n "My Website" css/style.css
{% endhighlight %}

実行すると、__docs__というディレクトリと、その中にスタイルガイドのHTMLが生成されるので、それをブラウザで見れば、先のサンプルのようなページを確認することができる。

## CSSファイルだけでなく、CSSプリプロセッサのファイルでも可能

ここでようやくCSSプリプロセッサの登場。

CSSファイルをパースして、それらをHTML化するわけだが、CSSプリプロセッサのファイルを対象にしたときは、コンパイル前の内容でパースしてくれる。

つまり、

{% highlight css %}
/*
# アイコン
アイコン用モジュール。

`ico`をベースとし、サイズ用のclass、アイコン画像のclassで拡張する。

アイコン画像は`_icon.scss`に格納し、`@import`で読み込む。

`.ico`を適用した要素内のコンテンツは、Image Replacementで隠す。
Image Replacementは、`_utility.scss`にある`.ir`で拡張する。

```
<div class="the-footer">
	<div class="center">
		<i class="ico ico-24 ico-twitter"></i>
		<i class="ico ico-36 ico-twitter"></i>
	</div>
	<div class="center">
		<i class="ico ico-24 ico-github"></i>
		<i class="ico ico-36 ico-github"></i>
	</div>
</div>

```
*/
@import "icons";

.ico {
	display: inline-block;
	-webkit-background-size: 100% 100%;
	background-size: 100% 100%;
	@extend .ir;
}

.ico-24 {
	width: 24px;
	height: 24px;
}

.ico-36 {
	width: 36px;
	height: 36px;
}

{% endhighlight %}

例えばこのように、SCSSな構文を交えることはもちろんのこと、Sassにおける`@import`を前提とした場合でも、コード上部のデザインサンプルでは、__コンパイル後のスタイル__が適用されたサンプルにしてくれる。

こちらも参考までにスクリーンショットでお見せすると、[こういう形](/images/posts/styledocco-sample-scss.png)。

ここで、冒頭にあげた、[CSS PreprocessorとIAの親和性](http://www.hitoyam.com/web/2012/12/04_1752.html)の記事の話に戻るが、これを使えばSassなりLESSなり、またはStylusといったCSSプリプロセッサをそのまま活用して、コンポーネントリスト = スタイルガイドをつくることができる。

## CSS/CSSプリプロセッサをもっと楽しく

簡易的かつ短い解説であったので、これでもいまいちぱっとしないかもしれないが、StyleDoccoのようなツールを使うことで、CSSとそのコメントを書くのが楽しくなる。

ちょっと難しいとおもわれるかもしれないが、是非一度試してほしい。

また別の機会に、本ブログのスタイルガイドを公開できればとおもう。

## アドベントカレンダーは続く

次は[ahomuの人](http://havelog.ayumusato.com/)です。

