---
layout: post
title: パラメーター展開の中で改行を使ふ方法
lang: ja
tags: sh tips
toc: true
---

改行を変数にするだけです。

## 実例

``` sh
#!/bin/sh -eu
#
# Teletype for Atom がインストールされてゐるかどうかを返すスクリプト
#

_LF="
"
_PACKAGES=$(apm list -bip | sed -n 's/@.*//p')

if [ ! -z "${_PACKAGES##*$'${_LF}teletype$_LF'*}" ]; then
  exit 1
fi

exit 0
```
