---
layout: post
title: シェルスクリプトにおける複合条件
lang: ja
tags: sh memo
---

シェルスクリプトの複合条件は、よく

``` sh
if [ -n "$foo" -a -e "$file_path" ]; then
  echo ok
fi
```

のように書かれるが、 `test` ユーティリティの `-a`, `-o` プライマリは、 <abbr title="X/Open System Interfaces">XSI</abbr> の一部であり、 POSIX 互換ではない。

そのため、 POSIX で動かなければならないときは

``` sh
if [ -n "$foo" ] && [ -e "$file_path" ]; then
  echo ok
fi
```

のように、 `&&` 演算子を使って書かれる。 `&&` や `||` は、被演算子にパイプラインを取り、 AND-OR リストを返す二項演算である。

さて、ここで、冒頭の条件が満たされないときにだけ何らかの処理をしたくなったとする。これは、 `:` ユーティリティを使って、

``` sh
if [ -n "$foo" ] && [ -e "$file_path" ]; then
  :
else
  echo no good
fi
```

と書くこともできるが、条件を反転させられればより読みやすくなることも容易に想像できる。 XSI があれば、

``` sh
if ! [ -n "$foo" -a -e "$file_path" ]; then
  echo no good
fi
```

と書けそうだが、これでは、 `test` 以外のユーティリティ（ `grep`, `command`, `cmp` などが含まれる。）を複合条件に使うことができなくてつらい。 AND-OR リストを使う場合、

``` sh
if ! { [ -n "$foo" ] && [ -e "$file_path" ]; } then
  echo no good
fi
```

のように brace_group として書くか、 subshell で

``` sh
if ! ([ -n "$foo" ] && [ -e "$file_path" ]); then
  echo no good
fi
```

と書くか、ド・モルガンの法則によって

``` sh
if ! [ -n "$foo" ] || ! [ -e "$file_path" ]; then
  echo no good
fi
```

と書き換えるか、が簡単な解法である。この内、 brace_group は exit を伝播し、ド・モルガンの法則は、3項以上の AND-OR リストをうまく扱えないため、 subshell を使うのがベターなのではないか、という提言である。終わり。
