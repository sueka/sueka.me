---
layout: post
title: シェルスクリプトにおける複合条件
lang: ja
tags: sh memo
excerpt_separator: <!-- excerpt separator -->
---

## TL; DR

複合条件の否定は

``` sh
if ! { [ -n "$foo" ] && [ -e "$file_path" ]; } then
  echo no good
fi
```

のやうに書くと良さゝう。

---

シェルスクリプトの複合条件は、よく

``` sh
if [ -n "$foo" -a -e "$file_path" ]; then
  echo ok
fi
```

のやうに書かれますが、 `test` ユーティリティの `-a` 、 `-o` プライマリは、 <abbr title="X/Open System Interfaces">XSI</abbr> の一部であって、 POSIX 互換ではない<!-- excerpt separator -->ので、 POSIX で動かすときは

``` sh
if [ -n "$foo" ] && [ -e "$file_path" ]; then
  echo ok
fi
```

のやうに `&&` 演算子を使って書きます。 `&&` や `||` は、被演算子にパイプラインを取り、 AND-OR リストを返す二項演算です。

こゝで、この複合条件が満たされないときにだけ何らかの処理をしたくなったとします。これは `:` ユーティリティを使って、

``` sh
if [ -n "$foo" ] && [ -e "$file_path" ]; then
  :
else
  echo no good
fi
```

と書くこともできますが、条件を反転させればより読みやすくなります。 XSI を使へば

``` sh
if ! [ -n "$foo" -a -e "$file_path" ]; then
  echo no good
fi
```

と書けますが、これでは `test` 以外のユーティリティ（ `grep` 、 `command` 、 `cmp` などが含まれます。）を複合条件に使ふことができません。 AND-OR リストを使ふ場合、条件を

``` sh
if ! { [ -n "$foo" ] && [ -e "$file_path" ]; } then # w/ brace_group
  echo no good
fi
```

、

``` sh
if ! ([ -n "$foo" ] && [ -e "$file_path" ]); then # w/ subshell
  echo no good
fi
```

あるいは

``` sh
if ! [ -n "$foo" ] || ! [ -e "$file_path" ]; then # w/ De Morgan's laws
  echo no good
fi
```

とするのが簡単です。単一条件の否定は

``` sh
if ! [ -n "$foo" ]; then
  echo no good
fi
```

のやうに `exit` を潰さずに[^1]書きたいので、 brace_group を使っておくのが無難です。

[^1]: `test` コマンドから `exit` すると if コマンドからも `exit` されるやうに
