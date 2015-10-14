---
layout: 'notes'
title: Web ComponentsとPolymerを軽く触ってみる
description: Web Componentsで簡単なコンポーネントをつくってみる。本記事は Frontrend Advent Calendar 2013 の記事。
date: 2013-12-05
tags: html,css
---

Web ComponentsはWebのUIのコンポーネント化を実現するための各種仕様の総称だ。

DOMとスタイルをカプセル化する**Shadow DOM**、任意の要素または既存の要素を拡張する**Custom Elements**、それらをパッケージ化し再利用できるようにするための**HTML Imports**を含む。

マークアップをテンプレート化する**HTML Templates**も含まれていたが、つい最近HTML仕様に組み込まれたようだ。

ちなみにWeb Componentsについて調べていると、Decoratorsという仕様にふれていることもあるが、これのことは忘れて良いらしい。

Web Componentsの仕様・仕組みについては、先日おこなわれたHTML5 Conferenceで、Shadow DOMのSpec Editorである[夷藤さんのお話](http://www.youtube.com/watch?v=wvggCAG5ttw&feature=share)が実にわかりやすいとはおもうので、そちらを観るのをおすすめする。

<div class="entry__media">
<iframe width="560" height="315" src="//www.youtube.com/embed/wvggCAG5ttw" frameborder="0" allowfullscreen class="u-center embed"></iframe>
</div>

[夷藤さんのスライド](http://hayatoito.github.io/webcomponents-slides/#1)はこちら。

と、もうひとつ紹介するのが[Polymer](http://www.polymer-project.org/)だ。こちらも先ほどの資料後半でも解説されているのだが、Web Components、周辺仕様のポリフィル（ブラウザが未対応な仕様の補完）をしてくれるライブラリともいえるし、コンポーネント集でもある。

実際にこれらを使って作ったものは、以前おこなわれた[Frontrend x Chrome	 Tech Talk Night Extended](http://frontrend.github.io/blog/frontrend-x-chrome-tech-talk-night-extended/)でのLTのときに色々と[つくってみた](http://hiloki.github.io/demo/frontrend_chrome/app/)。

<div class="entry__media">
<iframe src="http://www.slideshare.net/slideshow/embed_code/27734708?rel=0" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px" allowfullscreen class="u-center embed"> </iframe>
</div>

この時にも触ってみたかっただけなので、いざつくってみると設計が難しく、今おもえばデタラメな設計なので、そのものをあまり参考はしない方がいいとおもう。これらは特に難しいことをしてつくったわけではなく、当日イベントにもきてたAddy Osmani氏の記事で紹介されている[YeomanのPolymerジェネレータのタスク](http://www.html5rocks.com/en/tutorials/webcomponents/yeoman/?redirect_from_locale=ja)を使えば非常に簡単。

```
$ npm install -g yo
$ npm install generator-polymer -g
$ mkdir my-new-project && cd $_
$ yo polymer
```

こういうのを叩いていくイメージ。（スライドにも書いてる。）

ちなみにGoogle Chromeを使っている場合は、最近のバージョンだと

**Settings > General > Elements > Show Shadow DOM**

を有効にすると、Inspectしたときに隠れているDOMをみることができる。先ほどの僕のつくったサンプルも、普通にHTMLのソースをみたときと、DevToolでInspectしたときと見比べるといいかもしれない。

ブラウザのネイティブで実装されているvideo要素などをInspectしてみてほしい。それらにも隠れているDOMをみることができるはず。

Web Componentsに触れて良いとおもうのはまさにこういうところで、コントローラーUI付きでビデオを埋め込みたいときに、UIを頑張って作る、または深く構造を知る必要なく、`<video>`と`<source>`を組み合わせれば良いわけだ。

そしてShadow DOMによるカプセル化で、本当に独立したコンポーネントをつくられることが楽しい。

## カプセル化

もうひとつのサンプル、[iOS7のスイッチUI](http://hiloki.github.io/demo/frontrend_chrome/app/switch.html)を模したもの。

これは次のようなマークアップでつくることができる。

<div class="entry__media">
![](/images/try-web-components-and-polymer/01.png)
</div>

```
<x-switch></x-switch>
```

かなり手抜きでオン/オフの管理などは省いている。そもそもこの見た目をつくるだけなら、わざわざコンポーネント化することなく、ただ`class`をあてれば良いだけのものなのだが、注目してほしいのはそこではない。

このコンポーネントの中身を除くと下記のようになっている。

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

これはPolymerを通してつくった`x-switch`コンポーネント。注目してほしいのは、`<style>`に記述されたルールだ。

このコンポーネントでは`input[type=checkbox]`といったセレクタで、通常であればブラウザデフォルトのチェックボックスすべてに影響してしまう。

だが、サンプルを確認してもらうとわかる通り、このiOS7ライクなチェックボックスの前後にはブラウザデフォルトの見た目のままのチェックボックスが確認できるはず。

<div class="entry__media">
  ![](/images/try-web-components-and-polymer/02.png)
</div>

つまりコンポーネント内で定義したスタイルは外に汚染することはない。素晴らしい。

今のCSSではこうした汚染というのは容易に起こる。ゆえに強固なセレクタを用いたり、または命名を工夫して衝突・汚染することがないようにするなど、100%安全とはいえない方法で回避せざるをえない。  
(それがCSSの良さともいえるかもしれないけど)

実際にWeb Componentsを実際の中・大規模な仕事の中で扱う、運用する経験はまだ無いので、見えていない問題は色々あるかもしれない。メンテナンス性であるとか、無秩序にチームの開発者がコンポーネントを作成・編集すれば混沌としてしまうだろう。  
下手をすると、現状のHTML/CSSにおける同等の問題以上に問題となるかもしれない。

と、ネガティブに考える以上に、Web Componentsには面白みがあるとおもっている。今回紹介したリソースを参照して、是非試してみてほしい。

## というわけで

本記事は[Frontrend Advent Calendar 2013](http://www.adventar.org/calendars/62)の5日目の記事として書いた。  
次は[Ginpeiさん](http://ginpen.com/)です。