---
layout: 'note'
title: bashmarksでディレクトリをブックマークする
description: コマンドラインを使いはじめると、ディレクトリの移動が億劫。そのときにブックマークから引っ張ってこれると便利。
date: 2012-11-29
tags: cui
outDirPath: notes
---

[bashmarks](http://www.huyng.com/projects/bashmarks/)

このツール名から想像できる通り、

> directory bookmarks for the shell

ということで、コマンドライン上でちょこちょこと移動することになるディレクトリの場所を、ウェブページのブックマークのようにブックマークすることができるツール。

[最近はコマンドラインを使う機会](http://inkdesign.jp/notes/2012/11/29/open-file-by-subl.html)も多く、ターミナルを開いて、`cd hoge`とかしながらディレクトリをプロジェクトのディレクトリに移動する。

`cd`と打って、移動先のパスはFinderからディレクトリをドラッグ&ドロップすることでもダイレクトに移動できるが、それをいちいちやるのは面倒くさい。

## bashmarksの使い方

bashmarksを使えば、次のようにディレクトリを移動することができる。

```bash
 $ pwd
 /Users/YOURNAME/
 $ g public
 $ pwd
 /Users/YOURNAME/Dropbox/Public
```

bashmarksのコマンドとして売っているのは `g` のところ。あらかじめbashmarksで場所を保存（ブックマーク）し、それを呼び出しているだけ。この例では、DropboxのPublicディレクトリの場所を、あらかじめ__public__という名前で保存している。それは次のようにおこなう。

```bash
 $ pwd
 /Users/YOURNAME/Dropbox/Public
 $ s public
```

先ほどの `g`は__GO__であったのに対し、`s`、__Save__をする。順序が逆になったが、`s <bookmark_name>`でブックマークしたものを、`g <bookmark_name>`で呼び出すというシンプルなものだ。

ちなみにブックマークしたものは、`l`、__List__で呼び出せる。

```bash
 $ l
 public   /Users/YOURNAME/Dropbox/Public
```

ちなみに削除したい場合には、`d <bookmark_name>`で削除できる。つまり__Delete__ですな。

またブックマーク名は保存した名前をきっちりタイプする必要はなく、途中までタイプして<kbd>Tab</kbd>キーを叩けば補完される。便利ですな。

## bashmarksのインストール

インストールも特別難しいことはない。下記はそのままbashmarksのサイトから引用したもの。

> 1. git clone git://github.com/huyng/bashmarks.git
> 2. cd bashmarks && make install
> 3. add source ~/.local/bin/bashmarks.sh from within your ~.bash_profile or ~/.bashrc file

## z.shなんてのもある

bashmarksは自分でブックマークしていくものだが、[z](https://github.com/rupa/z)であればブックマークではなく、履歴残して、それらにアクセスすることができる。
今回はbashmarksについてのお話ということで、z.shについては [cd移動 を easyに z.sh de GO！ - bose999の試験管の中の話](http://d.hatena.ne.jp/bose999/20120806/1344185966) などを参加すると良い。[^zsh]こちらもインストールは難しくない。

## セットアップして損はなし

コマンドラインで色々はじめたばかりの人はぜひ。

[^zsh]: この記事ではzshを前提にしているが、bashでもzは使える。