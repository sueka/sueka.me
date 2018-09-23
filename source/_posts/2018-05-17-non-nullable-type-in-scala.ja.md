---
layout: post
title: Scala で non-nullable 型
lang: ja
tags: scala type
---

Scala でコンパイル時に検出できる non-nullable 型っぽいものを書いた。強制するのは難しかった。

{% highlight scala %}
object Main extends App {
  trait Xor[A, B]

  implicit def allowXorForDifferentTypes[A, B]: A Xor B = null
  implicit def denyXorForSameTypes1[A]: A Xor A = null
  implicit def denyXorForSameTypes2[A]: A Xor A = null

  type Not[T] = {
    type L[U] = T Xor U
  }

  def f[A: Not[Null]#L](x: A with String) = x

  f("string")
  f('c') // type mismatch
  f(null) // ambiguous implicit values
}
{% endhighlight %}
