---
layout: post
title: 最近のLESSの小話と新機能紹介（一部）
description: inkdesign.jpはLESSを応援しています。
categories:
  - notes
---

※この記事は、[CSS Preprocessor Advent Calendar 2012](http://www.adventar.org/calendars/1)の7日目の記事の__おまけ__です。

CSSプリプロセッサ（CSSメタ言語）は、[Sass](http://sass-lang.com/)が人気かつ、アップデートも頻繁、新機能増えてる！みたいな空気を感じたりするんですが、[LESS](http://lesscss.org/)もがんばってます。

## LESSの停滞

5ヶ月ほど前に[Crunch](http://crunchapp.net/)というLESS対応エディタを開発しているMatthew Dean氏が、

> LESSの開発止まってますやん。それに比べてSassはめっちゃ更新してんで。
>
> [Is LESS in need of support?](https://github.com/cloudhead/less.js/issues/867)

というissueをあげた。

それに対し、開発者のAlexis Sellier氏（[cloudhead](http://cloudhead.io/）が同issueにて、[このように](https://github.com/cloudhead/less.js/issues/867)コメントをあげた。

> 他にやることあるから、今LESSに割く時間ありませんわー（略）
>
> [https://github.com/cloudhead/less.js/issues/867#issuecomment-7036574](https://github.com/cloudhead/less.js/issues/867#issuecomment-7036574)

なんていうこともあったものの、[agatronic](https://github.com/agatronic)氏を中心に、LESSを愛する有志たちによって、現在ぼちぼちとメンテされている様子。

## 最近のLESS

最近のLESSの話題の目玉としては、[アドベントカレンダー初日に@hokacchaが書いてくれた](http://webtech-walker.com/archive/2012/12/less_extend.html)、LESSにおける@extendの機能でしょうか。

SassがLESSに大きく差をつけた機能のひとつではあるのですが、これをなんと我らが@hokacchaが書いてくれたわけです。そこにシビれる、あこがれる。

その進捗などは先の記事を見ていただくとして、他にアップデートされているものを少し紹介していく。

[CHANGELOG](https://github.com/cloudhead/less.js/blob/master/CHANGELOG.md)の1.3.1（2012-10-18 アップデート）から色々と追加された色関係のfunctionをピックアップ。
（強化するのはそこの機能じゃないんじゃ、という気もしないでもないですが）

## 色関係の関数が盛りだくさん。

追加されたのは下記。

- red
- green
- blue
- tint
- shade
- multiply
- screen
- overlay
- softlight
- hardlight
- difference
- exclusion
- average
- negation
- contrast

この中から後半部分の__Blending modes__と呼ばれるFunctionをいくつかピックアップする。Blending modesは、Photoshopでいうところの__レイヤーの描画モード__みたいなものだ。おそらくPhotoshopのUIの言語設定を変えれば、これらの単語が表示されるはず。今回紹介するものがそれらツールとまったく同じアルゴリズムかはわからないが、おそらくはこれらを元にしてつくられたFunctionではないかとおもう。

これらのFunctionは、第一引数と第二引数の色を掛け合わせるなどしてブレンドする。

### multiply

{% highlight css %}
div {
  background-color: multiply(@colorA,@colorB);
}
{% endhighlight %}

Photoshopでいうところの__乗算__。

### screen

{% highlight css %}
div {
  background-color: screen(@colorA,@colorB);
}
{% endhighlight %}

Photoshopでいうところの__スクリーン__。

### overlay

{% highlight css %}
div {
  background-color: overlay(@colorA,@colorB);
}
{% endhighlight %}

Photoshopでいうところの__オーバーレイ__。

### hardlight

{% highlight css %}
div {
  background-color: hardlight(@colorA,@colorB);
}
{% endhighlight %}

Photoshopでいうところの__ハードライト__。

### difference

{% highlight css %}
div {
  background-color: difference(@colorA,@colorB);
}
{% endhighlight %}

Photoshopでいうところの__差の絶対値__。

### average

{% highlight css %}
div {
  background-color: average(@colorA,@colorB);
}
{% endhighlight %}

Photoshopでは無いかもしれないが、Fireworksでいうところの__平均__。

### 一応サンプル

StyleDoccoでつくった[サンプルページ](/demo/less-new-colors/less.html)も用意しておく。[StyleDoccoについてはこちら](/notes/2012/12/07/css-preprocessor-styleguide.html)を参照してほしい。[^styledocco-less]

[^styledocco-less]: このように、LESSもそのままStyleDoccoに放り込める。

## 続きはCSS Nite LP26で！（たぶん）

2013年1月12日（土）に開催される、[CSS Nite LP, Disk 26「CSS Preprocessor Shootout」](http://lp26.cssnite.jp/)では__LESS__についての話をする予定なので、本記事で紹介しなかった関数も紹介するかもしれません。しないかもしれません。

残席残りわずかなようですが、興味がある方はぜひ。



