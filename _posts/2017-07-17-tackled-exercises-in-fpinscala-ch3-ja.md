---
layout: post
lang: ja
tags: exercise fpinscala scala functional
title: fpinscala 第3章の練習問題を解いた
---

[『 Scala 関数型デザイン&amp;プログラミング ― Scalaz コントリビューターによる関数型徹底ガイド』](https://www.amazon.co.jp/dp/4844337769)第3章「関数型プログラミングのデータ構造」の練習問題を解きました。

<aside class="note">
この記事には、『 Scala 関数型デザイン&amp;プログラミング ― Scalaz コントリビューターによる関数型徹底ガイド』の練習問題の解答が含まれてゐます。ご注意下さい。なほ、この本の練習問題の解答は、本には収録されてゐませんが、著者の GitHub リポジトリ <a href="https://github.com/fpinscala/fpinscala">fpinscala/fpinscala</a> で公開されてゐます。
</aside>

## 練習問題 3.1

> 以下のマッチ式はどのような結果になるか。
>
> ``` scala
> val x = List(1,2,3,4,5) match {
>   case Cons(x, Cons(2, Cons(4, _))) => x
>   case Nil => 42
>   case Cons(x, Cons(y, Cons(3, Cons(4, _)))) => x + y
>   case Cons(h, t) => h + sum(t)
>   case _ => 101
> }
> ```

`List(1,2,3,4,5)` をデータコンストラクターで書き換へると `Cons(1, Cons(2, Cons(3, Cons(4, Cons(5, Nil)))))` となり、これにマッチするパターンは3番目の `Cons(x, Cons(y, Cons(3, Cons(4, _))))` なので、このマッチ式の結果値 `x` は `3` です。

## 練習問題 3.2

> `List` の最初の要素を削除する関数 `tail` を実装せよ。この関数の実行時間が一定であることに注意。 `List` が `Nil` である場合、実装上の選択肢として他に何があるか。この質問については、次章で再び取り上げる。

問題の直前に<q>この関数と、ここで記述する他の関数は、 `List` コンパニオンオブジェクトの中で記述できます。</q>とあるので、そのやうに実装します。:

{% highlight scala linenos %}
def tail(xs: List[_]) = xs match {
  case Cons(_, ys) => ys
  case Nil => Nil
}
{% endhighlight %}

`Nil` の場合の選択肢としては `Unit` 値を返す, `@annotation.unchecked` アノテーションを使ふ, Maybe モナドや Either モナドを使ふなどの方法が考へられますが、この点は次章で勉強したいです。

## 練習問題 3.3

> EXERCISE 3.2 と同じ考え方に基づいて、 `List` の最初の要素を別の値と置き換える `setHead` 関数を実装せよ。

{% highlight scala linenos %}
def setHead[A](a: A, as: List[A]) = as match {
  case Cons(x, xs) => Cons(a, xs)
  case Nil => Nil
}
{% endhighlight %}

## 練習問題 3.4

> `tail` を一般化して、リストの先頭から `n` 個の要素を削除する `drop` という関数に書き換えよ。この関数の実行時間は削除する要素の数にのみ比例することに注意。 `List` 全体のコピーを作成する必要はない。
>
> ``` scala
> def drop[A](l: List[A], n: Int): List[A]
> ```

{% highlight scala linenos %}
@annotation.tailrec
def drop[A](as: List[A], n: Int): List[A] = {
  if (n == 0) as
  else as match {
    case Cons(_, xs) => drop(xs, n - 1)
    case Nil => Nil
  }
}
{% endhighlight %}

## 練習問題 3.5

> 述語とマッチする場合に限り、 `List` からその要素までの要素を削除する `dropWhile` を実装せよ。
>
> ``` scala
> def dropWhile[A](l: List[A], f: A => Boolean): List[A]
> ```

{% highlight scala linenos %}
@annotation.tailrec
def dropWhile[A](as: List[A], pred: A => Boolean): List[A] = as match {
  case Cons(x, xs) if pred(x) => dropWhile(xs, pred)
  case _ => as
}
{% endhighlight %}

`as` に `Nil` を渡す場合は型アノテーションを付けた方が良いです。

## 練習問題 3.6

> すべてがこのようにうまくいくわけではない。 `List` の末尾を除くすべての要素で構成された `List` を返す `init` 関数を実装せよ。 `List(1,2,3,4)` が与えられた場合、 `init` は `List(1,2,3)` を返す。この関数を `tail` のように一定時間で実装できないのはなぜか。
>
> ``` scala
> def init[A](l: List[A]): List[A]
> ```

{% highlight scala linenos %}
@annotation.tailrec
def init[A](as: List[A]): List[A] = as match {
  case Cons(_, Nil) => Nil
  case Cons(x, xs) => init(x, init(xs))
}
{% endhighlight %}

`init` が一定時間で実装できない理由は次の通りです。すなはち、 `List(1, 2, 3)` から `List(1, 2)` を構築する場合、 `Cons(1, Cons(2, Cons(3, Nil)))` の `Cons(3, Nil)` を `Nil` で置き換へることになりますが、 `Cons(2, Cons(3, Nil))` に対してこの操作をするには `2` をコピーしなければならず、 `init` は、これを要素数とほゞ同じ回数繰り返さなければならないからです。

## 練習問題 3.7

> `foldRight` を使って実装された `product` は、 `0.0` を検出した場合に、直ちに再帰を中止して `0.0` を返せるか。その理由を説明せよ。大きなリストで `foldRight` を呼び出した場合の短絡の仕組みについて検討せよ。この問題は奥が深いため、第5章で改めて取り上げる。

`List(2.0, 0.0, 3.0, 4.0)` を `_ * _` で畳み込む場合、置換モデルによって、その計算過程を次のやうに推測できます。（こゝで `foldRight` の畳み込み関数を `acc` と書きます。）:

``` scala
foldRight(List(2.0, 0.0, 3.0, 4.0), 1.0)(_ * _)
foldRight(Cons(2.0, Cons(0.0, Cons(3.0, Cons(4.0, Nil)))), 1.0)(_ * _)
2.0 * foldRight(Cons(0.0, Cons(3.0, Cons(4.0, Nil))), 1.0)(_ * _)
2.0 * acc(0.0, foldRight(Cons(3.0, Cons(4.0, Nil)), 1.0)(_ * _))
```

遅延評価戦略を使ふ言語であれば、こゝで `acc` が `0.0` を返すかもしれませんが、 Scala の評価戦略は正格評価なので、 `acc` を評価するときに、全ての実引数が評価されます。そのため、 `foldRight` を使って実装された `product` は、 `0.0` を検出しても再帰を中止することはできません。といふのが模範解答だと思ひますが、 `0.0 * Double.PositiveInfinity` は `NaN` なので……。

## 練習問題 3.8

> `foldRight(List(1,2,3), Nil:List[Int])(Cons(_,_))` のように、 `Nil` および `Cons` 自体を `foldRight` に渡した場合はどうなるか。これが `foldRight` と `List` のデータコンストラクタとの関係について何を表していると思うか。

与へられた式の結果を置換モデルで推測すると、

``` scala
foldRight(List(1, 2, 3), Nil: List[Int])(Cons(_, _))
Cons(1, foldRight(List(2, 3), Nil: List[Int])(Cons(_, _)))
Cons(1, Cons(2, foldRight(List(3), Nil: List[Int])(Cons(_, _))))
Cons(1, Cons(2, Cons(3, foldRight(Nil, Nil: List[Int])(Cons(_, _)))))
Cons(1, Cons(2, Cons(3, Nil)))
```

となり、元の `List` が再構築されます。

## 練習問題 3.9

> `foldRight` を使ってリストの長さを計算せよ。
>
> ``` scala
> def length[A](as: List[A]): Int
> ```

{% highlight scala linenos %}
def length[A](as: List[A]) = foldRight(as, 0)((_, res) => res + 1)
{% endhighlight %}

## 練習問題 3.10

> この `foldRight` の実装は末尾再帰ではなく、リストが大きい場合は `StackOverflowError` になってしまう。これを**スタックセーフ**ではないと言う。そうした状況であると仮定し、前章で説明した手法を使って、リスト再帰の総称関数 `foldLeft` を記述せよ。シグネチャは以下のとおり。
>
> ``` scala
> def foldLeft[A,B](as: List[A], z: B)(f: (B, A) => B): B
> ```

{% highlight scala linenos %}
@annotation.tailrec
def foldLeft[A, B](as: List[A], z: B)(acc: (B, A) => B): B = as match {
  case Nil => z
  case Cons(x, xs) => foldLeft(xs, acc(z, x))(acc)
}
{% endhighlight %}

## 練習問題 3.11

> `foldLeft` を使って `sum` 、 `product` 、およびリストの長さを計算する関数を記述せよ。

{% highlight scala linenos %}
def sum(xs: List[Int]) = foldLeft(xs, 0)(_ + _)
def product(xs: List[Double]) = foldLeft(xs, 1.0)(_ * _)
def length[A](as: List[A]) = foldLeft(as, 0)((res, _) => res + 1)
{% endhighlight %}

## 練習問題 3.12

> 要素が逆に並んだリストを返す関数を記述せよ。 `List(1,2,3)` が与えられた場合、この関数は `List(3,2,1)` を返す。畳み込みを使って記述できるかどうかを確認すること。

`foldLeft` を使って[練習問題 3.8](#練習問題-38)と同じことをすると、要素が逆順になります。:

{% highlight scala linenos %}
def reverse[A](as: List[A]) =
  foldLeft(as, Nil: List[A])((res, a) => Cons(a, res))
{% endhighlight %}

試しに `reverse(List(1, 2, 3))` の結果を置換モデルで推測してみます。:

``` scala
reverse(List(1, 2, 3))
foldLeft(List(1, 2, 3), Nil: List[Int])((res, x) => Cons(x, res))
foldLeft(List(2, 3), Cons(1, Nil))((res, x) => Cons(x, res))
foldLeft(List(3), Cons(2, Cons(1, Nil)))((res, x) => Cons(x, res))
foldLeft(Nil, Cons(3, Cons(2, Cons(1, Nil))))((res, x) => Cons(x, res))
Cons(3, Cons(2, Cons(1, Nil)))
```

## 練習問題 3.13

> **難問**: `foldRight` をベースとして `foldLeft` を記述することは可能か。その逆はどうか。 `foldLeft` を使って `foldRight` を実装すると、 `foldRight` を末尾再帰的に実装することが可能となり、大きなリストでもスタックオーバーフローが発生しなくなるので便利である。

後者は簡単です。[練習問題 3.12](#練習問題-312)で見たやうに、 `foldLeft` は `reverse` を実装することができるので、逆順にしてから左から畳み込めば、右から畳み込んだのと同じ結果が得られます。:

{% highlight scala linenos %}
def reverse[A](as: List[A]) =
  foldLeft(as, Nil: List[A])((res, a) => Cons(a, res))
def foldRight[A, B](as: List[A], z: B)(acc: (A, B) => B): B =
  foldLeft(reverse(as), z)(acc)
{% endhighlight %}

前者の手抜きな方法として、末尾に要素を追加する関数を畳み込み関数とすることで `reverse` を実装するといふ方法があります。:

{% highlight scala linenos %}
def push[A](as: List[A], a: A) = foldRight(as, Cons(a, Nil))(Cons(_, _))
def reverse[A](as: List[A]) =
  foldRight(as, Nil: List[A])((a, res) => push(res, a))
def foldLeft[A, B](as: List[A], z: B)(acc: (B, A) => B): B =
  foldRight(reverse(as), z)((a, res) => acc(res, a))
{% endhighlight %}

この問題にはより綺麗な解法があります。それは、評価を遅延させ、 `foldLeft` や `foldRight` が畳み込みの結果を返す関数を返すやうにするといふものです。この方法を使へば、この問題の解答は次のやうになります。:

{% highlight scala linenos %}
def foldLeft[A, B](as: List[A], z: B)(acc: (B, A) => B): B =
  foldRight(as, (res: B) => res)((a, lazyRes) => res => lazyRes(acc(res, a)))(z)
def foldRight[A, B](as: List[A], z: B)(acc: (A, B) => B): B =
  foldLeft(as, (res: B) => res)((lazyRes, a) => res => lazyRes(acc(a, res)))(z)
{% endhighlight %}

なほ、こゝで実装した `foldLeft` や `foldRight` は、実装の方法を区別してゐません。

## 練習問題 3.14

> `foldLeft` または `foldRight` をベースとして `append` を実装せよ。

{% highlight scala linenos %}
def append[A](as1: List[A], as2: List[A]): List[A] =
  foldRight(as1, as2)(Cons(_, _))
{% endhighlight %}

## 練習問題 3.15

> **難問**: 複数のリストからなるリストを1つのリストとして連結する関数を記述せよ。この関数の実行時間はすべてのリストの長さの合計に対して線形になるはずである。すでに定義した関数を使ってみること。

{% highlight scala linenos %}
def flatten[A](ass: List[List[A]]) = foldRight(ass, Nil: List[A])(append)
{% endhighlight %}

## 練習問題 3.16

> 各要素に {% katex %} 1 {% endkatex %} を足すことで整数のリストを変換する関数を記述せよ。注意: これは新しい `List` を返す純粋関数になるはずである。

{% highlight scala linenos %}
def succ(xs: List[Int]) =
  foldRight(xs, Nil: List[Int])((x, res) => Cons(x + 1, res))
{% endhighlight %}

## 練習問題 3.17

> `List[Double]` の各値を `String` に変換する関数を記述せよ。 `d.toString` という式を使って `d:Double` を `String` に変換できる。

{% highlight scala linenos %}
def stringifyAll(xs: List[Double]) =
  foldRight(xs, Nil: List[String])((x, res) => Cons(x.toString, res))
{% endhighlight %}

## 練習問題 3.18

> リストの各要素を変更し、かつリストの構造をそのまま保つ総称関数 `map` を記述せよ。この関数のシグネチャは以下のとおり。
>
> ``` scala
> def map[A,B](as: List[A])(f: A => B): List[B]
> ```

{% highlight scala linenos %}
def map[A, B](as: List[A])(f: A => B) =
  foldRight(as, Nil: List[B])((a, res) => Cons(f(a), res))
{% endhighlight %}

## 練習問題 3.19

> 与えられた述語条件が満たされるまでリストから要素を削除する `filter` 関数を記述せよ。この関数を使って `List[Int]` から奇数をすべて削除せよ。
>
> ``` scala
> def filter[A](as: List[A])(f: A => Boolean): List[A]
> ```

問題文が誤訳されてゐるので `filter` を知らなければ解けないかもしれません。

{% highlight scala linenos %}
def filter[A](as: List[A])(pred: A => Boolean) =
  foldRight(as, Nil: List[A])((a, res) => if (pred(a)) Cons(a, res) else res)
{% endhighlight %}

奇数を削除するには次のやうにします。:

{% highlight scala linenos %}
filter(List(0, 1, 1, 2, 3, 5, 8))(_ % 2 == 0)
{% endhighlight %}

## 練習問題 3.20

> `map` と同じような働きをする `flatMap` 関数を記述せよ。この関数は単一の結果ではなくリストを返し、そのリストは最終的な結果のリストに挿入されなければならない。この関数のシグネチャは以下のとおり。
>
> ``` scala
> def flatMap[A,B](as: List[A])(f: A => List[B]): List[B]
> ```

{% highlight scala linenos %}
def flatMap[A, B](as: List[A])(f: A => List[B]) = flatten(map(as)(f))
{% endhighlight %}

## 練習問題 3.21

> `flatMap` を使って `filter` を実装せよ。

{% highlight scala linenos %}
def filter[A](as: List[A])(pred: A => Boolean) =
  flatMap(as)(a => if (pred(a)) List(a) else Nil)
{% endhighlight %}

## 練習問題 3.22

> リストを2つ受け取り、対応する要素どうしを足し合わせて新しいリストを生成する関数を記述せよ。たとえば `List(1,2,3)` と `List(4,5,6)` は `List(5,7,9)` になる。

{% highlight scala linenos %}
def listSum(xs1: List[Int], xs2: List[Int]): List[Int] = (xs1, xs2) match {
  case (Nil, _) => Nil
  case (_, Nil) => Nil
  case (Cons(y1, ys1), Cons(y2, ys2)) => Cons(y1 + y2, listSum(ys1, ys2))
}
{% endhighlight %}

## 練習問題 3.23

> EXERCISE 3.22 で作成した関数を、整数または加算に限定されないように一般化せよ。一般化された関数には `zipWith` という名前を付けること。

{% highlight scala linenos %}
def zipWith[A, B, C](as: List[A], bs: List[B])(f: (A, B) => C): List[C] = (as, bs) match {
  case (Nil, _) => Nil
  case (_, Nil) => Nil
  case (Cons(x, xs), Cons(y, ys)) => Cons(f(x, y), zipWith(xs, ys))
}
{% endhighlight %}

## 練習問題 3.24

> **難問**: 例として、 `List` に別の `List` がサブシーケンスとして含まれているかどうかを調べる `hasSubsequence` を実装せよ。たとえば `List(1,2,3,4)` には `List(1,2)` 、 `List(2,3)` 、 `List(4)` などがサブシーケンスとして含まれている。純粋関数型で、コンパクトで、かつ効率的な実装を見つけ出すのは難しいかもしれない。その場合は、それでかまわない。どのようなものであれ、最も自然な関数を実装すること。この実装については、第5章で改めて取り上げ、改良する予定である。なお Scala では、任意の値 `x` および `y` に対し、 `x == y` という式を使って等しいかどうかを比較できる。
>
> ``` scala
> def hasSubsequence[A](sup: List[A], sub: List[A]): Boolean
> ```

この問題の直前で Scala 標準ライブラリの `List` について言及され、いくつかのメソッドが紹介されてゐるので、以後の回答では、本で実装してゐる `List` ではなく、標準ライブラリの `List` を使ひます。

{% highlight scala linenos %}
@annotation.tailrec
def startWith[A](as: List[A], subAs: List[A]): Boolean = (as, subAs) match {
  case (_, Nil) => true
  case (x :: xs, subX :: subXs) if (x == subX) => startWith(xs, subXs)
  case _ => false
}

def hasSubsequence[A](as: List[A], subAs: List[A]): Boolean = {
  as.scanRight(List.empty[A])(_ :: _).exists(as => startWith(as, subAs))
}
{% endhighlight %}

## 練習問題 3.25

> 2分木のノード（ `Leaf` と `Branch` ）の数を数える `size` 関数を記述せよ。

{% highlight scala linenos %}
def size[A](tree: Tree[A]) = tree match {
  case Leaf(_) => 1
  case Branch(l, r) => size(l) + size(r)
}
{% endhighlight %}

## 練習問題 3.26

> `Tree[Int]` の最大の要素を返す `maximum` 関数を記述せよ。なお Scala では、 `x.max(y)` または `x max y` を使って2つの整数 `x` と `y` の最大値を計算できる。

{% highlight scala linenos %}
def maximum(tree: Tree[Int]) = tree match {
  case Leaf(v) => v
  case Branch(l, r) => maximum(l) max maximum(r)
}
{% endhighlight %}

## 練習問題 3.27

> 2分木のルートから任意の `Leaf` までの最長パスを返す `depth` 関数を記述せよ。

{% highlight scala linenos %}
def depth[A](tree: Tree[A]) = tree match {
  case Leaf(_) => 0
  case Branch(l, r) => (depth(l) max depth(r)) + 1
}
{% endhighlight %}

## 練習問題 3.28

> 2分木の各要素を特定の関数を使って変更する `map` 関数を記述せよ。この関数は `List` の同じ名前のメソッドに類似している。

{% highlight scala linenos %}
def map[A, B](tree: Tree[A])(f: A => B) = tree match {
  case Leaf(v) => Leaf(f(v))
  case Branch(l, r) => Branch(map(l)(f), map(r)(f))
}
{% endhighlight %}

## 練習問題 3.29

> `size` 、 `maximum` 、 `depth` 、 `map` を一般化し、それらの類似点を抽象化する新しい `fold` 関数を記述せよ。そして、このより汎用的な `fold` 関数を使ってそれらを再実装せよ。この `fold` 関数と `List` の左畳み込みおよび右畳み込みの間にある類似性を抽出することは可能か。

{% highlight scala linenos %}
def fold[A, B](tree: Tree[A])(init: A => B)(acc: (B, B) => B): B = tree match {
  case Leaf(v) => init(v)
  case Branch(l, r) => acc(fold(l)(init)(acc), fold(r)(init)(acc))
}

def size[A](tree: Tree[A]) = fold(tree)(_ => 1)(_ + _ + 1)
def miximum(tree: Tree[Int]) = fold(tree)(identity)(_ max _)
def depth[A](tree: Tree[A]) = fold(tree)(_ => 0)((l, r) => (l max r) + 1)
def map[A, B](tree: Tree[A])(f: A => B) =
  fold(tree)(v => Leaf(f(v)): Tree[B])((l, r) => Branch(l, r))
{% endhighlight %}
