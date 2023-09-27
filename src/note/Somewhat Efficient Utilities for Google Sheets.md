---
title: Google スプレッドシートのための効率的なユーティリティ
writing: horizontal
date: 2023-09-26
lastmod: 2023-09-27
---

## `SMALLER` `LARGER`

`ARRAYFORMULA` の中で[2]{.upright}つの範囲のうち小さい[/]{.upright}大きい方を取りたいことはよくあるが、組み込みの `MIN` `MAX` は範囲の最小[/]{.upright}最大値を取らうとしてしまふ。

そこで、代はりに、丁度[2]{.upright}つの引数を取る `MIN` `MAX` の代替物を用意する。シグネチャは

``` excel
SMALLER(left, right)
LARGER(left, right)
```

として、実装は

``` excel
=IF(left < right, left, right)
=IF(left > right, left, right)
```

とする。

## `CONJ` `DISJ`

同じ理由で、[2]{.upright}変数の `AND` `OR` もあると嬉しい。シグネチャは

``` excel
CONJ(left, right)
DISJ(left, right)
```

として、実装は

``` excel
=IF(NOT(left), false, IF(NOT(right), false, true))
=IF(NOT(NOT(left)), true, IF(NOT(NOT(right)), true, false))
```

とする。

## `SLICE`

同じヘッダーを持つ[2]{.upright}つの表をマージするために、[2]{.upright}つ目の表の先頭からヘッダーを取り除きたいことがある。

もし<i>この表</i>がセル範囲なら、`A1:G100` といふセル参照から先頭[2]{.upright}行をヘッダーとして取り除く場合、セル参照を直接 `A3:G100` に書き換へるか、`OFFSET(A1:G100, 2, 0)` とするかすればよい。

けれど、扱ふ範囲がいつもセル参照とは限らない。たとへば、

- `IMPORTHTML` で取得した HTML テーブル
- セル範囲の配列。e.g., `{C1:C; A1:A}`

などはセル参照ではない。

こゝでは、かういふものを受け入れつゝ、行のみについて働く `OFFSET` の簡易版 `SLICE` を作る。シグネチャは

``` excel
SLICE(range, offset_rows, _height)
```

としよう。名前付き関数はオプション引数が扱へないので、`_height` を省略するときは `SLICE(range, 2, )` といふゝうに、末尾のカンマを置いて使ふ。

最初に思ひ付いた実装は、

``` excel
=ARRAY_CONSTRAIN(
  REVERSE(
    ARRAY_CONSTRAIN(
      REVERSE(range), 
      ROWS(range) - offset_rows, 
      COLUMNS(range)
    )
  ), 
  height, 
  COLUMNS(range)
)
```

だった。しかし、`REVERSE` が曲者で、意外にうまい実装が思ひ浮かばなかった。また、配列のスライス（サイズ 𝑘）の計算量が Θ(𝑘) であるのに対し、配列（サイズ 𝑛）の反転の計算量は Θ(𝑛) なので、やゝ非効率的でもある。

これよりもシンプルで、計算量も恐らく Θ(𝑘) で済む実装がある。`CHOOSEROWS`（第[2]{.upright}引数に配列を取れる[^1]。）を使って、

``` excel
=CHOOSEROWS(range, SEQUENCE(height, 1, offset_rows + 1))
```

のやうにすればよい。

[^1]: ……といふか、組み込みの関数は `MIN` `MAX` なども含めて、可変長引数を取る部分には配列も渡せるやうになってゐる。

`_height` が省略される場合を考慮すると、

``` excel
=LET(
  height, IF(ISBLANK(_height), ROWS(range) - offset_rows, _height), 
  CHOOSEROWS(range, SEQUENCE(height, 1, offset_rows + 1))
)
```

となる。
