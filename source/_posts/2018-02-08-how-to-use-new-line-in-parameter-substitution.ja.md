---
layout: post
title: パラメーター展開の中で改行を使ふ方法
lang: ja
tags: sh tip
---

改行を変数にするだけです。

## 実例

``` sh
#!/bin/sh
#
# Teletype for Atom がインストールされてゐるかどうかを返すスクリプト
#

set -eu

LF='
'
PACKAGES=$(apm list -bip | sed -n 's/@.*//p')

if [ -n "${PACKAGES##*${LF}teletype${LF}*}" ]; then
  exit 1
fi
```
