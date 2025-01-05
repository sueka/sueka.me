---
title: 訓点による和訳の表示
title_rubied: '{訓点|くん|てむ}による{和訳|わ|やく}の{表示|へう|じ}'
date: '2022-03-29'
lastmod: '2023-03-27'
templateEngine: null
he: true
---
昔ぼんやり考へてゐた小ネタ。

## 概要

書き下し文は言はゞ外国語（[文言]{lang=zh}）の翻訳なので、他言語の文の翻訳の表示に訓点を使っても、メカニズムとしてはをかしくないはずだ。例へば、『<cite lang="en">Nineteen eighty-four</cite>』の冒頭、

> It was a bright cold day in April, and the clocks were striking thirteen.
{lang=en .horizontal}

に

<div class="blockquote-like">

  It
  <ruby>was<rt lang="ja">だった</ruby><span class="kaeriten">㆑</span>
  a<span class="kaeriten">㆑</span>㆐<ruby>bright<rt lang="ja">明るく</ruby>㆐<ruby>cold<rt lang="ja">寒い</ruby>㆐<ruby>day<rt lang="ja">日</ruby>
  <ruby>in<rt lang="ja">の</ruby><span class="kaeriten">㆑</span>
  <ruby>April<rt lang="ja">[4]{.upright}月</ruby>,
  and
  <ruby>the clocks<rt lang="ja">時計</ruby><ruby>&nbsp;<rt lang="ja">は</ruby>
  <ruby>were<rt lang="ja">た</ruby><span class="kaeriten">㆑</span>
  <ruby>striking<rt lang="ja">打ってゐ</ruby><span class="kaeriten">㆓</span>
  <ruby>thirteen<rt lang="ja">[13]{.tate-chu-yoko}時</ruby><span class="kaeriten">㆒</span><ruby>&nbsp;<rt lang="ja">を</ruby>.
  {lang=en .vertical .kuntened}

</div>

のやうな訓点^[総ルビ。ルビの無い単語はいはゆる置き字。]を振っておくと、訓点に従って書き下し文にして、適当に句読点を補ふだけで、

<div class="blockquote-like">

  [4]{.upright}月の明るく寒い日だった。時計は[13]{.tate-chu-yoko}時を打ってゐた。
</div>

といふ翻訳文が得られる。

## 利点と缺点

利点は

- 原文と訳文が同時に表示されること

くらゐだが、缺点は

- （欧文の場合）原文が倒れてゐること、
- 翻訳が語順通りに表示されないこと、
- 選択してコピーしたものに返り点とルビ[^7]が付いてくること、
- 原文の著作権を侵害するおそれがあること

など色々ある。

[^7]: ブラウザー依存。Firefox では \<rp\> や \<rt\> の内容は、ルビ全体が選択されてゐるなら、コピーされない。

<i>原文の著作権を侵害するおそれ</i>について、少し補足する。原文を<i>引用</i>（著作権法[32]{.tate-chu-yoko}条）できる場合でも、このやうな表示を施して引用することが<i>引用</i>に当たるかどうかは分からない。原文の一部に圏点を打ったり、ルビを振ったりするだけなら、その圏点やルビが引用者によるものであることを明示すれば、翻案と見做されることはないだらう。しかし、訓点の場合、*訓読文の作成は翻案に該当する*とした判例[^5]がある。一方、*翻訳*して<i>引用</i>する行為は合法[^6]。したがって、**普通に翻訳して引用しておけば適法だったが、この表示を用ゐたゝめに翻案権を侵害してしまった**といふことが起こりうる[^8]。

[^5]: 東京地方裁判所昭和[51]{.tate-chu-yoko}年（ワ）第[8446]{.upright}号同[57]{.tate-chu-yoko}年[3]{.upright}月[8]{.upright}日判決。
[^6]: 著作権法[47]{.tate-chu-yoko}条の[6]{.upright}第[1]{.upright}項。
[^8]: この記事では原文はすでに著作権が消滅してゐるものに限った。

---

ところで、右縦書きと左横書きには、*書字方向を時計回りに直角に回した方向が行送り方向となる*といふ共通点がある。和文の縦組みで欧文や数式、プログラムなどの左横書きされるべきものを時計回りに直角に回して組むことができるのはこれのおかげである[^1]。

[^1]: 右縦書きの文の中に左横書きされるべきものを埋め込むときに時計回りに直角に回すのは、左横書きの書字方向をさうすれば右縦書きの書字方向となるから。

そのため、右横書きのテキストを右縦書きの文の中に自然に埋め込むことはできない。例へば、ヨナ書[1]{.upright}章[17]{.tate-chu-yoko}節[^3]に同じやうに訓点を施すと、次のやうになってしまふ[^4]:

[^3]: 『白鯨』に出てゐたのでなんとなく思ひ入れがある。
[^4]: 訓読のしやすさを優先して、あへて書字方向を分離してゐない。

<div class="blockquote-like">

  <ruby>ו<rt lang="jpn-archaic">さて</ruby><ruby>ימן<rt lang="jpn-archaic">すでに</ruby><span class="kaeriten">㆑</span>
  <ruby>יהוה<rt lang="jpn-archaic">ヱホバ</ruby>
  <ruby>דג<rt lang="jpn-archaic">魚</ruby><span class="kaeriten">㆑</span><ruby>&nbsp;<rt lang="jpn-archaic">を備へおきて</ruby>
  <ruby>גדול<rt lang="jpn-archaic">大なる</ruby>
  <ruby>לבלע<rt lang="jpn-archaic">呑ましめ給</ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">へり</ruby>
  <ruby>את־יונה<rt lang="jpn-archaic">ヨナ</ruby><span class="kaeriten">㆒</span><ruby>&nbsp;<rt lang="jpn-archaic">を</ruby>
  <ruby>ויהי<rt lang="jpn-archaic">あ</ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">りき</ruby>
  <ruby>יונה<rt lang="jpn-archaic">ヨナ</ruby><ruby>&nbsp;<rt lang="jpn-archaic">は</ruby>
  <ruby>במעי<rt lang="jpn-archaic">腹の中</ruby><span class="kaeriten">㆒㆑</span><ruby>&nbsp;<rt lang="jpn-archaic">に</ruby>
  <ruby>הדג<rt lang="jpn-archaic">魚</ruby><span class="kaeriten">㆓</span><ruby>&nbsp;<rt lang="jpn-archaic">の</ruby>
  <ruby>שלשה<rt lang="jpn-archaic">三</ruby>
  <ruby>ימים<rt lang="jpn-archaic">日</ruby>
  <ruby>ושלשה<rt lang="jpn-archaic">三</ruby>
  <ruby>לילות<rt lang="jpn-archaic">夜</ruby><span class="kaeriten">㆒</span>׃
  {lang=hbo .vertical .kuntened}

</div>

原文はレニングラード写本（母音無し）、書き下し文は『文語訳 旧約聖書 Ⅳ 預言』（[2015]{.upright}年、岩波書店）。

画面の回転をロックして、スクリーンを反時計回りに直角に回して見れば、左横書きのヘブライ語文みたいなものが見えると思ふ。
