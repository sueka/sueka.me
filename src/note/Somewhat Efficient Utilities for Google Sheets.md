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

## `UNION` `INTERSECTION`

範囲や配列を集合みたいに使ひたいことも多い。まづは簡単な `UNION` から。シグネチャは

``` excel
UNION(left, right)
```

とする。`left` `right` は二次元でもよい。

実装は

``` excel
=LET(
  left_flat, TOCOL(left, 1),
  right_flat, TOCOL(right, 1),
  TOCOL(VSTACK(left_flat, right_flat), 1)
)
```

とした[^2]。計算量は `left` `right` のサイズを 𝑚、𝑛 として、Θ(𝑚 + 𝑛) 程度。

[^2]: `UNIQUE` はしない。`UNIQUE` の計算量は Θ(𝑛 log 𝑛) もあるが、その割に嬉しいことが少ない。

`INTERSECTION` は少し難しい。シグネチャは

``` excel
INTERSECTION(left, right)
```

とする。

実装は `right` に含まれない要素を `left` から取り除くといふ方針で行ふ。要素の除外には `FILTER` を使ふ。`FILTER` の条件は、もし範囲が列なら、列は行単位でしか処理できないので、行単位で処理される。よって、`INTERSECTION` は次のやうに実装できる:

``` excel
=LET(
  left_flat, TOCOL(left, 1),
  right_flat, TOCOL(right, 1),
  FILTER(left_flat, IFNA(MATCH(left_flat, right_flat, 0)))
)
```

ソートされてゐない範囲に関する `MATCH` の計算量は恐らく Θ(𝑛) だから、この実装の計算量は、`left` `right` のサイズを 𝑚、𝑛 として、Θ(𝑚𝑛) となる。

これは積集合としてはかなり遅い。これを改善するには、効率的な `Set` を用ゐて、

``` ts:intersect.ts
function intersect<T>(xs: T[], ys: T[]): T[] {
  const yy = new Set(ys) // Θ(n)

  return xs.filter( // Θ(m)
    x => yy.has(x) // Θ(1)
  )
}
```

のやうにする——つまり、Θ(1) の `CONTAINS` を用意して、`MATCH` をそれで置き換へればよい。

スプレッドシートの関数だけでこれを実装することはできない[^3]が、Apps Script に委譲すればうまくいく。多少のオーバーヘッドはあるが、計算量は変はらないだらう。

[^3]: 多分。

また、二分探索を使った改善も考へられる。上の Θ(𝑚𝑛) の実装を、`right_flat` がソートされ、*`MATCH` が担ふ処理*が二分探索で実行されるやうに改変する。新しい実装の計算量は、`left` `right` のサイズを 𝑚、𝑛 として、Θ((𝑚 + 𝑛) log 𝑛) 程度となる[^4]。

[^4]: `SORT` が最悪時間計算量が Θ(𝑛 log 𝑛) で済むアルゴリズムで実装されてゐることを期待してゐる。

探索に使ふ関数について。`MATCH(search_key, range, search_type?)` は、`search_type` が `1` `-1` または<i>空白</i>[^5]なら、恐らく二分探索で実行される。しかし、このモードの `MATCH` は、`range` に含まれる `search_key` 以下[/]{.upright}以上で最大[/]{.upright}最小の値の位置を返す。この仕様と `INDEX` `FILTER` との噛み合はせの悪さから、`MATCH` を使った実装はうまくいかなかった。

[^5]: 空白セルへの参照や、省略された引数など、`ISBLANK` が true を返す値。省略された引数が<i>空白</i>であることを確かめるには、`ISBLANK(LAMBDA(_a, b, b)(1,))` のやうな数式を実行する。

そこで、代はりに `XMATCH` を使ふ。`XMATCH(search_key, lookup_range, match_mode?, search_mode?)` は、`search_mode` が `2` なら、昇順でソートされた範囲を二分探索する。`match_mode` が `1` `-1` でない限り、`search_key` と異なる値にマッチすることもない。

新しい `INTERSECTION` の実装は、

``` excel
=LET(
  left_flat, TOCOL(left, 1),
  right_flat_sorted, SORT(TOCOL(right, 1)),
  FILTER(left_flat, XMATCH(left_flat, right_flat_sorted,, 2))
)
```

となる。

## `TIMESPENT`

数式の実行時間を計測するための関数 `TIMESPENT` を作る。シグネチャは

``` excel
TIMESPENT(proc)
```

とする。`proc` は引数を取らない関数。

実装は

``` excel
=LET(
  start_time, NOW(),
  _result, proc(),
  end_time, NOW(),
  TIMEDIF(start_time, end_time, "Ms")
)
```

とする。`LET(name, value_expression, ..., formula_expression)` は、`value_expression` の中でより左で宣言された `name` を使ふために、`name` `value_expression` ペアを左から順に逐次的に処理することになってゐる。 

多く `LAMBDA` を使って、`TIMESPENT(LAMBDA(MATCH("Pikachu", B2:B)))` といふゝうに使ふ。

### `TIMEDIF`

`TIMEDIF` は `DATEDIF` と同じシグネチャ、つまり、

``` excel
TIMEDIF(start_time, end_time, unit)
```

で、

``` excel
=LET(
  diff, end_time - start_time,
  IFS(
    unit = "S", FLOOR(86400 * diff),
    unit = "Ms", FLOOR(86400 * 1000 * diff)
  )
)
```

のやうに実装する。ミリ秒のための `unit` を `"MS"` ではなく `"Ms"` にしたのは、[Seconds in Minute]{lang=en} と誤解されないやうにするため[^6]。

[^6]: `DATEDIF` の `unit` は `"YM"` `"MD"` `"YD"` といふ値を取ることがあり、これらはそれぞれ [Months in Year]{lang=en}、[Days in Month]{lang=en}、[Days in Year]{lang=en} を意味する。
