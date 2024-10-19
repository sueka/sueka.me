---
layout: layouts/page.njk
templateEngine:
  - njk
  - md
title: このサイトについて
nocolophon: true
date: 2021-08-27
lastmod: 2021-12-21
writing: horizontal
---

このサイトは[私](#作者)の個人ブログです。

## 作者

Sueka と言ひます。東京でウェブアプリケーションを開発してゐます。<time datetime="2018-10">最近</time>の関心事はコンピューター・アーキテクチャと型理論です。

### 個人識別のための情報

実名（`氏 名` 形式、UTF-8）の SHA-256 ダイジェスト[^1]
: 8fa4302148c5858af6af1edb655bd35a95c23f5492f449d53eeb9d3ea40d8b04

[^1]:
    例へば、

    ``` sh
    printf %s '小町田 粲爾' | sha256sum
    ```

    を実行すると、

    ``` txt
    6a6ca88f7063555a65fc3d4806083f4554d66b02334e4e8897b56fbfda881d06  -
    ```

    と印字されます。

> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
>
> <pre class="mermaid">
>   graph LR
>     A[Christmas]    -->|Get money| B(Go shopping)
>     B --> C{Let me think}
>     C -->|One| D[Laptop]
>     C -->|Two| E[iPhone]
>     C -->|Three| F[Car]
> </pre>
>
> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### カレンダー

ゲストが追加されてゐる{豫定|よ|てい}の詳細は公開してゐません。

- [HTML](https://calendar.google.com/calendar/embed?src=uu6sc8cgpmvk87tamajg4nhl34%40group.calendar.google.com&hl=ja)
- [iCal](https://calendar.google.com/calendar/ical/uu6sc8cgpmvk87tamajg4nhl34%40group.calendar.google.com/public/basic.ics)

### アカウントの一覧

- [GitHub](https://github.com/sueka)
- [Stack Overflow](https://stackoverflow.com/users/8795737/h-sueka)
- [Twitter](https://twitter.com/hsueka)
- [pixiv](https://www.pixiv.net/member.php?id=28203588)
- [はてなブックマーク](http://b.hatena.ne.jp/sueka/bookmark)

## 著作権

<small>

  この節は、このサイトの著作権についてなるべく平易に説明しようとしてゐますが、ライセンスではありません。ライセンスそのものは [README.md#Licenses](https://github.com/sueka/sueka.me/blob/{{ gitCommitHash }}/README.md#licenses) から取得できます。

</small>

このサイトのソースコードは、一部の例外[^_2]を除いて、

[^_2]: あれば [README.md#Licenses](https://github.com/sueka/sueka.me/blob/{{ gitCommitHash }}/README.md#licenses) に記述されてゐます。

- [MIT-0](https://github.com/aws/mit-0) または 
- [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/) 

の下でライセンスされてをり[^_3]、

[^_3]: Wikipedia の記事の翻訳は [CC-BY-SA-3.0](https://creativecommons.org/licenses/by-sa/3.0/) でも利用可能です。

- 無償で、
- 商用か非商用かを問はず、
- 改変し、または改変せずに、
- 複製し、共有し、またはその両方を行ふ

ことができます。

### 表示と継承

CC BY-SA でライセンスされてゐる部分[^_4]を利用する場合、<i><ruby>表示<rt lang="en">Attributon</ruby></i>と<i><ruby>継承<rt lang="en">ShareAlike</ruby></i>を行ふ必要があります。また、表示について、

[^_4]: [README.md#Licenses](https://github.com/sueka/sueka.me/blob/{{ gitCommitHash }}/README.md#licenses) に記述されてゐます。具体的な文やプログラムなどによく使ひます。

- <i>原作者名</i>[^_5]は、
  - ライセンス対象物の Git コミット作者名を使用してください[^_6]。
  - 私の名前は、一般的な方法[^_7]で翻字して表示することができます。
  - 表示すべき人が私しか無い場合、<i>この情報</i>は省略<ruby>できます<rt lang="en">MAY</ruby>。
- <i>著作権表示</i>[^_8]は、
  - [MIT-0](https://github.com/sueka/sueka.me/blob/{{ gitCommitHash }}/LICENSE.MIT-0) と同じものを使用してください。
  - <i>原作者名</i>として表示すべき人が私しか無い場合、<i>この表示</i>を省略<ruby>してください<rt lang="en">SHOULD</ruby>。

[^_5]: CC-BY-SA-4.0 <ruby><span class="upright">3</span>条<rt lang="en">Section 3</rt></ruby> (a)(1)(A)(i) または CC-BY-SA-3.0 <ruby><span class="upright">4</span>条<rt lang="en">Section 4</rt></ruby> (c)(i)。

[^_6]:
    例へば、次のコマンドを実行すると、このファイルの Git コミット作者名が印字されます:

    ``` sh
    git log --format='%cN' --no-merges -- src/about.md | sort -u
    ```

[^_7]: キャピタライズ、仮名転写、アラビア文字化などが含まれます。たゞし、難読化（Base64 エンコードなど）は避けてください。
[^_8]: CC-BY-SA-4.0 <ruby><span class="upright">3</span>条<rt lang="en">Section 3</rt></ruby> (a)(1)(A)(ii) または CC-BY-SA-3.0 <ruby><span class="upright">4</span>条<rt lang="en">Section 4</rt></ruby> (c)。

---

たゞし、これらのライセンス対象物は、<strong><ruby>現状のまゝ<rt lang="en">AS-IS</ruby></strong>、**無保証で**提供されてゐます。その利用によって生ずる費用、損害その他の義務について、許諾者は最大限免責されます。

これらのライセンスにより、このサイトでホストされてゐるコンテンツも、ほゞ同じやうに利用することができます。たゞし、*このサイト上で利用可能なリソースには、私以外の人が著作権を保有する著作物が含まれてゐることがあります*。書体やロゴ、ビルドシステムによって同梱された外部ライブラリなどがこれに当たります。

<!-- ### Wikipedia 記事の翻訳についての補足

このサイトには、Wikipedia 記事の翻訳からなる記事があります。そのやうな記事は、ウィキペディア日本語版などに再移出できるやうに、CC-BY-SA-3.0 の下でも利用できるやうにしてゐます。

これらの翻訳をウィキメディア・プロジェクト（ウィキペディアなど）に移入する場合、*移入先の{編輯|へん|しふ}の方針やガイドラインを遵守*してください。例へば、ウィキペディア日本語版では、[表記ガイド](https://ja.wikipedia.org/wiki/WP:JPE)や[翻訳のガイドライン](https://ja.wikipedia.org/wiki/WP:TRANS)などに従ふべきです。とくに正書法には相当の違ひがあります。

クレジット（帰属）は次のやうに表示してください:

- 可能なら、*クレジットから私の名前を削除*してください。
  - バージョン 3.0 では、このやうな要求に応じなければならないのは、コレクションまたは翻案を作成する場合に限られます。（CC-BY-SA-3.0 <ruby><span class="upright">4</span>条<rt lang="en">Section 4</ruby> (a) を参照。）
- クレジットから私の名前を削除する場合、*私への言及を全て削除*することもできます。
- 私への言及を全て削除する場合も、移入先の編輯方針等に従って、一部の項目を表示することができます。
  - ウィキメディア・プロジェクトの編輯方針等で要求される場合、CC-BY-SA-3.0 <ruby><span class="upright">4</span>条<rt lang="en">Section 4</ruby> (a) に言ふ<em><ruby>実行可能な範囲<rt lang="en">the extent practicable</ruby>に含まれない</em>と見做します。念のために補足すると、このやうに解釈するのは、ウィキメディア・プロジェクトに移入する場合に限ります。
- この翻訳の*逐語的な*複製物をウィキペディアなどに移入する場合、*クレジットを全て提供*する必要があります。
  - ウィキペディアやウィキブックスに移入されたテキストは、<time datetime="2022-12">現在</time>のところ、CC-BY-SA-3.0 の下で利用許諾されます。バージョン 3.0 では、単に複製する場合、クレジットを全て提供しなければなりません。
  - ほとんどの場合、移入先の編輯方針等を遵守しようとすれば、自ずと翻案を作成することになるでせう。この場合は、上記の通り、私への言及を削除してください。
 -->
<!-- ## 外観

このサイトの外観について、テストを兼ねて説明しておきます。

### 紙面

### 縦書きと横書き

ほとんどのページは、横書きと縦書きで表示することができます。たゞし、複雑な数式を使用してゐるページは、数式を倒して表示することが難しかったゝめ、横書きでしか表示できないやうにしてゐます。

デフォルトでどちらのスタイルで表示されるかは、ページごとに適当に決めてゐます。どちらの種類のページも、代替スタイルシートを使って、別のスタイルに変更して表示することができます。現在のところ、主要な [evergreen]{lang=en} ブラウザーで、代替スタイルシートの手動変更をサポートしてゐるものは Firefox のみです。

縦書きに設定されてゐるページは、スクリーン高さが不十分なときは、横書きで表示されます。縦書きで表示される場合、[1]{.upright}行に表示される文字数は、最小で[27]{.tate-chu-yoko}文字となってゐます。この値は『白鯨（上）』（岩波書店、[2004]{.upright}年）の[413]{.upright}ページの行あたり文字数です。


- [1]{.upright}行に表示される文字数は、最大で[39]{.tate-chu-yoko}文字です。これは最近の岩波文庫の本と同じです。
- 行の前後（縦書きなら上下、横書きなら左右）の余白は、最小で φ rem です。 -->

## 外観

このサイトの外観について、テストを兼ねて説明しておきます。

### 紙面

### 縦書きと横書き

ほとんどのページは、横書きと縦書きで表示することができます。たゞし、複雑な数式を使用してゐるページは、数式を倒して表示することが難しかったゝめ、横書きでしか表示できないやうにしてゐます。

デフォルトはページごとに適当に決めてゐます。どちらの種類のページも、代替スタイルシートを使って、別のスタイルに変更して表示することができます。現在のところ、主要な [evergreen]{lang=en} ブラウザーで、代替スタイルシートの手動変更をサポートしてゐるものは Firefox のみです。

縦書きに設定されてゐるページは、スクリーン高さが不十分なときは、横書きで表示されます。縦書きで表示される場合、[1]{.upright}行に表示される文字数は、最小で[27]{.tate-chu-yoko}文字となってゐます。この値は『白鯨（上）』（岩波書店、[2004]{.upright}年）の[413]{.upright}ページの行あたり文字数です。


- [1]{.upright}行に表示される文字数は、最大で[39]{.tate-chu-yoko}文字です。これは最近の岩波文庫の本と同じです。
- 行の前後（縦書きなら上下、横書きなら左右）の余白は、最小で φ rem です。
