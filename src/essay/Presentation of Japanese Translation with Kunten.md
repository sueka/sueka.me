---
title: 訓点による和訳の表示
title_rubied: '{訓点|くん|てむ}による{和訳|わ|やく}の{表示|へう|じ}'
date: 2022-03-29
lastmod: 2022-07-12
he: true
---

昔ぼんやり考へてゐた小ネタ。

<aside>

  この記事は、縦書きのページに埋め込まれた横書きの段落と、その逆をテストするためのものでもある。そのため、欧文は横書きに、訓点の付いたテキストは縦書きに強制してゐる。代替スタイルシートをサポートしてゐるブラウザーならページの書字方向を変更できる。Firefox ならメニューを表示、スタイルシート、<i>Horizontal Writing</i> の順に選ぶ。

</aside>

書き下し文は言はゞ外国語（[文言]{lang=zh}）の翻訳なので、他言語の文の翻訳の表示に訓点を使っても、メカニズムとしてはをかしくない。例へば、『<cite lang="en">Nineteen eighty-four</cite>』の冒頭、

> It was a bright cold day in April, and the clocks were striking thirteen.
{lang=en .horizontal}

には

<div class="blockquote-like">

  It <ruby>was<rt lang="ja">だった</rt></ruby><span class="kaeriten">㆑</span> a<span class="kaeriten">㆑</span>㆐<ruby>bright<rt lang="ja">明るく</rt></ruby>㆐<ruby>cold<rt lang="ja">寒い</rt></ruby>㆐<ruby>day<rt lang="ja">日</rt></ruby> <ruby>in<rt lang="ja">の</rt></ruby><span class="kaeriten">㆑</span> <ruby>April<rt lang="ja">[4]{.upright}月</rt></ruby>, and <ruby>the clocks<rt lang="ja">時計</rt></ruby><ruby>&nbsp;<rt lang="ja">は</rt></ruby> <ruby>were<rt lang="ja">た</rt></ruby><span class="kaeriten">㆑</span> <ruby>striking<rt lang="ja">打ってゐ</rt></ruby><span class="kaeriten">㆓</span> <ruby>thirteen<rt lang="ja">[13]{.tate-chu-yoko}時</rt></ruby><span class="kaeriten">㆒</span><ruby>&nbsp;<rt lang="ja">を</rt></ruby>.
  {lang=en .vertical .kuntened}
</div>

のやうな訓点を振る。総ルビで、ルビの無い単語はいはゆる置き字。訓点に従って書き下し文にして、適当に句読点を補ふと、

<div class="blockquote-like">

  [4]{.upright}月の明るく寒い日だった。時計は[13]{.tate-chu-yoko}時を打ってゐた。
</div>

といふ翻訳文になる。

利点は原文と訳文を同時に表示できることくらゐしか無い。原文は（欧文なら）寝てゐて読みづらく、翻訳は語順が違って読みづらい。選択してコピーしたものも使ひ物にならない。

この表示を施して引用することが<i>引用</i>（著作権法[32]{.tate-chu-yoko}条）に当たるかどうかは分からない。原文の一部に圏点を打ったり、ルビを振ったりするのは、その圏点やルビが引用者によるものであることを明示すれば、翻案と見做されることはないだらう。しかし、訓点の場合、*訓読文の作成は翻案に該当する*とした判例[^5]がある。そのため、この記事では、原文はすでに著作権が消滅してゐるものに限った。なほ、翻訳して<i>引用</i>する行為は合法である[^6]。

[^5]: 東京地方裁判所昭和[51]{.tate-chu-yoko}年（ワ）第[8446]{.upright}号同[57]{.tate-chu-yoko}年[3]{.upright}月[8]{.upright}日判決。
[^6]: 著作権法[47]{.tate-chu-yoko}条の[6]{.upright}第[1]{.upright}項。

ところで、右縦書きと左横書きには、*書字方向を時計回りに直角に回した方向が行送り方向である*といふ共通点がある。和文の縦組みにおいて欧文や数式、プログラムなどの左横書きされるべきものを時計回りに直角に回して組むことができるのはこれのおかげである[^1]。

[^1]: 右縦書きの文の中に左横書きされるべきものを埋め込むときに時計回りに直角に回すのは、左横書きの書字方向をさうすれば右縦書きの書字方向となるから。

そのため、右横書きのテキストを右縦書きの文の中に自然に埋め込むことはできない。例へば、ヨナ書[1]{.upright}章[17]{.tate-chu-yoko}節[^3]に同じやうに訓点を施すと、次のやうになってしまふ[^4]:

[^3]: 『白鯨』に出てゐたのでなんとなく思ひ入れがある。
[^4]: 訓読しやすいやうに、あへて書字方向を分離してゐない。

<div class="blockquote-like">

  <ruby>ו<rt lang="jpn-archaic">さて</rt></ruby><ruby>ימן<rt lang="jpn-archaic">すでに</rt></ruby><span class="kaeriten">㆑</span> <ruby>יהוה<rt lang="jpn-archaic">ヱホバ</rt></ruby> <ruby>דג<rt lang="jpn-archaic">魚</rt></ruby><span class="kaeriten">㆑</span><ruby>&nbsp;<rt lang="jpn-archaic">を備へおきて</rt></ruby> <ruby>גדול<rt lang="jpn-archaic">大なる</rt></ruby> <ruby>לבלע<rt lang="jpn-archaic">呑ましめ給</rt></ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">へり</rt></ruby> <ruby>את־יונה<rt lang="jpn-archaic">ヨナ</rt></ruby><span class="kaeriten">㆒</span><ruby>&nbsp;<rt lang="jpn-archaic">を</rt></ruby> <ruby>ויהי<rt lang="jpn-archaic">あ</rt></ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">りき</rt></ruby> <ruby>יונה<rt lang="jpn-archaic">ヨナ</rt></ruby><ruby>&nbsp;<rt lang="jpn-archaic">は</rt></ruby> <ruby>במעי<rt lang="jpn-archaic">腹の中</rt></ruby><span class="kaeriten">㆒㆑</span><ruby>&nbsp;<rt lang="jpn-archaic">に</rt></ruby> <ruby>הדג<rt lang="jpn-archaic">魚</rt></ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">の</rt></ruby> <ruby>שלשה<rt lang="jpn-archaic">三</rt></ruby> <ruby>ימים<rt lang="jpn-archaic">日</rt></ruby> <ruby>ושלשה<rt lang="jpn-archaic">三</rt></ruby> <ruby>לילות<rt lang="jpn-archaic">夜</rt></ruby><span class="kaeriten">㆒</span>׃
  {lang=hbo .vertical .kuntened}
</div>

原文はレニングラード写本（母音無し）、書き下し文は『文語訳 旧約聖書 Ⅳ 預言』（岩波書店、[2015]{.upright}年）。

オリエンテーションをロックし、スクリーンを反時計回りに直角に回して見れば、左横書きのヘブライ語文みたいなものが見えると思ふ。
