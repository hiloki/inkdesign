---
layout: post
title: CSSでボックスを横並びにする方法色々
description: CSSでボックスを横並びにする方法はいくつかあるが、それぞれを検証してみる
categories:
  - notes
published: false
---
グリッドなレイアウトやタブメニュー、その他ボックスをCSSで横並びにレイアウトする方法はいくつかある。今回はスマートフォンブラウザを主なターゲットとして、それらを挙げてみる。

## float: left

横に並べるというと、'float'を使うというのが一番最初に浮かぶのではないかとおもう。	

~~~ css
li {
	float: left;
}
~~~

## display: inline-block

横に並べるというと、'float'を使うというのが一番最初に浮かぶのではないかとおもう。

## display: table