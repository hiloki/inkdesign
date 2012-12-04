---
layout: post
title: スマートフォン端末向けにtel:を仕込む小技
description: スマートフォン端末ではtel:スキーマを利用することで電話をかけることができるが、その実装を少し工夫してみる
categories:
  - notes
---

※この記事は、[軽めのjQuery Advent Calendar 2012](http://www.adventar.org/calendars/29)の５日目の記事です。

スマートフォン端末のブラウザでは、`tel:`スキーマを`<a href="tel:0120-0000-0000">お問い合わせはこちら</a>`というように利用することで、ブラウザ上でタップして電話をかけることができるようになる。

しかし、これをデスクトップブラウザで実装してしまうと、クリックした時に不明なプロトコルとしてエラーとなってしまう。

これが問題となる可能性があるのは、いわゆるレスポンシブ・ウェブデザイン的なアプローチで、モバイルブラウザとデスクトップブラウザでHTMLを一本化してしまうような場合だ。[^problem]

## カスタムデータ属性を使ったアプローチ

前提として下記のようなマークアップをおこなう。

{% highlight html %}
お問い合わせは<span data-tel="0120-9999-9999">お電話</span>で！

<img src="btn-contact.png" alt="お問い合わせはお電話で！" data-tel="0120-8888-8888">
{% endhighlight %}

ポイントは`data-tel`属性。この中にコール先の番号をセットしておく。あとはこの要素に対し、`data-tel`の値を`href`にセットした`<a />`で包括する。で、これをjQueryっぽく書いてみる。

{% highlight javascript %}
// とりあえず簡易的な方法でdetection（iPhoneの場合）
var ua =navigator.userAgent;
if(ua.indexOf('iPhone') > -1) {
  
  $(function() {
    // data-tel属性を持つ要素に対し、
    $("[data-tel]").each(function(){
      // data-tel属性の値を取得
      var tel = $(this).attr("data-tel");
      // a要素でwrapする
      $(this).wrap("<a href=" + 'tel:' + tel + "></a>");
    });
  });

};
{% endhighlight %}

こんな感じ。

## data()メソッドは？

せっかくカスタムデータ属性をつかっているので、よりjQueryっぽくという意味では`data()`メソッドを使う方法もある。

{% highlight javascript %}
$(function() {
  $("[data-tel]").each(function(){
    // data()メソッドでtel属性の値を取得
    var tel = $(this).data("tel");

    $(this).wrap("<a href=" + 'tel:' + tel + "></a>");
  });
});
{% endhighlight %}

が、これには[罠がある](http://havelog.ayumusato.com/develop/javascript/e291-jquery_data_method.html)。

つまり`data()`メソッドを使うと、__0からはじまる文字列が数字として扱われる__ので、今回のような例だと危うい。

{% highlight html %}
// stringで、そのまま 0120-9999-9999 になる
<span data-tel="0120-9999-9999">お電話</span>

// numberになるので、12099999999 になる
<span data-tel="012099999999">お電話</span>
{% endhighlight %}

ただこれが起きるのはjQuery1.8以前で、[1.8からはdata()メソッドをつかっても型は変換されない。](http://bugs.jquery.com/ticket/7579)
実際に[こちらのデモ](http://jsfiddle.net/dmethvin/8SsWK/
)上で、左のパネルからjQueryのバージョンを変えてRunしてみるとわかる。

その他、[カスタムデータ属性の参照の仕方](http://1000ch.net/2012/12/02/ImportantPointForJavaScriptDevelopment/)などについては、こちらも参照するといいかも。

## もうちょい考えてみると

Detectionが正直微妙で、本来ならば__tel:が有効な端末で__っていうのが正しいので、単純にUAとかでみるのは微妙。例として挙げておいてなんだが、これだとたぶん__iPod touch__も含まれる。

またこのコードではスマートフォンブラウザのときに実行される前提になってるが、非力なスマートフォンブラウザ環境よりも、むしろデスクトップブラウザで実行されるようなスクリプトの方がいいだろう。

それならば例えば、

{% highlight html %}
<a href="tel:0120-9999-9999">お電話</a>
{% endhighlight %}

これを標準とし、デスクトップブラウザのときに下記のようなコードを実行する。

{% highlight javascript %}
$(function() {
  // href属性がtelから始まる要素の
  $("a[href^=tel]").each(function(){
    // 中身を抜いてspanに差し替える
    $(this).replaceWith("<span>" + $(this).text() + "</span>");
  });
});
{% endhighlight %}

これも雑な感じではあるが、このようにすれば`<a>`を`<span>`に変えることで、リンクを無効化できる。

ちなみに一応知らない人がいたら、ということで補足すると、`$("a[href^=tel]")`は属性セレクタで、__href属性がtelからはじまるa要素__、というセレクタ。この例では`tel:`から始まるものというはブレないので、このようにしてみた。[^attr]

タグは差し替えず、`event.preventDefault`でリンクを無効化しても良いかもしれないが、この場合にはCSSもマウスポインタがリンク時のポインタにならないようにしておきたい。

## アドベントカレンダーは続く

次は[ハムの人](http://h2ham.seesaa.net/)ですね、よろしくおねがいします。

[^problem]: 問題とはいってもデスクトップユーザーが電話番号を見て、クリックして電話をかける、というアクションをするかどうかというのは置いといて。

[^attr]: この属性セレクタの話は、同アドベントカレンダーの別記事として後日書く予定。