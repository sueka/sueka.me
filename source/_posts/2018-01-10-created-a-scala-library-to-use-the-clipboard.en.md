---
layout: post
title: Created a Scala library to use the clipboard
interlanguage-id: created-a-scala-library-to-use-the-clipboard
tags: scala io clipboard
toc: true
---

I have created a Scala library to use the system clipboard.  It is available on GitHub at [sueka/clipboard](//github.com/sueka/clipboard).

## Summary

The shell commands such as `xsel`, `pbcopy`, and `clip` have several differences, accessing the clipboard in a procedural way with Java and similar languages occurs side effects, and [Clipboard](//hackage.haskell.org/package/Clipboard) in the Hackage can't deal with non-string data.  Offhand, I have tried wrapping an access to the clipboard by Java with `scalaz.effect.IO` for these reasons.

## Usage

Import the following objects:

``` scala
import java.awt.Image
import scala.util.{ Success, Failure }
import scalaz.Scalaz.ToBindOps
import scalaz.Show
import scalaz.Show.showFromToString
import scalaz.effect.IO.{ putLn, putStrLn, readLn }
import me.sueka.clipboard.Clipboard
```

To print a string stored in the clipboard, do

``` scala
val cbString = Clipboard.getClipboardString
val printCbStringLn = cbString map {
  case Success(s) => s
  case Failure(_) => ""
} >>= putStrLn
printCbStringLn.unsafePerformIO
```

To store a string read from standard input in the clipboard, do

``` scala
val writeCb = readLn >>= Clipboard.setClipboardString
writeCb.unsafePerformIO
```

You can reverse a string stored in the clipboard when evaluating

``` scala
val reverseCb = Clipboard.modifyClipboardString(_.reverse)
reverseCb.unsafePerformIO
```

When the clipboard has an image,

``` scala
implicit def OptionShow: Show[Option[_]] = showFromToString

val cbImage = Clipboard.getClipboardImage
val printCbImage = cbImage.map(_.toOption) >>= putLn[Option[_]]
printCbImage.unsafePerformIO
```

prints a result applying the `_.toString` to a `Option[java.awt.Image]` object.

## Future views

- Support for FileList
- Event handling
