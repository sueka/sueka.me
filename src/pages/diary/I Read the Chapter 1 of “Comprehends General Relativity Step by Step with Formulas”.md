---
title: 『一般相対性理論を一歩一歩数式で理解する』第1章を読んだ
url: ./i-read-comprehends-general-relativity-1-math.html
templateEngine:
  - njk
  - md
date: '2020-10-29'
lastmod: '2024-06-08'
useKaTeX: true
draft: true
---
『[一般相対性理論を一歩一歩数式で理解する](https://www.beret.co.jp/books/detail/638)』第1章（数学の準備）を読んだ。気付いたことを箇条書きにする。

<small>

  この記事は自分が読み返すときのための覚え書きであって、書籍の内容を要約しようとするものではありません。

</small>

- p. 20 では<u>交換法則</u>として \\( a \\times b = -(b \\times a) \\) が導入されてゐるが、これは<i>反交換法則</i>だと思ふ。

- pp. 26–27 に関聯して、積の微分法則が内積に拡張できることを示す:

  \\( \\boldsymbol{a}(t) = \\begin{pmatrix} x(t) \\\\ y(t) \\\\ z(t) \\end{pmatrix} \\)、\\( \\boldsymbol{b}(t) = \\begin{pmatrix} \\alpha(t) \\\\ \\beta(t) \\\\ \\gamma(t) \\end{pmatrix} \\) とする。このとき、

  $$
  \\begin{align*}
  (\\boldsymbol{a}(t) \\cdot \\boldsymbol{b}(t))'
    & = \\left( \\begin{pmatrix} x(t) \\\\ y(t) \\\\ z(t) \\end{pmatrix} \\cdot \\begin{pmatrix} \\alpha(t) \\\\ \\beta(t) \\\\ \\gamma(t) \\end{pmatrix} \\right)' \\\\
    & = ( x(t) \\alpha(t) + y(t) \\beta(t) + z(t) \\gamma(t) )' \\\\
    & = \\green{x'(t) \\alpha(t)} \\blue{+ x(t) \\alpha'(t)} \\green{+ y'(t) \\beta(t)} \\blue{+ y(t) \\beta'(t)} \\green{+ z'(t) \\gamma(t)} \\blue{+ z(t) \\gamma'(t)} \\\\
    & = \\green{\\begin{pmatrix} x'(t) \\\\ y'(t) \\\\ z'(t) \\end{pmatrix} \\cdot \\begin{pmatrix} \\alpha(t) \\\\ \\beta(t) \\\\ \\gamma(t) \\end{pmatrix}} \\blue{+ \\begin{pmatrix} x(t) \\\\ y(t) \\\\ z(t) \\end{pmatrix} \\cdot \\begin{pmatrix} \\alpha'(t) \\\\ \\beta'(t) \\\\ \\gamma'(t) \\end{pmatrix}} \\\\
    & = \\boldsymbol{a}'(t) \\cdot \\boldsymbol{b}(t) + \\boldsymbol{a}(t) \\cdot \\boldsymbol{b}'(t) \\\\
  \\end{align*}
  $$

- p. 39 の (2) 左図の \\( (a, b) \\) は、直線 \\( l \\) 上で \\( t = 0 \\) の点を指す。

- p. 40 の数式は \\( \\nabla f \\left( = \\begin{pmatrix} \\frac{\\partial f}{\\partial x} \\\\[1ex] \\frac{\\partial f}{\\partial y} \\end{pmatrix} \\right) \\) と \\( \\begin{pmatrix} \\cos \\theta \\\\ \\sin \\theta \\end{pmatrix} \\) の内積であることを確認しながら読むと読みやすくなる:

  $$
  \\begin{align*}
  \\frac{\\partial f}{\\partial x} \\cos \\theta + \\frac{\\partial f}{\\partial y} \\sin \\theta
    & = \\begin{pmatrix} \\frac{\\partial f}{\\partial x} \\\\[1ex] \\frac{\\partial f}{\\partial y} \\end{pmatrix} \\cdot \\begin{pmatrix} \\cos \\theta \\\\
    \\sin \\theta \\end{pmatrix} \\\\
    & = \\left\| \\begin{pmatrix} \\frac{\\partial f}{\\partial x} \\\\[1ex] \\frac{\\partial f}{\\partial y} \\end{pmatrix} \\right\| \\left\| \\begin{pmatrix} \\cos \\theta \\\\ \\sin \\theta \\end{pmatrix} \\right\| \\cos(\\theta - \\alpha) \\\\
    & \\cdots \\\\
  \\end{align*}
  $$

- p. 49 の \\( \\frac{\\partial x}{\\partial x'} = a_1, \\ldots \\) は \\( x = a_1 x' + b_1 y' + c_1 z', \\ldots \\) をそれぞれ \\( x', \\ldots \\) で偏微分すると得られる。

- p. 68 では<i>弧度法の定義（単位円の円周）</i>を使ふ。たまに度忘れするので注意したい。

- p. 88 で \\( C_1 \\)、\\( C_2 \\)、\\( C_3 \\) に使はれてゐる \\( x \\)、\\( y \\) はパラメーター。

- p. 89 の \\( \\int_a^0 A_x \\left( x, b \\left( 1 - \\frac{x}{a} \\right) , 0 \\right) dx + \\int_0^b A_y \\left( a \\left( 1 - \\frac{y}{b} \\right) , y, 0 \\right) dy \\) は pp. 72–73 で導入された \\( \\int_C \\boldsymbol{F} \\cdot d \\boldsymbol{r} = \\int_{x(a)}^{x(b)} F_x(x, y) dx + \\int_{y(a)}^{y(b)} F_y(x, y) dy \\) の適用例。

- p. 89 で法線ベクトルを右ねじの向きに取った理由はよく分からなかった[^3]。後日追記するかも。

  [^3]: これを書いてゐるときは「一貫性があれば十分」と思ってゐる。

- p. 98 に関聯して、\\( \\nabla \\cdot \\frac{\\boldsymbol{x} - \\boldsymbol{a}}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} = 0 \\) となる \\( n \\) が \\( 3 \\) 以外にないことを確認する:

  左辺の \\( \\nabla \\) を展開すると、

  $$
  \\begin{align*}
  \\nabla \\cdot \\frac{\\boldsymbol{x} - \\boldsymbol{a}}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n}
    & = \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) + \\frac{\\partial}{\\partial y} \\left( \\frac{y - b}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) + \\frac{\\partial}{\\partial z} \\left( \\frac{z - c}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) \\\\
    & = 0 \\\\
  \\end{align*}
  $$

  \\( \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) \\) を変形すると、

  $$
  \\begin{align*}
  & \\phantom{=} \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) \\\\
  &           =  \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2}}} \\right) \\\\
  &           =  \\frac{1}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2}}} + (x - a) \\cdot \\left( - \\frac{n}{2} \\right) \\cdot \\frac{1}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2} + 1}} \\cdot 2 (x - a) \\\\
  &           =  \\frac{1}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2} + 1}} (\|\\boldsymbol{x} - \\boldsymbol{a}\|^2 - n (x - a)^2) \\\\
  \\end{align*}
  $$

  よって、\\( \\boldsymbol{x} \\ne \\boldsymbol{a} \\) と対称形から、

  $$
  \\begin{align*}
  & \\phantom{\\iff} 3 \|\\boldsymbol{x} - \\boldsymbol{a}\|^2 - n (x - a)^2 - n (y - b)^2 - n (z - c)^2 = 0 \\\\
  &           \\iff  n = 3 \\\\
  \\end{align*}
  $$

- p. 99 では \\( \\left( \\frac{\\partial^2}{\\partial x^2} - \\frac{1}{c^2} \\frac{\\partial^2}{\\partial t^2} \\right) \\varphi(x, t) = 0 \\) が<q>波動方程式（1次）</q>として導入されるが、これは次数ではなく次元数だと思ふ。p. 102 も同じ。

- p. 107 に<q>\\( \\Delta \\left( \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|^{1 - \\alpha}} \\right) \\) の符号が負</q>とあるが、これが負となるには、p. 105 で \\( \\alpha \\) を定義するときに \\( 0 < \\alpha < 1 \\) としておく必要がある。\\( \\alpha \\to +0 \\) に飛ばすのはこれより後である。

- p. 110 の<q>(1.21) より</q>とある変形では、偏微分の順序が入れ替へられてゐる[^4]。

  [^4]: 中扉には<q>微分と積分の順序も，2変数関数の偏微分の順序も常に交換可能とします</q>とある。

- p. 111 の \\( \\frac{\\partial^2}{\\partial u^2} f(\\boldsymbol{y}, u) \\) の項の係数に \\( -\\frac{1}{c^2} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\) といふ項があるが、\\( \\frac{\\partial^2}{\\partial t^2} \\left( f \\left( \\boldsymbol{y}, t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\) はテキストでは計算されてゐないので、確認しておく:

  \\( u(t) = t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\) とおく。ライプニッツ則より、

  $$
  \\begin{align*}
  & \\phantom{=} \\frac{\\partial^2}{\\partial t^2} \\left( f \\left( \\boldsymbol{y}, t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\\\
  &           =  \\frac{\\partial^2}{\\partial t^2} \\left( f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\\\
  &           =  \\frac{\\partial^2}{\\partial t^2} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} + 2 \\frac{\\partial}{\\partial t} f(\\boldsymbol{y}, u) \\frac{\\partial}{\\partial t} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} + f(\\boldsymbol{y}, u) \\frac{\\partial^2}{\\partial t^2} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
  \\end{align*}
  $$

  \\( \\frac{\\partial}{\\partial t} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} = 0 \\) なので、

  $$
  = \\frac{\\partial^2}{\\partial t^2} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|}
  $$

  連鎖律とライプニッツ則より、\\( \\frac{d^2}{d x^2} f(g(x)) = \\frac{d}{dx} \\frac{d}{dg} f(g(x)) \\frac{d}{dx} g(x) + \\frac{d}{dg} f(g(x)) \\frac{d^2}{d x^2} g(x) \\) なので、

  $$
  = \\left( \\frac{\\partial}{\\partial t} \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{\\partial}{\\partial t} u(t) + \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{\\partial^2}{\\partial t^2} u(t) \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
  $$

  \\( \\frac{\\partial}{\\partial t} u(t) = 1 \\) なので、

  $$
  = \\frac{\\partial}{\\partial t} \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
  $$

  \\( \\frac{\\partial}{\\partial t} \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\) と \\( \\frac{\\partial}{\\partial u} \\frac{\\partial}{\\partial t} f(\\boldsymbol{y}, u) \\) が共に連続だと仮定する[^4]と、

  $$
  \\begin{align*}
  & = \\frac{\\partial}{\\partial u} \\frac{\\partial}{\\partial t} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
  & = \\frac{\\partial}{\\partial u} \\left( \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{\\partial}{\\partial t} u(t) \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
  \\end{align*}
  $$

  \\( \\frac{\\partial}{\\partial t} u(t) = 1 \\) なので、

  $$
  = \\frac{\\partial^2}{\\partial u^2} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
  $$

  よって、\\( -\\frac{1}{c^2} \\frac{\\partial^2}{\\partial t^2} \\left( f \\left( \\boldsymbol{y}, t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\) における \\( \\frac{\\partial^2}{\\partial u^2} f(\\boldsymbol{y}, u) \\) の項の係数は \\( -\\frac{1}{c^2} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\) となる。

{#- TODO:
 # pp. 76–77 の補足
 # 問題 1.30 のスカラー場 f の可視化
-#}
