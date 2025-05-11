---
title: \\( (-1)^2 = 1 \\) を発見し、直接導く方法
useKaTeX: true
date: '2024-06-21'
lastmod: '2024-06-25'
templateEngine: null
---
<aside>

  この記事は*色*を使用しています。

</aside>

$$
\\gdef\\qed{∎}
\\gdef\\m1{\\mathrm{T}}
\\gdef\\F{𝔽}
\\gdef\\label#1{\\!\\pod{\\text{\#1}}}
$$
{.display-none}

## 前提

<em>関数の右一意性</em>
: \\( f \\) を \\( X \\) から \\( Y \\) への関数とする。任意の \\( x \\in X \\) と任意の \\( y, y^\\prime \\in Y \\) について、\\( f(x) = y \\) かつ \\( f(x) = y^\\prime \\) ならば、\\( y = y^\\prime \\) である。

加法に関する単位元[^add-id-unique]
: ある \\( 0 \\in \\F \\) が存在し、任意の \\( a \\in \\F \\) について、\\( a + 0 = 0 + a = a \\) である。

加法の結合法則
: 任意の \\( a, b, c \\in \\F \\) について、\\( (a + b) + c = a + (b + c) \\) である。
 
乗法に関する右単位元
: ある \\( 1 \\in \\F \\) が存在し、任意の \\( a \\in \\F \\) について、\\( a \\times 1 = a \\) である。

乗法に関する右吸収元
: ある \\( 0 \\in \\F \\) が存在し、任意の \\( a \\in \\F \\) について、\\( a \\times 0 = 0 \\) である。

乗法の加法に対する左分配法則
: 任意の \\( a, b, c \\in \\F \\) について、\\( a \\times (b + c) = a \\times b + a \\times c \\) である。

負の数の表記法
: 正の数 \\( a \\) に対して、\\( a + b = 0 \\) を満たすやうな \\( b \\) を <i>\\( -a \\)</i> と*表記*する。

[^add-id-unique]:
    単位元の一意性を示す。\\( e_1, e_2 \\in \\F \\) を単位元とする。このとき、

    $$
    \\begin{align}
    & \\forall a \\in \\F, a + e_1 = e_1 + a = a \\\\
    & \\forall a \\in \\F, a + e_2 = e_2 + a = a \\\\
    \\end{align}
    $$

    \\( e_2 \\isin \\F \\) と \\( \\label{9} \\) から、

    $$
    \\begin{align*}
    & e_2 + e_1 = e_1 + e_2 = e_2 \\\\
    \\end{align*}
    $$

    \\( e_1 \\isin \\F \\) と \\( \\label{10} \\) から、

    $$
    \\begin{align*}
    & e_1 + e_2 = e_2 + e_1 = e_1 \\\\
    \\end{align*}
    $$

    よって、\\( e_1 = e_2 \\) である。\\( \\qed \\)

## 発見

\\( -1 \\) を項として含む等式で、最も単純なものを考へる。負の数の表記法より、

$$
\\begin{align}
1 + (-1) = 0
\\end{align}
$$

「\\( -1 \\)」が単なる*表記*であることゝ、以下の手続きを通して、\\( -1 \\) といふ*値*に依存した計算が行はれないことを明確にするために、\\( \\m1 \\coloneqq -1 \\) とおく。

$$
\\begin{align}
1 + \\m1 = 0 \\tag{1'} \\\\ % TODO: 1 \\prime
\\end{align}
$$

\\( \\m1^2 \\) の項を作るために、両辺を \\( \\m1 \\) 倍する^[\\( \\m1 \\ne 0 \\) なので、関数 \\( f(x) \\coloneqq \\m1 \\times x \\) は単射であり、逆関数 \\( f^{-1} \\) も関数である。]。こゝでは左から掛けよう。

$$
\\begin{align}
               & 1 + \\m1 = 0 \\notag \\\\
\\iff \\text{} & \\m1 \\times (1 + \\m1) = \\m1 \\times 0 \\\\ 
\\end{align}
$$

左辺について、乗法の加法に対する左分配法則より、

$$
\\begin{align*}
           & \\orange{\\m1} \\times (\\green{1} + \\blue{\\m1}) \\\\
= \\text{} & \\orange{\\m1} \\times \\green{1} + \\orange{\\m1} \\times \\blue{\\m1} \\\\
\\end{align*}
$$

\\( 1 \\) は乗法の右単位元なので、

$$
\\begin{align}
           & \\orange{\\m1 \\times 1} + \\m1 \\times \\m1 \\notag \\\\
= \\text{} & \\orange{\\m1} + \\m1 \\times \\m1 \\\\
\\end{align}
$$

右辺について、\\( 0 \\) は乗法の右吸収元なので、

$$
\\begin{align}
\\m1 \\times 0 = 0
\\end{align}
$$

\\( \\label{2} \\)、\\( \\label{3} \\)、\\( \\label{4} \\) より、

$$
\\begin{align*}
               & \\m1 \\times (1 + \\m1) = \\m1 \\times 0 \\\\
\\iff \\text{} & \\m1 + \\m1 \\times \\m1 = 0 \\\\
\\end{align*}
$$

こゝで、左辺の \\( \\m1 \\) の項を消去するために、両辺に左から \\( 1 \\) を加へる。

$$
\\begin{align}
               & \\m1 + \\m1 \\times \\m1 = 0 \\notag \\\\
\\iff \\text{} & \\orange{1} + (\\m1 + \\m1 \\times \\m1) = \\orange{1} + 0 \\\\
\\end{align}
$$

左辺について、加法の結合法則より、

$$
\\begin{align*}
           & 1 + \\orange{(}\\m1 + \\m1 \\times \\m1\\orange{)} \\\\
= \\text{} & \\orange{(}1 + \\m1\\orange{)} + \\m1 \\times \\m1 \\\\
\\end{align*}
$$

\\( \\label{1'} \\) より、

$$
\\begin{align*}
           & \\orange{(1 + \\m1)} + \\m1 \\times \\m1 \\\\
= \\text{} & \\orange{0} + \\m1 \\times \\m1 \\\\
\\end{align*}
$$

\\( 0 \\) は加法の単位元なので、

$$
\\begin{align}
           & \\orange{0} + \\m1 \\times \\m1 \\notag \\\\
= \\text{} & \\m1 \\times \\m1 \\\\
\\end{align}
$$

右辺について、\\( 0 \\) は加法の単位元なので、

$$
\\begin{align}
1 + 0 = 1
\\end{align}
$$

\\( \\label{5} \\)、\\( \\label{6} \\)、\\( \\label{7} \\) より、

$$
\\begin{align}
               & 1 + (\\m1 + \\m1 \\times \\m1) = 1 + 0 \\notag \\\\
\\iff \\text{} & \\m1 \\times \\m1 = 1 \\\\
\\end{align}
$$

## 導出

この手順を逆向きに辿ることで、\\( (-1) \\times (-1) = 1 \\) を直接導くことができる。すなはち、

$$
\\begin{align*}
           & \\m1 \\times \\m1 \\\\
= \\text{} & 0 + \\m1 \\times \\m1 \\\\
= \\text{} & (1 + \\m1) + \\m1 \\times \\m1 \\\\
= \\text{} & 1 + (\\m1 + \\m1 \\times \\m1) \\\\
= \\text{} & 1 + (\\m1 \\times 1 + \\m1 \\times \\m1) \\\\
= \\text{} & 1 + \\m1 \\times (1 + \\m1) \\\\
= \\text{} & 1 + \\m1 \\times 0 \\\\
= \\text{} & 1 + 0 \\\\
= \\text{} & 1 \\\\
\\end{align*}
$$
