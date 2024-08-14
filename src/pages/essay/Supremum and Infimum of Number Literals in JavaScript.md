---
title: JavaScript における数値リテラルの上限と下限
templateEngine: njk, md
useKaTeX: true
date: 2024-07-12
lastmod: 2024-08-14
---

$$
\\gdef\\F{𝔽}
$$
{.display-none}

JavaScript の数値型は IEEE 754 binary64 である。*binary64* は、1ビットの*符号ビット*と、11ビットの*指数部*、52ビットの*仮数部*とから成り、0より大きい範囲では、\\( 2^{-1074} \\) から \\( 2^{1024} - 2^{971} \\) までの値を表現する。一方、数値リテラルは、0より大きい範囲では、大凡 `(?<a>\d+)\.(?<b>\d+)?(?<e>e[+-]\d+)?` にマッチする文字列を受け入れる。つまり、数値型は固定精度だが、数値リテラルは任意精度である。そのため、処理系は、数値リテラルを何らかの方法で丸めたりして、数値に変換する必要がある。では、`0` と `Number.MIN_VALUE` の境界線、`Number.MAX_VALUE` と `+Infinity` の境界線はどこにあるのか。といふ話。

## 準備

符号ビットが \\( 0 \\) であり、指数部が \\( 0 \\) でも \\( 2047 \\) でもない binary64 ビット列[^fn-1]が示す値は、次の関数 \\( v_n(e ,\\, m) \\) で表される:

$$
\\begin{align*}
v_n(e ,\\, m) = \\text{} & \\underbrace{1.fraction}_{\\text{53 bits}} \\times 2^{e - 1023} \\\\
              = \\text{} & \\left( 1 + \\frac{m}{2^{52}} \\right) \\times 2^{e - 1023} \\\\
\\end{align*}
$$

また、符号ビットと指数部が \\( 0 \\) の binary64 ビット列[^fn-1]が示す値は、次の関数 \\( v_s(m) \\) で表される:

$$
\\begin{align*}
v_s(m) = \\text{} & \\underbrace{0.fraction}_{\\text{53 bits}} \\times 2^{1 - 1023} \\\\
       = \\text{} & \\left( 0 + \\frac{m}{2^{52}} \\right) \\times 2^{1 - 1023} \\\\
       = \\text{} & m \\times 2^{-1074} \\\\
\\end{align*}
$$

前者を<ruby>正規化数<rt lang="en">Normal numbers</ruby>、後者を<ruby>非正規化数<rt lang="en">Subnormal numbers</ruby>と言ふ。

[^fn-1]:
    こゝで考へてゐる \\( e \\) と \\( m \\) は指数部のバイアスと仮数部の最上位桁の省略が解決してゐないビット部分列だが、IEEE 754 における<ruby>浮動小数点データの*表現*<rt lang="en">*representations* of floating-point data</ruby>はこれが解決してゐるものを言ふため、<u>binary64 表現</u>ではない。

## 上限の推測

簡単なので上から。binary64 で表現できる `Infinity` の次に大きい値は \\( v_n(2046 ,\\, 2^{52} - 1) = 2^{1024} - 2^{971} \\) であり、その次に大きい値は、仮数部をデクリメントした、\\( v_n(2046 ,\\, 2^{52} - 2) = 2^{1024} - 2 \\times 2^{971} \\) である。しばらくこの傾向が続くので、\\( v_n(2046 ,\\, 2^{52} - 1) \\) よりも大きい有限数が表現されるとすれば、\\( v_n(2046 ,\\, 2^{52}) = 2^{1024} \\) だらう。これをリテラルとして使ってみよう。文字列をリテラルとして評価するために `eval` を使った:

``` ts
console.log(eval?.((2n ** 1024n).toString())) // prints Infinity
```

`Infinity` が印字された。また、\\( 2^{1024} - 2^{971} \\) がリテラルとして用ゐられると、`Number.MAX_VALUE` と解釈される:

``` ts
console.assert(eval?.((2n ** 1024n - 2n ** 971n).toString()) === Number.MAX_VALUE)
```

## 上限の発見

\\( \\left( 2^{1024} - 2^{971} ,\\, 2^{1024} \\right] \\) の間のどこで `Infinity` になるのかゞ知りたい。幅が \\( 2^{971} \\) なので、二分探索すれば、精々971回の反復で見付けられる:

``` ts
import assert from 'assert'

function find(min: bigint, max: bigint): bigint {
  assert(min < max)

  const mid = (min + max) / 2n

  if (Number.isFinite(eval?.(mid.toString())) && !Number.isFinite(eval?.((mid + 1n).toString()))) {
    return mid
  }

  if (!Number.isFinite(eval?.(mid.toString()))) {
    console.info('lower')
    return find(min, mid)
  }

  if (Number.isFinite(eval?.((mid + 1n).toString()))) {
    console.info('upper')
    return find(mid, max)
  }

  throw new Error
}

console.log(find(2n ** 1024n - 2n ** 971n, 2n ** 1024n))
```

これを実行すると、次の出力が得られる:

``` txt
lower
upper // 969 times
179769313486231580793728971405303415079934132710037826936173778980444968292764750946649017977587207096330286416692887910946555547851940402630657488671505820681908902000708383676273854845817711531764475730270069855571366959622842914819860834936475292719074168444365510704342711559699508093042880177904174497791n
```

といふわけで、`Infinity` と解釈される最小の*整数の*[^fn-2]数値リテラルは \\( 2^{1024} - 2^{970} \\) である、といふことが実験的に分かった。

[^fn-2]:
    実際には、`Number.MAX_VALUE` と解釈される値以上であり、かつ \\( 2^{1024} - 2^{970} \\) を超えない任意の実数の数値リテラルが `Number.MAX_VALUE` と解釈されるやうに見える（後で ECMA-262 を見るように、これは正しい。）ので、<i>`Infinity` と解釈される最小の*実数の*数値リテラル</i>と言っても差し支へない:

    ``` ts
    console.assert(eval?.(`${(2n ** 1024n - 2n ** 970n - 1n).toString()}.999`) === Number.MAX_VALUE) // should pass no matter how many 9's there are
    ```

<aside>

  ところで、この値は探索範囲 \\( \\left( 2^{1024} - 2^{971} ,\\, 2^{1024} \\right] \\)  の丁度中央にある値なので、上の二分探索は、`Infinity` になるべき値を `mid` とおいてゐれば、たった1回の反復で終了してゐたことになる:

  ``` ts
  function find(min: bigint, max: bigint): bigint {
    assert(min < max)

    const mid = (min + max) / 2n + (min + max) % 2n

    if (Number.isFinite(eval?.((mid - 1n).toString())) && !Number.isFinite(eval?.(mid.toString()))) {
      return mid
    }

    if (!Number.isFinite(eval?.((mid - 1n).toString()))) {
      console.info('lower')
      return find(min, mid)
    }

    if (Number.isFinite(eval?.(mid.toString()))) {
      console.info('upper')
      return find(mid, max)
    }

    throw new Error
  }

  console.log(find(2n ** 1024n - 2n ** 971n, 2n ** 1024n))
  ```

  このコードは情報ログを出力せず、数値リテラルが `Infinity` と解釈される最小の整数を印字する。

</aside>

## 下限の推測

上限の結果がかなり分かりやすかったので、下限はこれを利用して探さう。binary64 で表現できる `0` の次に小さい値は、\\( v_s(1) = 2^{-1074} \\) である。これがリテラルとして用ゐられると、`Number.MIN_VALUE` と解釈されることを確認する。\\( 10 \\) が \\( 2 \\) を因数に1つ持つことを利用すると、次のやうに書ける:

``` ts
function twoPowerRepr(e: bigint): string {
  console.assert(e < 0)
  return `0.${(10n ** -e / (2n ** -e)).toString().padStart(Number(-e), '0')}`
}

console.assert(eval?.(twoPowerRepr(-1074n)) === Number.MIN_VALUE) 
```

次に、上限の場合と同じやうに、2番目に小さい値を求める。非正規化数が常に正規化数よりも小さいことを確認する:

$$
\\begin{align*}
               & v_s(2^{52} - 1) < v_n(1 ,\\, 0) \\\\
\\iff \\text{} & (2^{52} - 1) \\times 2^{-1074} < \\left( 1 + \\frac{0}{2^{52}} \\right) \\times 2^{1 - 1023} \\\\
\\iff \\text{} & 2^{-1022} - 2^{-1074} < 2^{-1022} \\\\
\\end{align*}
$$

よって、非正規化数だけを調べればよい。\\( v_s(1) = 1 \\times 2^{-1074} \\) の次に小さい値は、仮数部をインクリメントした、\\( v_s(2) = 2 \\times 2^{-1074} \\) である。やはりこの傾向がしばらく続くので、もし \\( v_s(1) \\) よりも小さい値が表現されるとすれば、\\( v_s(0) = 0 \\times 2^{-1074} = 0 \\) だらう^[`0` は実際にかう表現される。]。

## 下限の発見

数値リテラルが \\( 0 \\) と解釈される最大の数は \\( \\left[ 0 ,\\, 2^{-1074} \\right) \\) にある。上限の場合は探索範囲の丁度中央にあったので、下限も同様に \\( \\frac{0 + 2^{-1074}}{2} = 2^{-1075} \\) にあると仮定して^[この時点では、<i>あったらいいな</i>くらゐに思ってゐた。]、上で定義した `twoPowerRepr` を使って確認してみよう:

``` ts
console.assert(eval?.(twoPowerRepr(-1075n)) === 0)
console.assert(eval?.(`${twoPowerRepr(-1075n)}001`) !== 0) // should pass no matter how many 0's there are
console.log(twoPowerRepr(-1075n))
```

偶然にもうまくいったやうだ。このコードは、数値リテラルが `0` と解釈される最大の実数を印字する:

``` txt
0.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024703282292062327208828439643411068618252990130716238221279284125033775363510437593264991818081799618989828234772285886546332835517796989819938739800539093906315035659515570226392290858392449105184435931802849936536152500319370457678249219365623669863658480757001585769269903706311928279558551332927834338409351978015531246597263579574622766465272827220056374006485499977096599470454020828166226237857393450736339007967761930577506740176324673600968951340535537458516661134223766678604162159680461914467291840300530057530849048765391711386591646239524912623653881879636239373280423891018672348497668235089863388587925628302755995657524455507255189313690836254779186948667994968324049705821028513185451396213837722826145437693412532098591327667236328125
```

## 仕様

さて、こゝで終はってもいゝけれど、ついでに仕様書を見ておかう。ECMAScript 2024 (ECMA-262, 15th edition) 6.1.6.1 に次のやうにある:

<div class="blockquote-like">

  この仕様において、「<i>\\( x \\) を指す Number 値</i>」([“the <i>Number value for \\( x \\)</i>”]{lang=en}) といふ語句は、\\( x \\) が正確な<ruby>実数的<rt lang="en">real</ruby>数学量（\\( \\pi \\) のやうな無理数であることもある。）を表現する場合、次の方法で選択される Number 値を意味する。Number 型の全ての有限数の集合から \\( -0_{\\F} \\) を取り除き、Number 型で表現できない2つの追加の値（すなはち、\\( 2^{1024} \\)（これは \\( +1 \\times 2^{53} \\times 2^{971} \\) であり、）と \\( -2^{1024} \\)（これは \\( -1 \\times 2^{53} \\times 2^{971} \\) である。））を加へたものを考へる。この集合から \\( x \\) に値として最も近い元を選択する。集合の中に［\\( x \\) に］等しく近い値が2つある場合、<ruby>仮数部<rt lang="en">significand</ruby>が偶数のものが選択される。この際、2つの追加の値 \\( 2^{1024} \\) と \\( -2^{1024} \\) の<ruby>仮数部<rt lang="en">significands</ruby>は偶数であると見做される。最後に、\\( 2^{1024} \\) が選択された場合は、それを \\( +\\infin_{\\F} \\) で置き換へ、\\( -2^{1024} \\) が選択された場合は、それを \\( -\\infin_{\\F} \\) で置き換へ、\\( +0_{\\F} \\) が選択された場合は、\\( x < 0 \\) であるときに限り、それを \\( -0_{\\F} \\) で置き換へる。その他の（選択された）値は変更せずに使はれる。この結果が <i>\\( x \\) を指す Number 値</i>である。（この手順は IEEE 754-2019 の roundTiesToEven モードの振る舞ひに正確に対応する。）

</div>

+++ 原文
<blockquote lang="en">

  In this specification, the phrase “the <i>Number value for \\( x \\)</i>” where \\( x \\) represents an exact real mathematical quantity (which might even be an irrational number such as \\( \\pi \\)) means a Number value chosen in the following manner. Consider the set of all finite values of the Number type, with \\( -0_{\\F} \\) removed and with two additional values added to it that are not representable in the Number type, namely \\( 2^{1024} \\) (which is \\( +1 \\times 2^{53} \\times 2^{971} \\)) and \\( -2^{1024} \\) (which is \\( -1 \\times 2^{53} \\times 2^{971} \\)). Choose the member of this set that is closest in value to \\( x \\). If two values of the set are equally close, then the one with an even significand is chosen; for this purpose, the two extra values \\( 2^{1024} \\) and \\( -2^{1024} \\) are considered to have even significands. Finally, if \\( 2^{1024} \\) was chosen, replace it with  \\( +\\infin_{\\F} \\); if \\( -2^{1024} \\) was chosen, replace it with  \\( -\\infin_{\\F} \\); if \\( +0_{\\F} \\) was chosen, replace it with \\( -0_{\\F} \\) if and only if \\( x < 0 \\); any other chosen value is used unchanged. The result is the Number value for \\( x \\). (This procedure corresponds exactly to the behaviour of the IEEE 754-2019 roundTiesToEven mode.)

</blockquote>
+++

よって、上限は、\\( 2^{1024} - 2^{971} = 2^{1024} - 2 \\times 2^{970} \\) と \\( 2^{1024} \\) に等しく近い値 \\( 2^{1024} - 2^{970} \\) のときに \\( 2^{1024} \\) が選択されて、\\( +\\infin_{\\F} \\) で置き換へられ、下限は、\\( 2^{-1074} = 2 \\times 2^{-1075} \\) と \\( 0 \\) に等しく近い値 \\( 2^{-1075} \\) のときに \\( 0 \\) が選択されたのだった。めでたし。

## おまけ

上の結果から、\\( -0_\\F \\) を指す最も簡単な数値リテラルは `-2e-324` である。
