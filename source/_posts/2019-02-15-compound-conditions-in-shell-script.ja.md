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

のように書くと良さそう。

---

シェルスクリプトの複合条件は、よく

``` sh
if [ -n "$foo" -a -e "$file_path" ]; then
  echo ok
fi
```

のように書かれますが、 `test` ユーティリティの `-a`, `-o` プライマリは、 <abbr title="X/Open System Interfaces">XSI</abbr> の一部であって、 POSIX 互換ではありません。

<!-- excerpt separator -->

そのため、 POSIX で動かなければならないときは

``` sh
if [ -n "$foo" ] && [ -e "$file_path" ]; then
  echo ok
fi
```

のように `&&` 演算子を使って書かれます。 `&&` や `||` は、被演算子にパイプラインを取り、 AND-OR リストを返す二項演算です。

ここで、冒頭の条件が満たされないときにだけ何らかの処理をしたくなったとします。これは、 `:` ユーティリティを使って、

``` sh
if [ -n "$foo" ] && [ -e "$file_path" ]; then
  :
else
  echo no good
fi
```

と書くこともできますが、条件を反転させられればより読みやすくなります。 XSI があれば、

``` sh
if ! [ -n "$foo" -a -e "$file_path" ]; then
  echo no good
fi
```

と書けそうですが、これでは `test` 以外のユーティリティ（ `grep`, `command`, `cmp` などが含まれます。）を複合条件に使うことができなくてつらいです。 AND-OR リストを使う場合、

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

と書くか、

``` sh
if ! [ -n "$foo" ] || ! [ -e "$file_path" ]; then
  echo no good
fi
```

と書き換える（ド・モルガンの法則）か、が簡単な解法です。単独の `test` は

``` sh
if ! [ -n "$foo" ]; then
  echo no good
fi
```

のように `exit` を潰さずに書きたいので、 brace_group を使っておくのがベターそうです。
