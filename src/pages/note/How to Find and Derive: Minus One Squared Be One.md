---
title: \\( (-1)^2 = 1 \\) を発見し、導出する方法
useKaTeX: true
date: 2024-06-21
---

$$
\\gdef\\m1{\\mathrm{T}}
\\gdef\\F{𝔽}
\\gdef\\label#1{\\!\\pod{\\text{\#1}}}
$$

<aside>

  この記事は*色*を使用してゐます。

</aside>

## 前提

<em>関数の右一意性</em>^[集合論では、二項関係 \\( f \\subseteq X \\times Y \\) が左全域かつ*右一意的*なとき、\\( f \\) を \\( X \\) から \\( Y \\) への*関数*と言ふ。]
: \\( f \\) を \\( X \\) から \\( Y \\) への関数とする。任意の \\( x \\in X \\) と任意の \\( y ,\\, y^\\prime \\in Y \\) について、\\( f(x) = y \\) かつ \\( f(x) = y^\\prime \\) ならば、\\( y = y^\\prime \\) である。

加法の単位元
: ある \\( 0 \\in \\F \\) が存在し、任意の \\( a \\in \\F \\) について、\\( a + 0 = 0 + a = a \\) である。

加法の結合法則
: 任意の \\( a ,\\, b ,\\, c \\in \\F \\) について、\\( (a + b) + c = a + (b + c) \\) である。
 
乗法の単位元
: ある \\( 1 \\in \\F \\) が存在し、任意の \\( a \\in \\F \\) について、\\( a \\times 1 = 1 \\times a = a \\) である。

乗法の吸収元^[片側で十分。]
: ある \\( 0 \\in \\F \\) が存在し、任意の \\( a \\in \\F \\) について、\\( a \\times 0 = 0 \\times a = 0 \\) である。

乗法の加法に対する左分配法則
: 任意の \\( a ,\\, b ,\\, c \\in \\F \\) について、\\( a \\times (b + c) = a \\times b + a \\times c \\) である。

乗法の加法に対する右分配法則
: 任意の \\( a ,\\, b ,\\, c \\in \\F \\) について、\\( (a + b) \\times c = a \\times c + b \\times c \\) である。

負の数の表記法
: 正の数 \\( a \\) に対して、\\( a + b = 0 \\) を満たすやうな \\( b \\) を <i>\\( -a \\)</i> と*表記*する。

## 発見

負の数の表記法より、

$$
\\begin{align}
1 + (-1) = 0
\\end{align}
$$

こゝで、「\\( -1 \\)」が単なる*表記*であり、以下の手続きにおいて \\( -1 \\) といふ*値*に依存した計算が行はれないことを明確にするために、\\( \\m1 \\coloneqq -1 \\) とおく。

$$
\\begin{align}
1 + \\m1 = 0 \\tag{1'} \\\\ % TODO: 1 \\prime
\\end{align}
$$

両辺を平方すると、

$$
\\begin{align}
          \\text{} & 1 + \\m1 = 0 \\notag \\\\
\\implies \\text{} & (1 + \\m1)^2 = 0^2 \\\\ 
\\end{align}
$$

左辺について、乗法の加法に対する左分配法則より、

$$
\\begin{align*}
  \\text{} & (1 + \\m1)^2 \\\\
= \\text{} & \\orange{(1 + \\m1)} \\times (\\green{1} + \\blue{\\m1}) \\\\
= \\text{} & \\orange{(1 + \\m1)} \\times \\green{1} + \\orange{(1 + \\m1)} \\times \\blue{\\m1} \\\\
\\end{align*}
$$

乗法の加法に対する右分配法則より、

$$
\\begin{align*}
  \\text{} & 
    \\fcolorbox{orange}{transparent}{$ (\\orange{1} + \\green{\\m1}) \\times \\blue{1} $} + 
    \\fcolorbox{green}{transparent}{$ (\\orange{1} + \\green{\\m1}) \\times \\blue{\\m1} $} \\\\
= \\text{} & 
    \\fcolorbox{orange}{transparent}{$ (\\orange{1} \\times \\blue{1} + \\green{\\m1} \\times \\blue{1}) $} + 
    \\fcolorbox{green}{transparent}{$ (\\orange{1} \\times \\blue{\\m1} + \\green{\\m1} \\times \\blue{\\m1}) $} \\\\
\\end{align*}
$$

\\( 1 \\) は乗法の単位元なので、

$$
\\begin{align*}
  \\text{} & (\\orange{1 \\times 1} + \\green{\\m1 \\times 1}) + (\\blue{1 \\times \\m1} + \\m1 \\times \\m1) \\\\
= \\text{} & (\\orange{1} + \\green{\\m1}) + (\\blue{\\m1} + \\m1 \\times \\m1) \\\\
\\end{align*}
$$

\\( \\label{1'} \\) より、

$$
\\begin{align*}
  \\text{} & \\orange{(1 + \\m1)} + (\\m1 + \\m1 \\times \\m1) \\\\
= \\text{} & \\orange{0} + (\\m1 + \\m1 \\times \\m1) \\\\
\\end{align*}
$$

\\( 0 \\) は加法の単位元なので、

$$
\\begin{align}
  \\text{} & \\orange{0} + (\\m1 + \\m1 \\times \\m1) \\notag \\\\
= \\text{} & \\m1 + \\m1 \\times \\m1 \\\\
\\end{align}
$$

右辺について、\\( 0 \\) は乗法の吸収元なので、

$$
\\begin{align}
0^2 = 0 \\times 0 = 0
\\end{align}
$$

\\( \\label{2} \\)、\\( \\label{3} \\)、\\( \\label{4} \\) より、

$$
\\begin{align*}
      \\text{} & (1 + \\m1)^2 = 0^2 \\\\
\\iff \\text{} & \\m1 + \\m1 \\times \\m1 = 0 \\\\
\\end{align*}
$$

こゝで、両辺に左から \\( 1 \\) を加へると、

$$
\\begin{align}
      \\text{} & \\m1 + \\m1 \\times \\m1 = 0 \\notag \\\\
\\iff \\text{} & \\orange{1} + (\\m1 + \\m1 \\times \\m1) = \\orange{1} + 0 \\\\
\\end{align}
$$

左辺について、加法の結合法則より、

$$
\\begin{align*}
  \\text{} & 1 + \\orange{(}\\m1 + \\m1 \\times \\m1\\orange{)} \\\\
= \\text{} & \\orange{(}1 + \\m1\\orange{)} + \\m1 \\times \\m1 \\\\
\\end{align*}
$$

\\( \\label{1'} \\) より、

$$
\\begin{align*}
  \\text{} & \\orange{(1 + \\m1)} + \\m1 \\times \\m1 \\\\
= \\text{} & \\orange{0} + \\m1 \\times \\m1 \\\\
\\end{align*}
$$

\\( 0 \\) は加法の単位元なので、

$$
\\begin{align}
  \\text{} & \\orange{0} + \\m1 \\times \\m1 \\notag \\\\
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
      \\text{} & 1 + (\\m1 + \\m1 \\times \\m1) = 1 + 0 \\notag \\\\
\\iff \\text{} & \\m1 \\times \\m1 = 1 \\\\
\\end{align}
$$

## 導出

この手順を逆向きに辿ることで、\\( \\m1 \\times \\m1 = 1 \\) を直接導くことができる。すなはち、

$$
\\begin{align*}
  \\text{} & \\m1 \\times \\m1 \\\\
= \\text{} & 0 + \\m1 \\times \\m1 \\\\
= \\text{} & (1 + \\m1) + \\m1 \\times \\m1 \\\\
= \\text{} & 1 + (\\m1 + \\m1 \\times \\m1) \\\\
= \\text{} & 1 + (0 + (\\m1 + \\m1 \\times \\m1)) \\\\
= \\text{} & 1 + ((1 + \\m1) + (\\m1 + \\m1 \\times \\m1)) \\\\
= \\text{} & 1 + ((1 \\times 1 + \\m1 \\times 1) + (1 \\times \\m1 + \\m1 \\times \\m1)) \\\\
= \\text{} & 1 + ((1 + \\m1) \\times 1 + (1 + \\m1) \\times \\m1) \\\\
= \\text{} & 1 + (1 + \\m1) \\times (1 + \\m1) \\\\
= \\text{} & 1 + 0 \\times 0 \\\\
= \\text{} & 1 + 0 \\\\
= \\text{} & 1 \\\\
\\end{align*}
$$
