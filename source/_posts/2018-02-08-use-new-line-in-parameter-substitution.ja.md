---
layout: post
title: パラメーター展開の中で改行を使ふ
lang: ja
tags: sh tips
toc: true
---

改行を変数にすればよい。

## 例

``` sh
#!/usr/bin/env sh
#
# Teletype for Atom がインストールされてゐるかどうかを返すスクリプト
#

set -eu

_LF="
"
_PACKAGES=$(apm list -bip | sed -n 's/@.*//p')

if [ ! -z "${_PACKAGES##*$'${_LF}teletype$_LF'*}" ]; then
  exit 1
fi

exit 0
```
