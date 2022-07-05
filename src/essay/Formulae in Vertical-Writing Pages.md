---
title: 縦書きページにおける数式
date: 2022-07-06
---

縦書きのページで数式を使ひたい。

<aside>

  この記事はテストページであり、レイアウト崩れを含む。最後の数式は、Firefox と Safari ならうまく表示されると思ふ。

</aside>

MathML は

<math> <mrow> <mi>x</mi> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mrow> </math>

といふゝうに Firefox では自動的に水平に表示され、Safari ではレイアウト崩れを起こす[^1]。この記事では扱はないが、MathJax や KaTeX も崩れる。

[^1]: Chrome は MathML をレンダリングできない。

勿論、次のやうに、\<math\> の [writing mode](https://drafts.csswg.org/css-writing-modes/#writing-mode){lang=en} を<ruby>水平<rt lang="en">horizontal</ruby>にすれば、Safari でも水平に表示される:

<math style="writing-mode: horizontal-tb"> <mrow> <mi>x</mi> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mrow> </math>

けれど、紙の本の縦組みでは、数式は普通、時計回りに直角に回して組まれるので、ウェブでも同じやうに表示したい[^4]。そこで、右の数式を CSS Transforms Module で回転させてみる。すると、

[^4]: 右の段階でやめるべきだと言ふ方も多数入らっしゃるとは思ふが……。

<math style="writing-mode: horizontal-tb; transform: rotate(90deg)"> <mrow> <mi>x</mi> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mrow> </math>

となる。Safari では中心を原点として回転し、Firefox では回転しない。後者の原因は、Firefox では MathML に CSS Transforms Module の効果が及ばない[^2]ことにある。よって、次のやうに、\<math\> の外に \<div\> のやうなコンテナーを置けば、Firefox でも回転する:

[^2]: 昔どこかで仕様を見た気がするけれど見付けられなかった。情報求む。

<div style="transform: rotate(90deg)">
<math style="writing-mode: horizontal-tb"> <mrow> <mi>x</mi> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mrow> </math>
</div>

原点の初期値は中央なので、上下中央から右に、表示領域の高さの半分程度移動させられてゐる。これを解決するには、原点を右上にして回転させ、下に移動させる:

<div style="transform: rotate(90deg) translateX(100%); transform-origin: top right">
<math style="writing-mode: horizontal-tb"> <mrow> <mi>x</mi> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mrow> </math>
</div>

まだコンテナーの形を変へずに数式を回転させてゐるので、数式の左に余白がある。また、数式の幅とページの幅の小さい方がページの高さよりも大きい場合、数式が画面の下に出てしまふことにもなる。コンテナーの縦横を入れ替へるには JavaScript を使って、次のやうにする。writing mode は回転する要素で変更する:

<div>
<div class="container" style="writing-mode: horizontal-tb; display: flex; transform: rotate(90deg) translateX(100%); transform-origin: top right; overflow-x: auto; overflow-y: clip">
<math style="white-space: nowrap"> <mrow> <mi>x</mi> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mrow> </math>
</div>
</div>

<script>
(function () {
  for (const math of document.querySelectorAll('.container > math')) {
  const container = math.parentElement
  const cc = container.parentElement
  const body = cc.parentElement

  const height = `min(${ body.clientHeight }px, ${ math.clientWidth }px)`
  const width = `${ math.clientHeight }px`
  cc.style.height = container.style.width = height
  cc.style.width = container.style.height = width
  }
})()
</script>

Safari と Chrome では CSS Transforms Module で回転した要素のスクロール方向は変はらない。この例のやうな、時計回りに直角に回転した要素なら、右にスクロールすると下に、左にスクロールすると上に表示領域が移動する[^3]。

[^3]: かなり使ひにくいが、面倒なので今回は対処しない。そも[〳〵]{.kunojiten}スクロールが必要な数式を書かないやうにしよう。`\phantom` とかを使はう。

最後に、横書きでもうまく表示されるやうにスクリプトを調整する:

<div>
<div class="another-container" style="writing-mode: horizontal-tb; display: flex; transform-origin: top right; overflow-x: auto; overflow-y: clip">
<math style="white-space: nowrap"> <mrow> <mi>x</mi> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>b</mi> <mo>±</mo> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo>-</mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mrow> </math>
</div>
</div>

<script>
(function () {
  for (const math of document.querySelectorAll('.another-container > math')) {
    const container = math.parentElement
    const cc = container.parentElement
    const body = cc.parentElement
    const bodyStyle = window.getComputedStyle(body)

    if (bodyStyle.writingMode === 'vertical-rl') {
      const height = `min(${ body.clientHeight }px, ${ math.clientWidth }px)`
      const width = `${ math.clientHeight }px`
      cc.style.height = container.style.width = height
      cc.style.width = container.style.height = width
      container.style.transform = 'rotate(90deg) translateX(100%)'
    }
  }
})()
</script>

製品版ではさらに、writing mode が変更されたときに、このスクリプトの if 文の部分を初期化して再実行する必要がある。
