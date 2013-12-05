---
layout: 'note'
title: Web Components/Polymerを軽く触ってみる
description: Web Componentsで簡単なコンポーネントをつくってみる。本記事は Frontrend Advent Calendar 2013 の記事です。
date: 2013-12-05
tags: html&css
type: notes
---

Web ComponentsはWebのUIのコンポーネント化を実現するための各種仕様の総称です。

DOMとスタイルをカプセル化する**Shadow DOM**、任意の要素または既存の要素を拡張する**Custom Elements**、それらをパッケージ化し再利用できるようにするための**HTML Imports**を含みます。

マークアップをテンプレート化する**HTML Templates**も含まれていたのですが、つい最近HTML仕様に組み込まれたようです。

ちなみにWeb Componentsについて調べていると、Decoratorsという仕様にふれていることもありますが、これのことは忘れていいいようです。

Web Componentsの仕様・仕組みについては、先日おこなわれたHTML5 Conferenceで、Shadow DOMのSpec Editorである夷藤さんのお話が実にわかりやすいとはおもうので、そちらを観るのをおすすめします。

<iframe width="560" height="315" src="//www.youtube.com/embed/wvggCAG5ttw" frameborder="0" allowfullscreen class="u-center embed"></iframe>

[夷藤さんのスライド](http://hayatoito.github.io/webcomponents-slides/#1)はこちら。

と、もうひとつ紹介するのが[Polymer](http://www.polymer-project.org/)です。こちらも先ほどの資料後半でも解説されているのですが、Web Components、周辺仕様のポリフィル（ブラウザが未対応な仕様の補完）をしてくれるライブラリともいえますし、コンポーネント集だったりします。

実際にこれらを使って作ったものは、以前おこなわれた[Frontrend x Chrome	 Tech Talk Night Extended](http://frontrend.github.io/blog/frontrend-x-chrome-tech-talk-night-extended/)でのLTのときに色々と[つくってみました](http://hiloki.github.io/demo/frontrend_chrome/app/)。

<iframe src="http://www.slideshare.net/slideshow/embed_code/27734708?rel=0" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px" allowfullscreen class="u-center embed"> </iframe>

この時にも触ってみたかっただけなので、いざつくってみると設計が難しく、今おもえばデタラメな設計なので、そのものをあまり参考はしない方がいいです。これらは特に難しいことをしてつくったわけではなく、当日イベントにもきてたAddy Osmani氏の記事で紹介されている[YeomanのPolymerジェネレータのタスク](http://www.html5rocks.com/en/tutorials/webcomponents/yeoman/?redirect_from_locale=ja)を使えば非常に簡単です。

```
$ npm install -g yo
$ npm install generator-polymer -g
$ mkdir my-new-project && cd $_
$ yo polymer
```

こういうのを叩いていくイメージです。（スライドにも書いてます）

ちなみにGoogle Chromeを使っている場合は、最近のバージョンだと

**Settings > General > Elements > Show Shadow DOM**

を有効にすると、Inspectしたときに隠れているDOMをみることができます。先ほどの僕のつくったサンプルも、普通にHTMLのソースをみたときと、DevToolでInspectしたときと見比べるといいかもしれません。

ブラウザのネイティブで実装されているvideo要素などをInspectしてみてください。それらにも隠れているDOMをみることができるはずです。

Web Componentsに触れて良いとおもうのはまさにこういうところで、コントローラーUI付きでビデオを埋め込みたいときに、UIを頑張って作る、または深く構造を知る必要なく、`<video>`と`<source>`を組み合わせれば良いわけです。

そしてShadow DOMによるカプセル化で、本当に独立したコンポーネントをつくられることが楽しいです。

## カプセル化

もうひとつのサンプル、[iOS7のスイッチUI](http://hiloki.github.io/demo/frontrend_chrome/app/switch.html)を模したものです。

これは次のようなマークアップでつくることができます。

![](/images/try-web-components-and-polymer/01.png)

```
<x-switch></x-switch>
```

かなり手抜きでオン/オフの管理などは省いてます。そもそもこの見た目をつくるだけなら、わざわざコンポーネント化することなく、ただ`class`をあてれば良いだけのものなのですが、注目してほしいのはそこではありません。

このコンポーネントの中身を除くと下記のようになっています。

```
<polymer-element name="x-switch" attributes="">
<template>
<style>
@host { 
  :scope {
    display: inline-block;
  }
}
input[type=checkbox] {
  -webkit-appearance: none;
  box-shadow: inset 0px 0px 0px 1px #e6e6e6;
  border-radius: 15px;
  ...
}
input[type=checkbox]:checked {
  box-shadow: inset 0px 0px 0px 20px #53d76a;
}
input[type=checkbox]:after {
  content: '';
  position: absolute;
  width: 29px;
  height: 29px;
  ...
}
input[type="checkbox"]:checked:after {
  left: 22px;
}
</style>
<input type="checkbox" />
</template>
</polymer-element>
```

これはPolymerを通してつくった`x-switch`コンポーネントです。注目してほしいのは、`<style>`に記述されたルールです。

このコンポーネントでは`input[type=checkbox]`といったセレクタで、通常であればブラウザデフォルトのチェックボックスすべてに影響してしまいます。

ですが、サンプルを確認してもらうとわかる通り、このiOS7ライクなチェックボックスの前後にはブラウザデフォルトの見た目のままのチェックボックスが確認できるはずです。

![](/images/try-web-components-and-polymer/02.png)

つまりコンポーネント内で定義したスタイルは外に汚染することはありません。素晴らしいですね。

今のCSSではこうした汚染というのは容易に起こります。ゆえに強固なセレクタを用いたり、または命名を工夫して衝突・汚染することがないようにするなど、100%安全とはいえない方法で回避せざるをえません。  
(それがCSSの良さともいえるかもしれないけど)

実際にWeb Componentsを実際の中・大規模な仕事の中で扱う、運用する経験はまだ無いので、見えていない問題は色々あるかもしれません。メンテナンス性であるとか、無秩序にチームの開発者がコンポーネントを作成・編集すれば混沌としてしまうでしょう。  
下手をすると、現状のHTML/CSSにおける同等の問題以上に問題となるかもしれません。

と、ネガティブに考える以上に、Web Componentsには面白みがあるとおもっています。今回紹介したリソースを参照して、是非試してみてください。

## というわけで

本記事は[Frontrend Advent Calendar 2013](http://www.adventar.org/calendars/62)の5日目の記事でした。  
次は[Ginpeiさん](http://ginpen.com/)です。