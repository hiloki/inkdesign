---
layout: post
title: Sublime Text2のプラグイン、Zen codingをEmmetに変える
description: Zen codingの次期バージョンであるEmmetへの切り替えをSublime Text2でおこなう場合の注意点など。
categories:
  - notes
---
[Zen Coding](http://code.google.com/p/zen-coding/)はHTML/CSSなどを簡易的な記法で展開・記述することでコーディング効率を上げるツール。Zen Codingについては、公式のGoogle codeのページか、[以前に書いた](http://designblog.ecstudio.jp/htmlcss/zen-coding-aptana.html)記事を参照してもらえればと思う。

がしかし、このZen Codingは[Emmet](http://docs.emmet.io/)という名前でバージョンアップされているので、実際にZen Codingをこれからはじめる！という人は、Zen Codingではなく、Emmetをお使いのエディタなどにインストール、セットアップする必要がある。

Zen Codingをほどほどに使っている自分も、使っている[Sublime text2](http://www.sublimetext.com/2)のプラグインとしてEmmetに移行することにした。

## Zen codingパッケージのDisable/Remove

Sublime text2のパッケージ（プラグイン）管理については、[他の方が書かれた記事](http://makoto-tanaka.com/html5-2/1517/)などを参考にしていただくとして、すでに使っている方向けに書く。

Emmetに差し替えるにあたり、必要なのが既存のZen Codingパッケージの無効化または削除。これをしないと衝突して挙動がおかしくなる。

Sublime text2では、__Preferences__または<kbd>⌘ + shift + P</kbd>で起動する__Command Palette__から、__Browser Packages..__でFinderで書くパッケージのファイルを参照することができる。
で、そこから削除したZen Codingのフォルダをみつけて削除すればOK...ではない。

ここで削除しても、次回起動時に削除したパッケージが復活してしまうので意味がない。なのでパッケージを削除するためには、__Package Control__で__Disable Package__、または__Remove Package__しないといけない。
Disableは無効化、Removeは削除。Zen Codingパッケージを再び復活させることもないだろう、ということで、今回はRemoveとする。

これらを実行するには、先程の__Command Palette__を起動し、__"Remove Package"__と打つのが早いとおもわれる。

__Command Palette__から実行すると、次にインストール済みのパッケージリストが出てくるので、その中からZen Codingを探す。ここでも__"Zen"__とか打てば絞り込まれるので、見つけたら選んで実行する。
この時には特に削除前の確認画面などは出ないので注意してほしい。

ちなみにSublime Text2を使っていると、調子に乗って色々とパッケージをインストールしてしまい、何が入っているんだか分からなくなる。何がはいってるか見たいときには、__Command Palette__から__"List Package"__と打てば、パッケージの一覧が出てくる。Command Paletteは万能で非常に便利。

## Emmetパッケージをインストールした後の設定

では早速、と使おうとすると、日本語の文字が入力できない問題が発生。正確には入力しても消えてしまう、というバグが起きる。

これについては、[ちょっとよさげなSublime Text 2の設定](http://protean.cc/sublime-text-2-user-preferences)にある、Emmet向けの設定をおこなう必要がある。

こちらに書かれていることだが、Preferenceまたは<kbd>Cmd＋,</kbd>で立ち上がる、Setting -User に下記を記述すればいい。

{% highlight json %}
{
/* for Emmet User */

 "disable_formatted_linebreak": true,
 // （必須）Emmetを有効にすると、日本語変換確定後に文字が消えるのを防ぐ

 "disabled_single_snippet_for_scopes": "",
 // （任意）Emmetを有効にすると、HTMLで「php」の展開が「<?php ?>」にならない問題の回避

 "enable_emmet_keymap": true,
 // （任意）英語キーボード以外でEmmetを使う場合は「false」	にするとかしないとか
}
{% endhighlight %}

これでSublime Text2でEmmetが使える。


## その他参考サイト
- [Zen-Codingの次期バージョン、Emmet について｜Web Design KOJIKA17](http://kojika17.com/2012/09/zen-coding-next-emmet.html)
- [第0回 Sublime Text 2 勉強会 で Emmet について話してきた - techlog](http://d.hatena.ne.jp/j7400157/20121111/1352603101)
- [ちょっとよさげなSublime Text 2の設定](http://protean.cc/sublime-text-2-user-preferences)
