---
layout: post
title: Git でブランチを切り替へずに別のブランチを再現させる方法
lang: ja
tags: memo git
---

``` sh
git checkout $BRANCH -- `git diff --name-only --diff-filter=a $BRANCH`
git rm -- `git diff --name-only --diff-filter=A $BRANCH`
```

追加されたファイルは `git rm` し、その他のファイルは `git checkout` する。

追加されたファイルが無い場合はちょっとしたエラーが出るが、無視する。 `$BRANCH` はコミットであれば何でもよい。
