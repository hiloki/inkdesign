---
layout: 'notes'
title: 'ひし型のサムネイルをCSSでつくる'
description: '24ways(2013)で使われているひし形のサムネイルをどう作っているのか調べてみた。'
date: 2014-01-05
---

毎年12月に著名なWeb（+α）界隈の方々で綴られるアドベントカレンダーメディア、[24 ways](http://24ways.org/)が2013年版でデザインが変わっていた。

その[記事ページ](http://24ways.org/authors/andyclarke/)になどに使われている著者のサムネイルがひし形になっているが、それはひし形に加工されている画像を使っているわけではないようだ。

調べてみればなんてことない方法だが、なるほど、ってことで解説してみる。結論を先にいえば、`transform`プロパティを使う、ということだ。

<div class="entry__media">
	![](/images/diamond-thumbnail/01.png)
</div>

```html
<div class="diamond">
  <img src="http://placecage.com/450/450" alt="Cage" />
</div>
```

HTMLの方はシンプル。`<img>`とそれを包括する要素を`transform`で変形させていく。  
とりあえずサンプルはみんな大好き[ニコラス・ケイジ](http://placecage.com/)で。

そしてCSSは下記のようにする。

```css
.diamond {
  overflow: hidden; /* 4. 内包するimgのはみ出る部分を隠す */
  margin: auto;
  width: 180px;
  height: 180px;
  transform: rotate(45deg); /* 1. 要素を傾ける */
}
.diamond img {
  margin: -25%; /* 5. 隙間を埋める */
  width: 150%; /* 3. 包括要素より大きくする */
  height: auto;
  transform: rotate(-45deg); /* 2. 要素を傾け直す */
}
```

ポイントは`margin: -25%;`だろうか。実際にやってみると形をつくること自体は簡単だが、上手くひし形に画像をはめるのは少し調整が必要。

[これを反映せたデモ](http://cdpn.io/DkrIl)もあるので、こちらで色々と値をいじってみるといいだろう。  
ひし形以外にも、八角形やダイアモンドのような形にしたりというのも可能だ。

`transform`を使っているので、実際に使うときには要素が他の要素とかぶらないように位置を微妙に調整するといったことは必要になるとはおもう。



