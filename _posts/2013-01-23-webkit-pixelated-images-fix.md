---
layout: post
title: Mobile Safariでビットマップ画像をrotateするとが荒れるのを回避する
description: ビットマップ画像をtransformでrotateするとジャギーが出てしまう問題を回避するテクニックの紹介。
categories:
  - notes
---
WebkitもといMobile Safariで、ビットマップ画像を`transform: rotate(deg)`したときにフチがジャギー出てしまう現象についてのお話。とりあえず、iPhone+iOS前提で説明していく。

![ジャギーが出ている例](/images/posts/webkit-pixelated-images-fix/01.png)
{: .shadow}

`transform: rotate(10deg)`みたいな半端な角度で`rotate`させたときに確認できる。
`transform: rotate(45deg)`単位の場合にはこのようなジャギーはほぼ無い。ちなみにWebkitとタイトルにあげたが、新しめのデスクトップのGoogleChromeやSafariでは、中途半端な角度でもジャギーは見られない。古いものだとジャギーが出るはず。正確なバージョンで確認できていないが、それも今回の方法で解決するかもしれないし..しないかもしれない。

デスクトップの話はさておき、Mobile Safariとしての話に戻る。

結論を先にいってしまうと、__`rotate(deg)`している要素に'-webkit-backface-visibility: hidden'を使う、__というもの。
しかしこれを色々と試しているうちに、例外的なことも確認できたので、あわせて後述する。

## backface-visibility

そもそも`backface-visibility`というプロパティって何？っていう人も多いかもしれないので補足。

これはTransform 3Dな処理をするときに使うプロパティで、わかりやすい例が`rotateY(deg)`と組分せたもの。

対象の要素の裏側が見える角度、つまり縦を軸に90度を超えた角度に至ったときの見え方を制御できる（`visible`/`hidden`）。簡単な[カードフリップなアニメーションをつくった](http://codepen.io/hiloki/full/ABlDk)ので、その違いはこちらで確認してみてほしい。

`backface-visibility:visible`だと控えている裏面に当たる要素が反転して表示されてしまっている。一方の`backface-visibility:hidden`にしている方は初期状態では裏面はみえず、マウスオーバーして登場するとき、90度を超えたときに要素本来の絵（表面）が見えるようになる。 
（この[サンプルのコードはCodePen上](http://codepen.io/hiloki/pen/ABlDk)で確認できる）

## backface-visibilityでジャギーを回避する

本題。 

今回[検証で使ったサンプルページ](http://codepen.io/hiloki/full/jEfLd)をiPhone（実機orシミュレータ）で見てもらえると確認できる。

左側が`backface-visibility`非適用で、右側が`backface-visibility:hidden`が適用されたもの。それぞれ4つずつサンプルがあるが、それぞれで結果が違う。ひとつずつ解説していく。

### 親ボックスをrotateし、中にimg要素がある場合

![div.rotate](/images/posts/webkit-pixelated-images-fix/02.png)

`img`に親を用意し、その親に対して`rotate(deg)`をかけた。そのままだと`img`にジャギーが出てしまうが、`rotate(deg)`している要素、この場合では親の`div`に対して`backface-visibility:hidden`をあてると、少し滑らかになっているのがわかるだろうか。残念ながらベクターデータのように滑らかにはならないが、元よりも全然マシに見えるはず。
よくみると、滑らかになっているというか、ジャギーが少しボケているような見た目になる。結果的にジャギーがきれいになった例だ。

### img要素をrotateする場合

![img.rotate](/images/posts/webkit-pixelated-images-fix/03.png)

このケースでは`img`本体に対して`rotate(deg)`をかけた。これももちろんジャギーが出てしまうのだが、残念なことにこの場合にはその`ig`に`backface-visibility:hidden`をあてても**ジャギーは消えない**ようだ。

### CSSで作ったボックスをrotateする場合

![div.cssbox.rotate](/images/posts/webkit-pixelated-images-fix/04.png)

今度は画像ではなく、CSSで作ったベタ塗りのボックスに対して`rotate(deg)`をあててみた。そして`backface-visibility:hidden`。

すると今度は**逆に`backface-visibility:hidden`をあてた方にジャギーが現れる**。

### CSSで作ったボックスをrotateしつつ、その中にimg要素をいれた場合

![div.cssbox.rotate > img](/images/posts/webkit-pixelated-images-fix/05.png)

ここまでの応用で、CSSで作ったボックスの中に`img`をいれて、そのCSSのボックスに対し`rotate(deg)`を適用してみた。

結果は、ここまでの結果にならって、**画像のジャギーはきれいになるが、CSSのボックスにジャギーが現れる**。

## なぜそうなるのか？

画像にジャギーが出てしまうのをどうにかする方法として`backface-visibility:hidden`がある、というのはわかったとしてなぜそうなるのか？

※以下は自分なりの理解としての話なので、もっと詳しい人がいれば補足してくれると嬉しいところ。（そもそも間違ってるところもあるかもしれないので）

`backface-visibility:hidden`は3D処理であり、GPUアクセラレータ（ハードウェアアクセラレータ）へのスイッチになる。で、今回の本題に関していうと、GPUアクセラレータが有効になったからジャギーがマシになったということかというと、それは違うらしい。

ジャギーがマシになった、もといスムースになる、というところについてはピクセルレンダリングの話が必要となる。文字などの複雑なものをスムースに表示するためにブラウザはサブピクセル）なアンチエイリアスでレンダリングする。一方、サブピクセルではないアンチエイリアスがあり、Webkitは両者を状況によって切り替えるらしい。 
その状況というのが3Dレンダリング/GPUアクセラレータが有効となった時であり、今回の各サンプルでいうと、右側がサブピクセルではないアンチエイリアスとなっている、ということになる（とおもわれる）。

で、結局こうした仕様を踏まえて、今回のようなことになるのかというと、**たまたま**スムースになったように見える、というのがこうしたあたりの情報を持ってる同僚の見解。
一方で、CSSのボックスの場合だと逆にスムースでなくなったというのは、サブピクセルアンチエイリアスが、アンチエリアスに変わってしまったことが素直に反映されているからかもしれない。

## 最後に注意すべきこと

今回こうした方法があるという紹介をさせてもらったわけだが、GPUアクセラレータを無駄に実行させてしまうというバッドプラクティスでもある。

GPUアクセラレータはバッテリーの消費にも影響するし、メモリも消費する。対象がモバイル端末のように非力な端末であればなおのこと十分に気をつけたい。

## その他参考ページ

CSS Transformsのついてはこちらがわかりやすいです。
[http://unformedbuilding.com/articles/learn-about-css-transforms/](http://unformedbuilding.com/articles/learn-about-css-transforms/)

今回の解決方法はStackOverflowにて発見。
[http://stackoverflow.com/questions/5078186/webkit-transform-rotate-pixelated-images-in-chrome](http://stackoverflow.com/questions/5078186/webkit-transform-rotate-pixelated-images-in-chrome)

ハードウェアアクセラレータの実装に関する詳細。長文かつ難しい内容だけど興味があれば。
[http://www.chromium.org/developers/design-documents/gpu-accelerated-compositing-in-chrome](http://www.chromium.org/developers/design-documents/gpu-accelerated-compositing-in-chrome)