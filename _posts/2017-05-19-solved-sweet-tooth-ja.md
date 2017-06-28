---
layout: post
title: 「甘いもの好き」を解きました
tags: puzzle p3
lang: ja
---

学生時代に図書館でよく読んでゐた本ですが、[『プログラマのための論理パズル 難題を突破する論理思考トレーニング』](https://www.amazon.co.jp/dp/4274067556)を購入しました。

<aside class="note">
この記事では、『プログラマのための論理パズル 難題を突破する論理思考トレーニング』に収録されてゐるパズル「甘いもの好き」の解答にあたって私が考へたことを記録します。この本には収録されてゐる全てのパズルの解法が含まれてゐるので、いはゆるパズルのネタバレには当たらないと思ひますが、書籍のネタバレには当たりますので、ご注意下さい。
</aside>

## 問題1

ジェレミーの選択権は一回しか無いので、ジェレミーに選択権があるのが何回目かによって、三通りのケーキ配分があると考へました。つまり、1つ目のケーキを {% katex %} f:(1-f) {% endkatex %} 2つ目のケーキを {% katex %} g:(1-g) {% endkatex %} に分けるとすると、

 | ジェレミーの選択権 | ジェレミーの取り分 | マリーの取り分 |
 |:---:|---|---|
 | 1回目 | {% katex display %} f+\frac{1}{2}+\frac{1}{2} {% endkatex %} | {% katex display %} \left(1-f\right)+\frac{1}{2}+\frac{1}{2} {% endkatex %} |
 | 2回目 | {% katex display %} \left(1-f\right)+g+\frac{1}{2} {% endkatex %} | {% katex display %} f+\left(1-g\right)+\frac{1}{2} {% endkatex %} |
 | 3回目 | {% katex display %} \left(1-f\right)+\left(1-g\right)+1 {% endkatex %} | {% katex display %} f+g {% endkatex %} |

といふものです。マリーは、ジェレミーにいつ選択権を与へるかを決めることができるので、三通りの取り分が全て等しくなければ、自分の取り分が多くなるやうにすることができます。よって、ジェレミーにとっての最適戦略は、マリーの三通りの取り分が全て等しくなるやうにすることです。:

{% katex display %}
\begin{aligned}
  & \phantom{\Rightarrow} \left(1-f\right)+\frac{1}{2}+\frac{1}{2} = f+\left(1-g\right)+\frac{1}{2} = f+g \\
  & \Rightarrow f+\left(1-g\right)+\frac{1}{2} = f+g \\
  & \Leftrightarrow g = \frac{3}{4} \\
  \text{and} \\
  & \phantom{\Rightarrow} \left(1-f\right)+\frac{1}{2}+\frac{1}{2} = f+\left(1-g\right)+\frac{1}{2} = f+g \\
  & \Rightarrow \left(1-f\right)+\frac{1}{2}+\frac{1}{2} = f+g \\
  & \Leftrightarrow \left(1-f\right)+\frac{1}{2}+\frac{1}{2} = f+\frac{3}{4} \\
  & \Leftrightarrow f = \frac{5}{8} \\
\end{aligned}
{% endkatex %}

## 問題2

[問題1](#問題1)と同様に考へました。本で紹介されてゐる解法の方が綺麗です。1つ目のケーキを {% katex %} f:(1-f) {% endkatex %} ……6つ目のケーキを {% katex %} k:(1-k) {% endkatex %} に分けるとすると、ジェレミーの選択権の位置とケーキ配分の関係は

 | ジェレミーの選択権 | ジェレミーの取り分 | マリーの取り分 |
 |:---:|---|---|
 | 1回目 | {% katex display %} f+6 \frac{1}{2} {% endkatex %} | {% katex display %} 1-f+6 \frac{1}{2} {% endkatex %} |
 | 2回目 | {% katex display %} 1-\left(f\right)+g+5 \frac{1}{2} {% endkatex %} | {% katex display %} 1+\left(f\right)-g+5 \frac{1}{2} {% endkatex %} |
 | 3回目 | {% katex display %} 2-\left(f+g\right)+h+4 \frac{1}{2} {% endkatex %} | {% katex display %} 1+\left(f+g\right)-h+4 \frac{1}{2} {% endkatex %} |
 | 4回目 | {% katex display %} 3-\left(f+g+h\right)+i+3 \frac{1}{2} {% endkatex %} | {% katex display %} 1+\left(f+g+h\right)-i+3 \frac{1}{2} {% endkatex %} |
 | 5回目 | {% katex display %} 4-\left(f+g+h+i\right)+j+2 \frac{1}{2} {% endkatex %} | {% katex display %} 1+\left(f+g+h+i\right)-j+2 \frac{1}{2} {% endkatex %} |
 | 6回目 | {% katex display %} 5-\left(f+g+h+i+j\right)+k+\frac{1}{2} {% endkatex %} | {% katex display %} 1+\left(f+g+h+i+j\right)-k+\frac{1}{2} {% endkatex %} |
 | 7回目 | {% katex display %} 7-\left(f+g+h+i+j+k\right) {% endkatex %} | {% katex display %} \left(f+g+h+i+j+k\right) {% endkatex %} |

となり、

{% katex display %}
\begin{aligned}
  & \phantom{=} 1-f+6 \frac{1}{2} \\
  & = 1+\left(f\right)-g+5 \frac{1}{2} \\
  & = 1+\left(f+g\right)-h+4 \frac{1}{2} \\
  & = 1+\left(f+g+h\right)-i+3 \frac{1}{2} \\
  & = 1+\left(f+g+h+i\right)-j+2 \frac{1}{2} \\
  & = 1+\left(f+g+h+i+j\right)-k+\frac{1}{2} \\
  & = \left(f+g+h+i+j+k\right) \\
\end{aligned}
{% endkatex %}

を解けば、 {% katex %} \left(f, g, h, i, j, k\right)=\left(\frac{65}{128}, \frac{33}{64}, \frac{17}{32}, \frac{9}{16}, \frac{5}{8}, \frac{3}{4}\right) {% endkatex %} が得られます。

## 問題3

省略します。
