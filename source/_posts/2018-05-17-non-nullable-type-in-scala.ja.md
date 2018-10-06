---
layout: post
title: Scala で non-nullable 型
lang: ja
tags: scala type
---

Scala でコンパイル時に検出できる non-nullable 型っぽいものを書きました。強制するのは難しかったです。

``` scala
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
```

Dotty では合併型 (union type) が導入されます。（[参考](http://dotty.epfl.ch/docs/reference/overview.html#safety)）
