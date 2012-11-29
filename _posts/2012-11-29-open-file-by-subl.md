---
layout: post
title: Mac OS XのターミナルからSublime Text2を立ち上げられるようにすると地味に便利
description: 黒い画面もといターミナルなどのコマンドラインツールを使う機会が増えてきたので、地味なTipsで少し便利にしてみよう。
categories:
  - notes
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

{% highlight python %}
subl .
{% endhighlight %}

これで現在いるディレクトリをそのままプロジェクトとしてSublime Text2で開くことができるようになる。

地味に便利と思うんですが、どうでしょうか。
興味を持ったら次へ。

## sublへのシンボリックリンクを作る

Sublime Text２に含まれているコマンドラインツール、__subl__のシンボリックリンクを作るために下記をターミナル上で実行する。

{% highlight python %}
ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
{% endhighlight %}

これだけ！

と言いたいところだけど、これを実行したあとに、

{% highlight python %}
subl .
{% endhighlight %}

を叩いても、`subl: command not found`みたいになる場合には、PATHの設定が必要かもしれない。

何をするかというと、ルート（ユーザー名のディレクトリのところ）にある、.bash_profileに対し、`export PATH=~/bin:$PATH`というの書く。

.bash_profileが無い場合、またはよくわからないという人もおそらくいるとはおもうので、下記の流れをターミナル上でやってみると良い。[^bash]

1. `sudo vi .bash_profile` を実行し、.bash_profileを開く。sudoでの実行のため、passwordを尋ねられるとおもうが、それにはログインアカウントのパスワードを入力すればいい。

2. <kbd>i</kbd>を叩くと、__INSERT__モードになるので、そこに`export PATH=~/bin:$PATH`と書く。もし開いたときに色々中に書いてあるようであれば、それらの後に記述する。INSERTモードではマウスでキャレットを移動することはできないので、キーボードの矢印キーで移動する。このあたりの操作はviエディタの操作になるので、もっとうまく扱いたい場合は、[コマンドリファレンス](http://hp.vector.co.jp/authors/VA016670/unix/vi_reference.html)を参照するといい。

3. 記述したら、<kbd>esc</kbd>キーでINSERTモードを抜けて、<kbd>:wq</kbd>と打って実行する。

4. 最後に記述した内容を反映させるため、`source .bash_profile`を実行する

これでおそらく`subl`コマンドが有効になるはず。

## さぁこれではじめよう

{% highlight python %}
subl .
{% endhighlight %}

※たまーに、上手く開かないこともあるので、そのときはコマンドを叩いてみてね。
{: .small}

[^Git]: ターミナルからじゃなくとも、Sublime Text2のGitのパッケージを使えば、Sublime Text2上でGitを扱うこともできる。[kemayo/sublime-text-2-git](https://github.com/kemayo/sublime-text-2-git)

[^Terminal]: 実際にはMac OS Xにもともとあるターミナルではなく、iTerm2っていうのを使ってます。画面分割とかもできて便利。[iTerm2 - Mac OS Terminal Replacement](http://www.iterm2.com/#/section/home)

[^bash]: .bash_profileというファイルに対して書込をおこなうが、環境によっては、このファイルに色々記述があるかもしれないので、不安な人はバックアップをとっておこう。