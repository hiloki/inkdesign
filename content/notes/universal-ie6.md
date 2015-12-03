---
date: 2015-12-02T00:15:25+09:00
title: Universal IE6 CSS
description: この記事は、CSS昔話 Advent Calendar 2015の2日目の記事です。
ogimage: 'images/notes/universal-ie6/ogimage.png'
---

> 昔々あるところに、  
> **Universal Internet Explorer 6 CSS**というのがおったそうな。

...Universal IE6 CSSについては知らないひとも多いかもしれない。

CSSを学び、少しテクニカルなことをしはじめたころに憧れていた人物にAndy Clarkeという人がいる。
彼は[Stuff and Nonsense](https://stuffandnonsense.co.uk/)というデザインコンサルティング会社に勤めており、イギリス人らしくモッズなスタイルのWebデザイナーだ。実務では政府の仕事をやっていたり、それ以外の活動としては、Web標準、HTML5、CSS3の黎明期にモダンなCSSデザインアプローチの書籍を出版・講演活動と広げてきた人物だ。

2008年くらいに「クロスブラウザ対応」という言葉が流行り、あわせてProgressive Enhancement/Graceful Degradationというようなアプローチが浸透し始めたその少し前に、ひとつのパフォーマンスとしてAndyのStuff and Nonsenseではある仕掛けをもっていた。それはIE6とそれ以降のブラウザでの見せ方を変えるというものだ。
以下は[Spotted the difference?](https://stuffandnonsense.co.uk/blog/about/hello)より引用。

<div class="u-flex-around">
  <div>
    {{% img src="/images/notes/universal-ie6/01.jpg" alt="for IE6" caption="IE6の場合" %}}
  </div>
  <div>
    {{% img src="/images/notes/universal-ie6/02.jpg" alt="for modern browser" caption="それ以降のブラウザの場合" %}}
  </div>
</div>

このカラクリはシンプルなもので、コンディショナルコメントでCSSを分けているだけ。今思えば単純なことだが、IE6ブラウザおよびそのユーザーに、モノクロトーンに変わったイメージと"Hey Old Timer!"というメッセージを送るそのロックさみたいなものに憧れたものだ。

[すべてのブラウザで全く同じ見た目であるべきか](http://dowebsitesneedtolookexactlythesameineverybrowser.com/)ということに疑問を投げかけ続け、あるときに彼が考えたアイデアこそが表題の[Universal Internet Explorer 6 CSS](https://stuffandnonsense.co.uk/blog/about/universal_internet_explorer_6_CSS/)だ。

コンテンツが重要であり、見た目がブラウザごとで全く同じである必要はない。またIE6で同じ見た目にするためにJSのライブラリを使うこと、時間とお金をかけることはエンドユーザー、クライアント双方にとっても好ましいことでもなく、それを削れるならより良いことだ、という考え。

<button onclick="ie6css()">ここクリックすれば、IE6 CSSに衣替えする。</button>

衣替えしたなら、これがUniversal IE6 CSSが適用されている状態。
IE6には、きれいにデザインされた凝った表現ではなく、最低限のタイポグラフィを考えた程度のスタイルにする。  
どのサイトだろうと、IE6にはこのスタイルを適用するというだけ、というもの。[コードはこちらか確認できる](/styles/ie6.1.1.css)。
前述に書いたように、IE6をつかっているような環境に対して、より負荷をかけてしまっては意味がないので、このアプローチは大胆ではあるが、理にかなったものともいえる。

まぁ実際にはこれが流行ることも、定着することもなかった、と思う。Andy自身も実際にどのくらいのクライアントに提案し、実施したのか気になるところ。もしかしたらIE6で世の中のWebサイトを回れば、しれっとUniversal IE6 CSSを使ったサイトがあるかもしれない。
今なら、Normalize CSSに少し手を加えたようなものになるだろうか。ちょっとつくろうかとおもったけどやめた。

今もレガシーブラウザなブラウザに引きづられる環境、そして同じ見た目を再現しなければいけない環境はゼロではないが、
当時よりは気を使う必要はなくなっているはずだ。しかし一方では見た目どうこうというより、近年のブラウザやデバイスであっても、妙なバグに踊らされる日々だ。そう、もしかしたらuniversal Android CSS...という話はない。

[Universal Internet Explorer 6 CSS - Google Code](https://code.google.com/p/universal-ie6-css/)

この記事は、[CSS昔話 Advent Calendar 2015](http://www.adventar.org/calendars/723)の2日目の記事です。

<script>
var cssfile = document.querySelector("link[href*='/styles/style.css']");
var defaultCss = cssfile.href;
function ie6css() {
  if(cssfile.href == defaultCss) {
    cssfile.href = "/styles/ie6.1.1.css";
  } else {
    cssfile.href = defaultCss;
  }
}
</script>
