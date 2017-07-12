---
layout: post
lang: ja
tags: exercise fpinscala scala functional
title: fpinscala 第2章の練習問題を解いた
---

[『Scala関数型デザイン&amp;プログラミング ―Scalazコントリビューターによる関数型徹底ガイド』](https://www.amazon.co.jp/dp/4844337769)第2章の練習問題を解きました。

<aside class="note">
この記事には、『Scala関数型デザイン&amp;プログラミング ―Scalazコントリビューターによる関数型徹底ガイド』の練習問題の解答が含まれてゐます。ご注意下さい。なほ、この本の練習問題の解答は、本には収録されてゐませんが、著者の GitHub リポジトリ <a href="https://github.com/fpinscala/fpinscala">fpinscala/fpinscala</a> で公開されてゐます。
</aside>

## 練習問題 2.1

> {% katex %} n {% endkatex %} 番目のフィボナッチ数を取得する再帰関数を記述せよ。最初の2つのフィボナッチ数は {% katex %} 0 {% endkatex %} と {% katex %} 1 {% endkatex %} である。 {% katex %} n {% endkatex %} 番目の数字は常に前の2つの数字の合計となる。この数列は {% katex %} 0, 1, 1, 2, 3, 5 {% endkatex %} のように始まる。再帰関数の定義では、ローカルな末尾再帰関数を使用すること。
>
> ``` scala
> def fib(n: Int): Int
> ```

トリボナッチ数とかリュカ数とかに対応できるやうに書きました。:

{% highlight scala linenos %}
def fib(n: Int): Int = {
  @annotation.tailrec
  def go(n: Int, as: Seq[Int]): Int = {
    n match {
      case 0 => as.head
      case _ => go(n - 1, as.tail :+ as.sum)
    }
  }
  go(n, Seq(0, 1))
}
{% endhighlight %}

## 練習問題 2.2

> 指定された比較関数に従って `Array[A]` がソートされているかどうかを調べる `isSorted` を実装せよ。
>
> ``` scala
> def isSorted[A](as: Array[A], ordered: (A,A) => Boolean): Boolean
> ```

{% highlight scala linenos %}
def isSorted[A](as: Array[A], ordered: (A, A) => Boolean): Boolean = {
  @annotation.tailrec
  def go(as: Array[A]): Boolean = {
    if (as.length <= 1) true
    else if (!ordered(as(0), as(1))) false
    else go(as.tail)
  }
  go(as)
}
{% endhighlight %}

## 練習問題 2.3

> カリー化 <span lang="en">(currying)</span> では、引数2つの関数 `f` が、 `f` を部分的に適用する引数1つの関数に変換される。この場合も、コンパイルできる実装は1つだけである。この実装を記述せよ。
>
> ``` scala
> def curry[A,B,C](f: (A, B) => C): A => (B => C)
> ```

{% highlight scala linenos %}
def curry[A, B, C](f: (A, B) => C): A => (B => C) = {
  a => b => f(a, b)
}
{% endhighlight %}

## 練習問題 2.4

> `curry` による変換を逆向きに行う `uncurry` を実装せよ。 `=>` は右結合であるため、 `A => (B => C)` は `A => B => C` と記述できる。
>
> ``` scala
> def uncurry[A,B,C](f: A => B => C): (A, B) => C
> ```

{% highlight scala linenos %}
def uncurry[A, B, C](f: A => B => C): (A, B) => C = {
  (a, b) => f(a)(b)
}
{% endhighlight %}

## 練習問題 2.5

> 2つの関数を合成する高階関数を実装せよ。
>
> ``` scala
> def compose[A,B,C](f: B => C, g: A => B): A => C
> ```

{% highlight scala linenos %}
def compose[A, B, C](f: B => C, g: A => B): A => C = {
  a => f(g(a))
}
{% endhighlight %}
