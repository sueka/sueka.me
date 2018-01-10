---
layout: post
title: Created a Scala library to use the clipboard
interlanguage-id: created-a-scala-library-to-use-the-clipboard
tags: scala io clipboard
toc: true
---

I have created a Scala library to use the system clipboard.  It is available on GitHub at [sueka/clipboard](//github.com/sueka/clipboard).

## Summary

The shell commands such as `xsel`, `pbcopy`, and `clip` have several differences, accessing the clipboard in a procedural way with Java and similar languages occurs side effects, and [Clipboard](//hackage.haskell.org/package/Clipboard) in the Hackage can't deal with non-string data.  Offhand, I have tried wrapping an access the clipboard by Java with `scalaz.effect.IO` for these reasons.

## Usage

Import the following objects:

{% highlight scala %}
import java.awt.Image
import scala.util.{ Success, Failure }
import scalaz.Scalaz.ToBindOps
import scalaz.Show
import scalaz.Show.showFromToString
import scalaz.effect.IO.{ putLn, putStrLn, readLn }
import me.sueka.clipboard.Clipboard
{% endhighlight %}

To print a string stored in the clipboard, do

{% highlight scala %}
val cbString = Clipboard.getClipboardString
val printCbStringLn = cbString map {
  case Success(s) => s
  case Failure(_) => ""
} >>= putStrLn
printCbStringLn.unsafePerformIO
{% endhighlight %}

To store a string read from standard input in the clipboard, do

{% highlight scala %}
val writeCb = readLn >>= Clipboard.setClipboardString
writeCb.unsafePerformIO
{% endhighlight %}

You can reverse a string stored in the clipboard when executing

{% highlight scala %}
val reverseCb = Clipboard.modifyClipboardString(_.reverse)
reverseCb.unsafePerformIO
{% endhighlight %}

When the clipboard has an image, executing

{% highlight scala %}
implicit def OptionShow: Show[Option[_]] = showFromToString

val cbImage = Clipboard.getClipboardImage
val printCbImage = cbImage.map(_.toOption) >>= putLn[Option[_]]
printCbImage.unsafePerformIO
{% endhighlight %}

prints a result applying `_.toString` to `java.awt.Image` object.

## Views

- Support for FileList
- Event handling
