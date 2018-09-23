---
layout: post
title: Scala でクリップボードを使ふためのライブラリを書いた
interlanguage-id: created-a-scala-library-to-use-the-clipboard
lang: ja
tags: scala io clipboard
toc: true
---

Scala でクリップボードを使ふためのライブラリを書きました。 GitHub 上のリポジトリ [sueka/clipboard](//github.com/sueka/clipboard) で公開してゐます。

## 経緯

`xsel`, `pbcopy`, `clip` といったシェル命令に差異があること、 Java などによる手続き的な方法には入出力による副作用があること、 Hackage の [Clipboard](//hackage.haskell.org/package/Clipboard) は文字列しか扱へないことなどから、 Java によるクリップボードアクセスを `scalaz.effect.IO` で安直に安全にしてみたものです。

## 使用例

説明に使用するオブジェクトをインポートします。:

{% highlight scala %}
import java.awt.Image
import scala.util.{ Success, Failure }
import scalaz.Scalaz.ToBindOps
import scalaz.Show
import scalaz.Show.showFromToString
import scalaz.effect.IO.{ putLn, putStrLn, readLn }
import me.sueka.clipboard.Clipboard
{% endhighlight %}

クリップボードに格納されてゐる文字列を出力するには

{% highlight scala %}
val cbString = Clipboard.getClipboardString
val printCbStringLn = cbString map {
  case Success(s) => s
  case Failure(_) => ""
} >>= putStrLn
printCbStringLn.unsafePerformIO
{% endhighlight %}

のやうにし、標準入力から読み込んだ文字列をクリップボードに格納するには

{% highlight scala %}
val writeCb = readLn >>= Clipboard.setClipboardString
writeCb.unsafePerformIO
{% endhighlight %}

のやうにします。

{% highlight scala %}
val reverseCb = Clipboard.modifyClipboardString(_.reverse)
reverseCb.unsafePerformIO
{% endhighlight %}

とすると、クリップボードに格納されてゐる文字列を逆順にすることができます。

クリップボードに画像が格納されてゐる場合、

{% highlight scala %}
implicit def OptionShow: Show[Option[_]] = showFromToString

val cbImage = Clipboard.getClipboardImage
val printCbImage = cbImage.map(_.toOption) >>= putLn[Option[_]]
printCbImage.unsafePerformIO
{% endhighlight %}

のやうにすると `Option[java.awt.Image]` オブジェクトを `_.toString` したものを出力させることができます。

## 展望

- FileList 対応
- イベントハンドリング
