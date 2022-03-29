---
title: 訓点による和訳の表示
date: 2022-03-29
---

昔ぼんやり考へてゐた小ネタ[^2]。

[^2]: この記事は、縦書きのページに埋め込まれた横書きの段落、横書きのページに埋め込まれた縦書きの段落、そして本題である<i>訓点による和訳の表示</i>をテストするためのものでもある。この記事では、強制的に、欧文は横書きに、訓点の付いたテキストは縦書きにしてゐる。代替スタイルシートをサポートしてゐるブラウザならページの書字方向を変更できる。Firefox なら、メニューを表示、スタイルシート、<i>Prefer horizontal</i> の順に選ぶ。

書き下し文は、言はゞ外国語（[文言]{lang=zh}）の翻訳なので、他言語の文の翻訳の表示に使っても、メカニズムとしてはをかしくない。例へば、『<cite lang="en">Nineteen eighty-four</cite>』の冒頭

> It was a bright cold day in April, and the clocks were striking thirteen.
{.horizontal}

には

<div class="blockquote-like">

  It <ruby>was<rt lang="ja">だった</ruby><span class="kaeriten">㆓</span> a㆐<ruby>bright<rt lang="ja">明るく</ruby>㆐<ruby>cold<rt lang="ja">寒い</ruby>㆐<ruby>day<rt lang="ja">日</ruby><span class="kaeriten">㆒㆑</span> <ruby>in<rt lang="ja">の</ruby><span class="kaeriten">㆑</span> <ruby>April<rt lang="ja">[4]{.upright}月</ruby>, and <ruby>the clocks<rt lang="ja">時計</ruby><ruby>&nbsp;<rt lang="ja">は</ruby> <ruby>were<rt lang="ja">た</ruby><span class="kaeriten">㆑</span> <ruby>striking<rt lang="ja">打ってゐ</ruby><span class="kaeriten">㆓</span> <ruby>thirteen<rt lang="ja">[13]{.tate-chu-yoko}時</ruby><span class="kaeriten">㆒</span><ruby>&nbsp;<rt lang="ja">を</ruby>.
  {lang=en .vertical .kuntened}
</div>

のやうな訓点を振る。総ルビであり、ルビの無い単語はいはゆる置き字である。訓点に従って書き下し文にし、適当に句読点を補へば、

<div class="blockquote-like">

  [4]{.upright}月の明るく寒い日だった。時計は[13]{.tate-chu-yoko}時を打ってゐた。
</div>

といふ翻訳文になる。

この表示を原文の引用と見做すことができるかどうかは分からない。原文の一部に圏点を打ったり、ルビを振ったりするのは、その圏点やルビが引用者によるものであることを明示すれば、翻案とは解釈されないだらう。けれども、訓点の場合、*訓読文の作成は翻案または翻訳に該当する*とした判例（東京地裁昭和[51]{.tate-chu-yoko}年（ワ）第[8446]{.upright}号）があり、安易に翻案と見做されないと言ひ切ることはできないと思ふ。そのため、この記事では、原文はすでに著作権が消滅してゐるものに限った。なほ、翻訳して<b>引用</b>する行為は合法（著作権法[47]{.tate-chu-yoko}条の[6]{.upright}第[1]{.upright}項）である。

ところで、右縦書きと左横書きには、*書字方向を時計回りに直角に回した方向が行送り方向である*といふ共通点がある。和文の縦組みにおいて欧文や数式、プログラムなどの左横書きされるべきものを時計回りに直角に回して組むことができるのはこれのおかげである[^1]。

[^1]: 右縦書きの文の中に左横書きされるべきものを埋め込むときに時計回りに直角に回すのは、左横書きの書字方向をさうすれば右縦書きの書字方向となるから。

そのため、右横書きのテキストを右縦書きの文の中に自然に埋め込むことはできない。例へば、ヨナ書[1]{.upright}章[17]{.tate-chu-yoko}節[^3]に同じやうに訓点を施すと、次のやうになってしまふ[^4]:

[^3]: 『白鯨』に出てゐたのでなんとなく思ひ入れがある。
[^4]: 訓読しやすいやうに、あへて書字方向を分離してゐない。

<div class="blockquote-like">

  <ruby>ו<rt lang="jpn-archaic">さて</ruby><ruby>ימן<rt lang="jpn-archaic">すでに</ruby><span class="kaeriten">㆑</span> <ruby>יהוה<rt lang="jpn-archaic">ヱホバ</ruby> <ruby>דג<rt lang="jpn-archaic">魚</ruby><span class="kaeriten">㆑</span><ruby>&nbsp;<rt lang="jpn-archaic">を備へおきて</ruby> <ruby>גדול<rt lang="jpn-archaic">大なる</ruby> <ruby>לבלע<rt lang="jpn-archaic">呑ましめ給</ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">へり</ruby> <ruby>את־יונה<rt lang="jpn-archaic">ヨナ</ruby><span class="kaeriten">㆒</span><ruby>&nbsp;<rt lang="jpn-archaic">を</ruby> <ruby>ויהי<rt lang="jpn-archaic">あ</ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">りき</ruby> <ruby>יונה<rt lang="jpn-archaic">ヨナ</ruby><ruby>&nbsp;<rt lang="jpn-archaic">は</ruby> <ruby>במעי<rt lang="jpn-archaic">腹の中</ruby><span class="kaeriten">㆒㆑</span><ruby>&nbsp;<rt lang="jpn-archaic">に</ruby> <ruby>הדג<rt lang="jpn-archaic">魚</ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">の</ruby> <ruby>שלשה<rt lang="jpn-archaic">三</ruby> <ruby>ימים<rt lang="jpn-archaic">日</ruby> <ruby>ושלשה<rt lang="jpn-archaic">三</ruby> <ruby>לילות<rt lang="jpn-archaic">夜</ruby><span class="kaeriten">㆒</span>׃
  {lang=hbo .vertical .kuntened}
</div>

原文はレニングラード写本（母音無し）、書き下し文は『文語訳 旧約聖書 Ⅳ 預言』（岩波書店、[2015]{.upright}年）。

オリエンテーションをロックし、スクリーンを反時計回りに直角に回して見れば、左横書きのヘブライ語文みたいなものが見えると思ふ。
