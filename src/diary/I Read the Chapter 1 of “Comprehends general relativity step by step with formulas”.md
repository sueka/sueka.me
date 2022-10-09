---
title: 『一般相対性理論を一歩一歩数式で理解する』第1章を読んだ
url: ./i-read-comprehends-general-relativity-1-math.html
date: 2020-10-29
lastmod: 2022-10-09
useKaTeX: true
---

[『一般相対性理論を一歩一歩数式で理解する』](https://www.beret.co.jp/books/detail/638) 第1章（数学の準備）を読んだ。

<small>

  この記事は自分が読み返すときのための覚え書きであって、書籍の内容を要約しようとするものではありません。

</small>

## ベクトル積、積の微分法則、連鎖律

§1 では*ベクトル積*が導入される。反交換法則[^1]と分配法則を含めて、ベクトル積に関する定理もいくつか導入される。

[^1]: テキストでは<q><i>交換法則</i></q>として導入されてゐる。

\\( a \\times a = 0 \\) は反交換法則から直接導ける:

$$
\\begin{aligned}
\\phantom{\\iff}    & a \\times a = -(a \\times a) \\\\
          \\iff     & 2 (a \\times a) = 0 \\\\
          \\implies & a \\times a = 0 \\\\
\\end{aligned}
$$

さらに、内積とベクトル積に関する公式がいくつか導入される。

<small>

  テキストには明記されてゐませんが、この記事では、ベクトル積は実数成分の3次元ベクトル \\( \\mathbb{R}^3 \\) 上の演算と見做します。

</small>

---

§2 では、*積の微分法則*と*連鎖律*が導入され、ベクトル値{函数|かむすう}や多変数函数に拡張される。

積の微分法則が内積に拡張できることを示す。\\( \\boldsymbol{a}(t) = \\begin{pmatrix} x(t) \\\\ y(t) \\\\ z(t) \\end{pmatrix} \\)、\\( \\boldsymbol{b}(t) = \\begin{pmatrix} \\alpha(t) \\\\ \\beta(t) \\\\ \\gamma(t) \\end{pmatrix} \\) とする。このとき、

$$
\\begin{aligned}
(\\boldsymbol{a}(t) \\cdot \\boldsymbol{b}(t))'
  & = \\left( \\begin{pmatrix} x(t) \\\\ y(t) \\\\ z(t) \\end{pmatrix} \\cdot \\begin{pmatrix} \\alpha(t) \\\\ \\beta(t) \\\\ \\gamma(t) \\end{pmatrix} \\right)' \\\\
  & = ( x(t) \\alpha(t) + y(t) \\beta(t) + z(t) \\gamma(t) )' \\\\
  & = \\green{x'(t) \\alpha(t)} \\blue{+ x(t) \\alpha'(t)} \\green{+ y'(t) \\beta(t)} \\blue{+ y(t) \\beta'(t)} \\green{+ z'(t) \\gamma(t)} \\blue{+ z(t) \\gamma'(t)} \\\\
  & = \\green{\\begin{pmatrix} x'(t) \\\\ y'(t) \\\\ z'(t) \\end{pmatrix} \\cdot \\begin{pmatrix} \\alpha(t) \\\\ \\beta(t) \\\\ \\gamma(t) \\end{pmatrix}} \\blue{+ \\begin{pmatrix} x(t) \\\\ y(t) \\\\ z(t) \\end{pmatrix} \\cdot \\begin{pmatrix} \\alpha'(t) \\\\ \\beta'(t) \\\\ \\gamma'(t) \\end{pmatrix}} \\\\
  & = \\boldsymbol{a}'(t) \\cdot \\boldsymbol{b}(t) + \\boldsymbol{a}(t) \\cdot \\boldsymbol{b}'(t) \\\\
\\end{aligned}
$$

---

§3 では、*直交変換*が導入され、直交変換が内積を保存することが示されてゐる。

## 勾配、発散、回転、ラプラシアン

§4 では、*スカラー場*と*ベクトル場*が簡単に紹介されてゐる。

<small>

  函数の微分可能性について、<q>この本では，関数が何回でも微分可能なものしか扱いません</q>と言及されてゐる。

</small>

--- 

§5 では、*勾配*が導入され、2次元スカラー場の勾配がそのスカラー場の傾きの最大値を表すことが示されてゐる。

p.39 の (2) 左図の \\( (a, b) \\) は、直線 \\( l \\) 上で \\( t = 0 \\) の点を指してゐる。

p.40 の数式は、\\( \\nabla f \\left( = \\begin{pmatrix} \\frac{\\partial f}{\\partial x} \\\\[1ex] \\frac{\\partial f}{\\partial y} \\end{pmatrix} \\right) \\) と \\( \\begin{pmatrix} \\cos \\theta \\\\ \\sin \\theta \\end{pmatrix} \\) の内積であることを確認しながら読むと読みやすくなる:

$$
\\begin{aligned}
\\frac{\\partial f}{\\partial x} \\cos \\theta + \\frac{\\partial f}{\\partial y} \\sin \\theta
  & = \\begin{pmatrix} \\frac{\\partial f}{\\partial x} \\\\[1ex] \\frac{\\partial f}{\\partial y} \\end{pmatrix} \\cdot \\begin{pmatrix} \\cos \\theta \\\\
  \\sin \\theta \\end{pmatrix} \\\\
  & = \\left\| \\begin{pmatrix} \\frac{\\partial f}{\\partial x} \\\\[1ex] \\frac{\\partial f}{\\partial y} \\end{pmatrix} \\right\| \\left\| \\begin{pmatrix} \\cos \\theta \\\\ \\sin \\theta \\end{pmatrix} \\right\| \\cos(\\theta - \\alpha) \\\\
  & \\cdots \\\\
\\end{aligned}
$$

---

§6 では、*発散*が導入され、発散が直交座標の取り方によらない値であることが示されてゐる。

p.49 の \\( \\frac{\\partial x}{\\partial x'} = a_1, \\ldots \\) は \\( x = a_1 x' + b_1 y' + c_1 z', \\ldots \\) をそれぞれ \\( x', \\ldots \\) で偏微分すると得られる。

---

§7 では、*回転*が導入され、回転が直交座標の取り方によらない値であることが示されてゐる。節の最後で*ラプラシアン*も導入される。

---

§8 では、*勾配*、*発散*、*回転*、*ラプラシアン*の定義が纏められてゐる。関聯する公式もいくつか導入される。

## ポテンシャル、ベクトルポテンシャル、線積分、面積分

§9 では*スカラーポテンシャル*と*ベクトルポテンシャル*が導入される。

---

§10 では*線積分*が導入される。

<i>弧度法の定義（単位円の円周）をたまに度忘れするので注意したい。</i>

---

§11 では、曲線の接線ベクトルについて復習した後、ベクトル場の線積分が導入される。

また、*スカラー場の勾配であるベクトル場の線積分は、始点と終点が等しければ、経路によらず一定の値である*ことゝ、スカラーポテンシャルの定義より、回転が \\( 0 \\) であるベクトル場はスカラー場の勾配であることから、*回転が \\( 0 \\) であるベクトル場の線積分も同様に、始点と終点が等しければ、経路によらず一定の値である*ことも示されてゐる。

<!-- TODO: pp.76–77 の補足 -->

---

§12 では、空間中の曲面が2つのパラメーターで表せることゝ、曲面を一方のパラメーターで偏微分すると、接ベクトル[^2]が得られることが説明されてゐる。

[^2]: 他方のパラメーターを固定した曲線の接線ベクトルのやうなもの。

接ベクトルを用ゐて、曲面上の領域の面積を得る公式が紹介されてゐる。証明は与へられてゐないが、例題として球面の面積を計算させることで、経験に反さなさゝうなことが確認できる。

<small>

  p.82 以降、いくつかの \\( d \\boldsymbol{S} \\) が \\( dS \\) と書かれてゐる。

</small>

<!-- TODO: 問題 1.30 のスカラー場 f を可視化する -->

---

§13 では、*ベクトル場の面積分*とストークスの定理、ガウスの発散定理が導入される。

p.88 で \\( C_1 \\)、\\( C_2 \\)、\\( C_3 \\) に使はれてゐる \\( x \\)、\\( y \\) はパラメーター。

p.89 の \\( \\int_a^0 A_x \\left( x, b \\left( 1 - \\frac{x}{a} \\right) , 0 \\right) dx + \\int_0^b A_y \\left( a \\left( 1 - \\frac{y}{b} \\right) , y, 0 \\right) dy \\) は pp.72–73 で導入された \\( \\int_C \\boldsymbol{F} \\cdot d \\boldsymbol{r} = \\int_{x(a)}^{x(b)} F_x(x, y) dx + \\int_{y(a)}^{y(b)} F_y(x, y) dy \\) の適用例。

p.89 で法線ベクトルを右ねじの向きに取る理由はよく分からなかった[^3]。後日追記する。

[^3]: これを書いてゐるときは「一貫性があれば十分」と思ってゐる。

さらに、*発散が \\( 0 \\) であるベクトル場の、閉曲線を境界に持つ曲面での面積分は、閉曲線が等しければ、領域によらず一定の値である*ことも示されてゐる。§11 で導入された定理の面積分版。

---

§14 では、公式が2つ導入される。

\\( \\nabla \\cdot \\frac{\\boldsymbol{x} - \\boldsymbol{a}}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} = 0 \\) となる \\( n \\) が \\( 3 \\) 以外にあるかを確認する。左辺の \\( \\nabla \\) を展開すると、

$$
\\begin{aligned}
\\nabla \\cdot \\frac{\\boldsymbol{x} - \\boldsymbol{a}}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n}
  & = \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) + \\frac{\\partial}{\\partial y} \\left( \\frac{y - b}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) + \\frac{\\partial}{\\partial z} \\left( \\frac{z - c}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) \\\\
  & = 0 \\\\
\\end{aligned}
$$

となる。こゝで、\\( \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) \\) は、

$$
\\begin{aligned}
& \\phantom{=} \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{\|\\boldsymbol{x} - \\boldsymbol{a}\|^n} \\right) \\\\
&           =  \\frac{\\partial}{\\partial x} \\left( \\frac{x - a}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2}}} \\right) \\\\
&           =  \\frac{1}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2}}} + (x - a) \\cdot \\left( - \\frac{n}{2} \\right) \\cdot \\frac{1}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2} + 1}} \\cdot 2 (x - a) \\\\
&           =  \\frac{1}{(\|\\boldsymbol{x} - \\boldsymbol{a}\|^2)^{\\frac{n}{2} + 1}} (\|\\boldsymbol{x} - \\boldsymbol{a}\|^2 - n (x - a)^2) \\\\
\\end{aligned}
$$

なので、\\( \\boldsymbol{x} \\ne \\boldsymbol{a} \\) と対称形から

$$
\\begin{aligned}
& \\phantom{\\iff} 3 \|\\boldsymbol{x} - \\boldsymbol{a}\|^2 - n (x - a)^2 - n (y - b)^2 - n (z - c)^2 = 0 \\\\
&           \\iff  n = 3 \\\\
\\end{aligned}
$$

## 波動方程式とポアソン方程式の初歩

§15 では、1次元の*波動方程式*の一般解と3次元の*波動方程式*の解の一つが示されてゐる。

<small>

  テキストには <q>1次</q>、<q>3次</q> と書かれてゐるけれど、これは次数ではない気がする。

</small>

---

§16 では、*ポアソン方程式* \\( \\Delta \\varphi(\\boldsymbol{x}) = -f(\\boldsymbol{x}) \\) の特殊解 \\( \\varphi(\\boldsymbol{x}) = \\frac{1}{4 \\pi} \\int_V \\frac{f(\\boldsymbol{y})}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} d \\boldsymbol{y} \\) と*波動方程式* \\( \\left( \\Delta - \\frac{1}{c^2} \\frac{\\partial^2}{\\partial t^2} \\right) \\varphi(\\boldsymbol{x}, t) = -f(\\boldsymbol{x}, t) \\) の特殊解 \\( \\varphi(\\boldsymbol{x}, t) = \\frac{1}{4 \\pi} \\int_V \\frac{f(\\boldsymbol{y}, t \\plusmn \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c})}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} d \\boldsymbol{y} \\) が示される。（\\( V \\) は \\( \\mathbb{R}^3 \\) 上の領域、\\( \\boldsymbol{x} \\) は \\( V \\) 上の定点、\\( \\boldsymbol{y} \\) は \\( V \\) 上の任意の点。）

p.107 に<q>\\( \\Delta \\left( \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|^{1 - \\alpha}} \\right) \\) の符号が負</q>とあるが、これが負となるには、p.105 で \\( \\alpha \\) を定義するときに \\( 0 < \\alpha < 1 \\) としておく必要がある。\\( \\alpha \\to +0 \\) に飛ばすのはこの後。

p.110 の<q>(1.21) より</q>とある変形では、偏微分の順序が入れ替へられてゐる[^4]。

[^4]: 中扉には、<q>微分と積分の順序も，2変数関数の偏微分の順序も常に交換可能とします</q>とある。

p.111 の \\( \\frac{\\partial^2}{\\partial u^2} f(\\boldsymbol{y}, u) \\) の項の係数に \\( -\\frac{1}{c^2} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\) といふ項があるが、\\( \\frac{\\partial^2}{\\partial t^2} \\left( f \\left( \\boldsymbol{y}, t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\) はテキストでは計算されてゐないので、確認しておく。\\( u(t) = t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\) とおく。\\( (f g)'' = ((f g)')' = (f' g + f g')' = f'' g + 2 f' g' + f g'' \\) より、

$$
\\begin{aligned}
& \\phantom{=} \\frac{\\partial^2}{\\partial t^2} \\left( f \\left( \\boldsymbol{y}, t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\\\
&           =  \\frac{\\partial^2}{\\partial t^2} \\left( f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\\\
&           =  \\frac{\\partial^2}{\\partial t^2} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} + 2 \\frac{\\partial}{\\partial t} f(\\boldsymbol{y}, u) \\frac{\\partial}{\\partial t} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} + f(\\boldsymbol{y}, u) \\frac{\\partial^2}{\\partial tｃ^2} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
\\end{aligned}
$$

\\( \\frac{\\partial}{\\partial t} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} = 0 \\) なので、

$$
= \\frac{\\partial^2}{\\partial t^2} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
$$

\\( \\frac{d^2}{d x^2} f(g(x)) = \\frac{d}{dx} \\frac{d}{dx} f(g(x)) = \\frac{d}{dx} \\left( \\frac{d}{dg} f(g(x)) \\frac{d}{dx} g(x) \\right) = \\frac{d}{dx} \\frac{d}{dg} f(g(x)) \\frac{d}{dx} g(x) + \\frac{d}{dg} f(g(x)) \\frac{d^2}{d x^2} g(x) \\) より、

$$
= \\left( \\frac{\\partial}{\\partial t} \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{\\partial}{\\partial t} u(t) + \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{\\partial^2}{\\partial t^2} u(t) \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
$$

\\( \\frac{\\partial}{\\partial t} u(t) = 1 \\) なので、

$$
= \\frac{\\partial}{\\partial t} \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
$$

\\( \\frac{\\partial}{\\partial t} \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\) と \\( \\frac{\\partial}{\\partial u} \\frac{\\partial}{\\partial t} f(\\boldsymbol{y}, u) \\) が共に連続であると仮定する[^4]と、

$$
= \\frac{\\partial}{\\partial u} \\left( \\frac{\\partial}{\\partial u} f(\\boldsymbol{y}, u) \\frac{\\partial}{\\partial t} u(t) \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
$$

\\( \\frac{\\partial}{\\partial t} u(t) = 1 \\) なので、

$$
= \\frac{\\partial^2}{\\partial u^2} f(\\boldsymbol{y}, u) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\\\
$$

よって、\\( -\\frac{1}{c^2} \\) は定数なので、\\( -\\frac{1}{c^2} \\frac{\\partial^2}{\\partial t^2} \\left( f \\left( \\boldsymbol{y}, t + \\frac{\|\\boldsymbol{y} - \\boldsymbol{x}\|}{c} \\right) \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\right) \\) の \\( \\frac{\\partial^2}{\\partial u^2} f(\\boldsymbol{y}, u) \\) の項の係数は \\( -\\frac{1}{c^2} \\frac{1}{\|\\boldsymbol{y} - \\boldsymbol{x}\|} \\) となる。

## 汎関数と変分法

§17 では、汎函数、変分法および極値函数が導入され、オイラー・ラグランジュの方程式が導出される。

## アインシュタインの縮約記法

§18 では*クロネッカーのデルタ*と*アインシュタインの縮約記法*が導入される。
