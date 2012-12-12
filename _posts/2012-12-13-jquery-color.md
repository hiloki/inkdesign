---
layout: post
title: jQuery Color Pluginを触ってみる
description: 色に関するアニメーションなどを扱うプラグインを軽めに紹介。
categories:
  - notes
---
※この記事は、[軽めのjQuery Advent Calendar 2012](http://www.adventar.org/calendars/29)の13日目の記事です。

jQuery Color というjQueryプラグインが、公式ブログで[先月末にアップデートがアナウンス](http://blog.jquery.com/2012/11/23/jquery-color-2-1-1-released/)されていた。

jQuery Colorというと、デフォルトのanimateメソッドでは対応していない、`color`や`backgroundColor`などのプロパティおよびその値もアニメーションさせるプラグイン。

今となってはCSS3のTransitions/Animationsで色を扱ったアニメーションなんかはできちゃうわけですが、地味にアップデート、バグフィックスされているということでニーズはきっとあるのでしょう。

## 触ってみる

手っ取り早く、CDNからjQuery本体と、プラグインファイルを取ってきましょう。

{% highlight html %}
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://code.jquery.com/color/jquery.color-2.1.1.js"></script>
{% endhighlight %}

そしてそのまま[README](https://github.com/jquery/jquery-color/blob/master/README.md)にあるサンプルを見ながらの軽い解説。[サンプルをCodepenにアップ](http://codepen.io/hiloki/full/CEJeo)したので、こちらで確認できます。

これが結局どういうことをやっているかというと、簡潔にいえば、animateメソッドで変化させる値は__数値__でなければいけないので、`#FF0000`みたいなHEX値を、`rgb(255,0,0)`のようなRGB値にすることでアニメーションできるようにしている様子。

その他色々メソッドがある。例えばHSLAの値返したりとか。
（CSSのHSLのことは、[CSSでの色指定について。半透明とかキーワードとか、ご存知でした？ | Ginpen.com](http://ginpen.com/2012/12/01/colors/)など参照。）

{% highlight html %}
var hsla = $.Color($("#block"),"backgroundColor").hsla();
console.log(hsla);
// [74, 0.6425120772946858, 0.5941176470588235, 1] 
var hue = $.Color($("#block"),"backgroundColor").hue();
console.log(hue);
// 74 
{% endhighlight %}

## もうちょっと面白そうなサンプル

こちらもサンプルが拝借します。。

[Sam Dunn氏の記事](http://buildinternet.com/2009/09/its-a-rainbow-color-changing-text-and-backgrounds/)より、Spectrumな表現をするサンプルです。こちらも[サンプルはCodepen](http://codepen.io/hiloki/full/Aqfuc)で。

{% highlight javascript %}
$(function() {  
  
  spectrum();  

  function spectrum(){  
    var hue = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';  
    $('#spectrum').animate( { backgroundColor: hue }, 1000);  
    spectrum();  
  }  
  
});  
{% endhighlight %}

単純にランダムでRGB値を回しているというだけですが、こういうもできるよ、ってことで。

## アドベントカレンダーは続く

次は[toshimaru](http://www.adventar.org/users/546)さんですね、よろしくおねがいします。

