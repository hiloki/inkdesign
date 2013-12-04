---
layout: 'note'
title: Web Components/Polymerを軽く触ってみる
description: Web Componentsで簡単なコンポーネントをつくってみる。本記事は Frontrend Advent Calendar 2013 の記事です。
date: 2013-12-04
tags: html,css,event
type: notes
relativeOutDirPath: 'notes'
ignored: true
---

Web ComponentsはWebのUIのコンポーネント化を実現するための各種仕様の総称です。

DOMとスタイルをカプセル化する**Shadow DOM**、任意の要素または既存の要素を拡張する**Custom Elements**、それらをパッケージ化し再利用できるようにするための**HTML Imports**を含みます。

マークアップをテンプレート化する**HTML Templates**も含まれていたのですが、つい最近HTML仕様に組み込まれたようです。

ちなみにWeb Componentsについて調べていると、Decoratorsという仕様にふれていることもありますが、これのことは忘れていいいようです。

Web Componentsの仕様・仕組みについては、先日おこなわれたHTML5 Conferenceで、Shadow DOMのSpec Editorである夷藤さんのお話が実にわかりやすいとはおもうので、そちらを参照するのをおすすめします。

[夷藤さんのスライド](http://hayatoito.github.io/webcomponents-slides/#1)と[講演動画](http://www.youtube.com/watch?v=wvggCAG5ttw&feature=share)

今回はどういうのをつくれるのかということで、簡単なものをつくります。

と、ここで紹介するのが[Polymer](http://www.polymer-project.org/)です。こちらも先ほどの資料後半でも解説されているのですが、Web Components、周辺仕様のポリフィル（ブラウザが未対応な仕様の補完）をしてくれるライブラリともいえますし、コンポーネント集だったりします。今回はPolymer.jsを使い、新しいコンポーネントを容易につくる例を紹介します。

そしてさらに楽をするために、[YeomanのPolymerジェネレータのタスク](http://www.html5rocks.com/en/tutorials/webcomponents/yeoman/?redirect_from_locale=ja)を利用します。

## コンポーネントをつくる

先ほどの記事を参考に、Yeomanなどをインストールした上で次のコマンドを実行します。

``` bash
$ mkdir new-project
$ cd new-project
$ yo polymer
```

するとGruntなどを含めたプロジェクトが生成されます。ここで下記の`server`タスクを叩くとサーバーが起動するので、**localhost:9000**をみれば**app**ディレクトリ以下のファイルが展開されたページを見ることができます。今回作成するコンポーネントはこのページで展開します。

続いて本題のコンポーネントの作成に入ります。今回は実に地味ではあるものの簡単な例ということで、[Mediaオブジェクト](http://www.stubbornella.org/content/2010/06/25/the-media-object-saves-hundreds-of-lines-of-code/)を`<media-element>`という要素にしてみます。

先ほどのプロジェクトディレクトリで、下記のコマンドを実行します。

``` bash
$ yo polymer:element media
```

> 1. コンストラクタを含めるか?
> 2. index.htmlに(作成するコンポーネントを)インポートするか？
> 3. （作成するコンポーネントに）他のコンポーネントをインポートするか？

というのを聞かれるますが、今回は2番目のindex.htmlへのインポートだけをYesとして実行します。

すると、appディレクトリの下に**elements/media.html**というのが生成されます。この中身が今回作成する要素の中身であり、Template + Shadow DOM です。

```
<polymer-element name="media-element"  attributes="">
  <template>
    <style>
      @host { :scope {display: block;} }
    </style>
    <span>I'm <b>media-element</b>. This is my Shadow DOM.</span>
  </template>
  <script>
    Polymer('media-element', {
      //applyAuthorStyles: true,
      //resetStyleInheritance: true,
      created: function() { },
      enteredView: function() { },
      leftView: function() { },
      attributeChanged: function(attrName, oldVal, newVal) { }
    });
  </script>
</polymer-element>
```

`name="media-element"`と、name属性で定義した値が実際に使用するときのタグになります。

```
<media-element>...</media-element>
```

`-element`は今回のジェネレータのテンプレート上そうなっているだけで、`x-media`といった名前でも構いません。

またこのmedia.htmlは、先ほどの回答によりindex.htmlにインポートされています。このようにして作成したコンポーネントはポータブルに使うことができます。

``` html
<head>
<!-- Place your HTML imports here -->
<link rel="import" href="elements/media.html">
</head>
```







## 所感

※本記事は[Frontrend Advent Calendar 2013](http://www.adventar.org/calendars/62)5日目の記事です。
次は[Ginpeiさん](http://ginpen.com/)です。