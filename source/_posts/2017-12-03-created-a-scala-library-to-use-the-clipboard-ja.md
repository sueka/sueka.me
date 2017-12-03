---
layout: post
title: Scala でクリップボードを使ふためのライブラリを書いた
tags: scala io clipboard
lang: ja
---

Scala でクリップボードを使ふためのライブラリを書きました。 GitHub リポジトリ [sueka/clipboard](//github.com/sueka/clipboard) で公開してゐます。

## 経緯

シェル命令 (`xsel` `pbcopy` `clip`) の間の差異、 Java 等による一般的な方法には入出力による副作用があるといふこと、および Hackage の [Clipboard](//hackage.haskell.org/package/Clipboard) は文字列しか扱へないといふことから、 Java によるクリップボードアクセスを IO で安直に安全にしてみたものです。

## 使用例

説明に使用するオブジェクトをインポートします。:

``` scala
import scala.io.StdIn.readLine
import scala.util.{ Success, Failure }
import scalaz.Scalaz.ToBindOps
import scalaz.effect.IO.{ putStrLn, readLn }
import me.sueka.clipboard.Clipboard
```

クリップボードに格納されてゐる文字列を出力するには

``` scala
val cbString = Clipboard.getClipboardString
val printCbStringLn = cbString map {
  case Success(s) => s
  case Failure(_) => ""
} >>= putStrLn
printCbStringLn.unsafePerformIO
```

のやうに、標準入力から読み込んだ文字列をクリップボードに格納するには

``` scala
val writeCbLn = readLn >>= Clipboard.setClipboardString
writeCbLn.unsafePerformIO
```

のやうにします。

## 展望

- FileList 対応
- イベントハンドリング
