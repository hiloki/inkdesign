---
layout: 'note'
title: Mac OS XのターミナルからSublime Text2を立ち上げられるようにすると地味に便利
description: 黒い画面もといターミナルなどのコマンドラインツールを使う機会が増えてきたので、地味なTipsで少し便利にしてみよう。
date: 2012-11-29
tags: software
outDirPath: notes
---

## ターミナルからSublime Text2を起動する

 [OS X Command Line - Sublime Text 2 Documentation](http://www.sublimetext.com/docs/2/osx_command_line.html)

 ここ見れば分かるって話なんですが、なんのこっちゃ、っていう人もいるでしょうから、日本語で解説していくことにする。

 CSSプリプロセッサをコマンドラインツールで実行してたり、[Grunt](http://gruntjs.com/)を使い始めたー、GitもGUIは使ってませんー、という人で、なおかつSublime Text2を使っている人、という狭いんだか広いんだかわからない層向けになるのはご容赦ください。

## Sublime Text2でプロジェクトディレクトリをどう展開してますか？

多くの場合、さぁ作業するぞ、となると該当のプロジェクトの作業ディレクトリの中にあるファイルをいじくるわけですが、Sublime Text２ユーザーの人はどのようにはじめてますか？

### ディレクトリをサイドバーにガっと放り込む

新規に開いたウィンドウに、Finderからドラッグ&ドロップでガっと放り込めば、そのディレクトリがサイドバーに登録され、中のファイルをツリー上に展開することができる。全然それも良しでしょう。

### Sublime Text2のProjectとして管理する

ウィンドウにプロジェクトの作業ファイルが展開している状態で、Sublime Text2のメニューにある__Project__から、__Save Project As...__することで、その状態をプロジェクトという単位でSublime Text2が記録してくれるようになる。

プロジェクトファイルは、`.sublime-project`、`.sublime-workspace`という名前で保存する。これらはそのプロジェクトのルートとかに保存してもいいし、全然別のところに保存してもいい。例えば全然違うところに__SublimeProjects__みたいな名前のフォルダを作り、そこに保存しても構わない。

どこにそのファイルがあろうが、__Project__から__Switch Project in Window__、または<kbd>Command + Control + P</kbd>などをすれば、プロジェクトの切り替えダイアログが出る。そこから選べば、現在開いているウィンドウが、別のプロジェクトのディレクトリへと切り替わる。これもかなり便利。

## さて本題のターミナルからSublime Text2を起動する話

最近はGit[^Git]なり、Gruntなりを使うことが多いので、作業をはじめるときにはまずターミナル[^Terminal]を立ち上げる。すると、次のアクションはエディタを開くことだが、いちいちアプリケーションから開くなり、別のランチャーソフトで起動するというのも面倒なので、そのままターミナルからやってしまいたい。例えばこんな風に。

```bash
subl .
```

これで現在いるディレクトリをそのままプロジェクトとしてSublime Text2で開くことができるようになる。

地味に便利と思うんですが、どうでしょうか。
興味を持ったら次へ。

## sublへのシンボリックリンクを作る

Sublime Text２に含まれているコマンドラインツール、__subl__のシンボリックリンクを作るために下記をターミナル上で実行する。

```bash
ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

これだけ！

と言いたいところだけど、これを実行したあとに、

```bash
subl .
```

を叩いても、`subl: command not found`みたいになる場合には、ターミナルを再起動すれば大丈夫かも。

## さぁこれではじめよう

たまーに、上手く開かないこともあるので、そのときはコマンドを再度叩いてみてね。

[^Git]: ターミナルからじゃなくとも、Sublime Text2のGitのパッケージを使えば、Sublime Text2上でGitを扱うこともできる。[kemayo/sublime-text-2-git](https://github.com/kemayo/sublime-text-2-git)

[^Terminal]: 実際にはMac OS Xにもともとあるターミナルではなく、iTerm2っていうのを使ってます。画面分割とかもできて便利。[iTerm2 - Mac OS Terminal Replacement](http://www.iterm2.com/#/section/home)
