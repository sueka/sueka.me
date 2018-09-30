---
layout: post
title: unidiff を色付けするシェルスクリプト
tags: sh
---

書きました。 `svn diff -c 1 | color.sh | less -R` とすると svn diff に色が付けられます。

{% gist '016a9ae980f88528d10ddee1a8a7b16f' %}
