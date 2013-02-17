---
layout: post
category: notes
title: spacer.gifとそのDataURI化したやつのリポジトリを作った
description: spacer.gif画像とDataURI化したテキストデータを格納するリポジトリをGithubにつくった。
date: 2013-02-17 21:57:09
---
1px × 1pxの透明な**spacer.gif**といえば、大昔はレイアウトにおいて支え棒のような役割で使っていたのを思い出す。今やそうしたレイアウト、その余白はCSSでやればいいわけだが、spacer.gifはそういう用途でないところで地味に使う。

## spacer.gifの使いどころ

一例として、今関わっている画像を扱うサービスを例に説明する。画像を並べるページがあるのだが、一定条件で画像を空になる場合がある。この空の状態をつくるために、`src`属性を空にする必要がある。が、この対応は好ましくない。

その理由は、[Nicholas C. Zakas氏の記事で解説されている](http://www.nczonline.net/blog/2010/03/16/empty-string-urls-in-html-a-followup/)が、少し古いブラウザでは空の`src`属性があった場合にHTTPリクエストが発生してしまうからだ。

またWebkitでは属性値が空か、src属性そのものが無い場合に、クラッシュしてしまうというようなバグもあった気がする。元のソースが無いのでこれについては自信はない。

## spacer.gifをいちいち用意するのは面倒

絶対使うというものでもないので、たまに必要になったときに用意するのが地味に面倒くさい。ということで思いついたのはGithubにホスティングする方法。これはこれで大げさだけども便利だとおもう。

[hiloki/spacer](https://github.com/hiloki/spacer)

## 画像ファイルでなく、埋め込めるように

1px四方のたった43kbの画像とはいえ、ひとつのリクエスト。ということでbase64でエンコードして埋め込むのが良い好ましいとおもわれる。なのでこれもGithubの方に用意している。

[https://raw.github.com/hiloki/spacer/master/spacer.gif.txt](https://raw.github.com/hiloki/spacer/master/spacer.gif.txt)

ちなみにPNG版のも置いてあるが、容量も大きくなるし、あまり用途は無いとおもう。

わざわざGithubに置いておいてなんだが、別に都度そちらを参照しなくとも、使っているエディタなりスニペットツールにこの文字列を登録しておけばいつでも呼び出せる。

ちなみに僕はSubelime Text2の[Nettuts+ Fetch](http://net.tutsplus.com/articles/news/introducing-nettuts-fetch/)パッケージの`files`として `https://raw.github.com/hiloki/spacer/master/spacer.gif.txt` を登録し呼び出せるようにしている。

## 世界一小さい画像

これは余談だが、この1px四方・43kbの透過gifが一番小さい画像かとおもいきや、実はもっと小さなサイズの画像がある。

[The Tiniest GIF Ever](http://probablyprogramming.com/2009/03/15/the-tiniest-gif-ever)という記事で細かく解説されているので興味があれば読んでほしい。なぜspacer.gifが43kbなのかという解説もある。

そしてその世界で一番小さな画像が下記だ。これはあくまで小さな画像という話なので、透過ではなく**黒色**の画像だ。

`data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=`

これはこれで[検索してみるとわかるが](https://www.google.co.jp/#hl=ja&gs_rn=3&gs_ri=psy-ab&tok=TDUs29KgGnYshCdbNfILiw&cp=58&gs_id=4z&xhr=t&q=data%3Aimage%2Fgif%3Bbase64%2CR0lGODlhAQABAAD%2FACwAAAAAAQABAAACADs%3D&)いろんな用途で使われているよう。透過であるかどうかが問わず、`src`属性へのダミーとして使うなら、こっちでも良いだろう。