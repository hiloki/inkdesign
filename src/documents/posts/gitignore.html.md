---
layout: 'note'
title: Gitの.gitignoreでサブディレクトリのファイルを除外するところでハマった
description: Gitの.gitignoreの除外パターンで、/**/*.jsが使えなかった話
date: 2012-12-14
tags: git
outDirPath: notes
---
Gitでバージョン管理したくないファイルを指定する場合には、[.gitignore](http://git-scm.com/book/ch2-2.html#Ignoring-Files)ファイルを作成し、その中に除外パターンを書く。

```bash
*.swp
._*
.DS_Store
node_modules
release
.sass-cache
```

こういう感じ。その__.gitignore__ファイルからみた除外したいパターンのパスを書く。Gitのドキュメントから引用すると、下記のようなパターンで除外ファイルを指定できる。[こちらから](http://git-scm.com/book/ja/Git-の基本-変更内容のリポジトリへの記録#ファイルの無視)日本語訳として引用。

```bash
# コメント。これは無視されます
*.a       # .a ファイルは無視
!lib.a    # しかし、lib.a ファイルだけは .a であっても追跡対象とします
/TODO     # ルートディレクトリの TODO ファイルだけを無視し、サブディレクトリの TODO は無視しません
build/    # build/ ディレクトリのすべてのファイルを無視します
doc/*.txt # doc/notes.txt は無視しますが、doc/server/arch.txt は無視しません
```

## で、ハマったところ

今回はプロジェクトにおいて除外したい特定ファイルがある。対処のディレクトリは下記のような構成になっており、

```bash
projects/templates/
projects/templates/pages/foo.html
projects/templates/pages/foo.js
projects/templates/pages/mypage/bar.js
projects/.gitignore
```

__templates/__以下の.jsを無視したい、というのをやりたかった。このとおり、templates/以下に展開するサブディレクトリのパターンは様々。そしてルートには、そのプロジェクトディレクトリとしての.gitignoreがあり、その中には__.DS_Store__などの定番の除外パターンを書いてある。

で、このルートにある.gitignoreに対し、下記のようなパターンを書いた。

```bash
templates/**/*.js
```

これによって、__各階層が異なるサブディレクトリも対象とて、その中のjsファイルを除外する__というができると思ったが、だめだった。これによって除外されるのは、

```bash
templates/pages/foo.js
```

だけ、となる。

じゃあ、階層ごとに、

```bash
templates/*.js
templates/**/*.js
templates/**/**/*.js
```

みたいに書く、というのは全然よろしくない。

と思ったところで、[鶏ハムの人](http://havelog.ayumusato.com/food/e330-tori_hamu.html)に助言をもらい、__templates/に.gitignoreを追加__した。

```bash
## projects/templates/.gitignore に下記を記述
*.js
```

するとどうでしょう、理想通り、__templates/以下のjsファイルが除外__されましたとさ。

ちなみに、この書き方だとtemplates/直下にあるjsしか除外されない気がしたのだけど、よく考えればそれは、

```bash
## projects/templates/.gitignore に下記を記述
/*.js
```

ということになりますかね。

めでたしめでたし。
