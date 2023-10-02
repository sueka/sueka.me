---
title: Google スプレッドシートのための効率的なユーティリティ集
writing: horizontal
date: 2023-09-26
lastmod: 2023-10-02
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

として、実装は、可変長引数を取る関数を使はないやうに注意して、

``` excel
=IF(NOT(left), false, IF(NOT(right), false, true))
=IF(NOT(NOT(left)), true, IF(NOT(NOT(right)), true, false))
```

とする。

## `SLICE`

同じヘッダーを持つ[2]{.upright}つの表をマージするために、[2]{.upright}つ目の表の先頭からヘッダーを取り除きたいことがある。

もし<i>この表</i>がセル範囲なら、`A1:G100` といふセル参照から先頭[2]{.upright}行をヘッダーとして取り除くには、セル参照を直接 `A3:G100` に書き換へるか、`OFFSET(A1:G100, 2, 0)` とするかすればよい。

けれど、扱ふ範囲がいつもセル参照とは限らない。たとへば、

- `IMPORTHTML` で取得した HTML テーブル
- セル範囲の配列。e.g., `{C1:C; A1:A}`

などはセル参照ではない。

こゝでは、かういふものを受け入れつゝ行のみについて働く `OFFSET` の簡易版、`SLICE` を作る。シグネチャは

``` excel
SLICE(range, offset_rows, _height)
```

としよう。名前付き関数はオプション引数が扱へないので、`_height` を省略するときは `SLICE(range, 2, )` といふゝうに、末尾のカンマを置いて使ふ。

実装は `CHOOSEROWS`（第[2]{.upright}引数に配列を取れる[^1]。）を使って、

``` excel
=LET(
  height, IF(ISBLANK(_height), ROWS(range) - offset_rows, _height), 
  CHOOSEROWS(range, SEQUENCE(height, 1, offset_rows + 1))
)
```

とする。

[^1]: ……といふか、組み込みの関数は `MIN` `MAX` なども含めて、可変長引数を取る部分には配列も渡せるやうになってゐる。

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
  VSTACK(left_flat, right_flat)
)
```

とする[^2]。計算量は `left` `right` のサイズを 𝑚、𝑛 として、Θ(𝑚 + 𝑛) 程度。

[^2]: `UNIQUE` は使はない。`UNIQUE` の計算量は Θ(𝑛 log 𝑛) もあるが、その割に嬉しいことが少ない。

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
  TOCOL(IFNA(FILTER(left_flat, IFNA(MATCH(left_flat, right_flat, 0)))), 1)
)
```

`FILTER` は返すものがないときに `#N/A` を返すので、`IFNA` と `TOCOL` を使って<i>空の範囲</i>[^7]に置き換へてゐる。ソートされてゐない範囲に関する `MATCH` の計算量は恐らく Θ(𝑛) だから、この実装の計算量は、`left` `right` のサイズを 𝑚、𝑛 として、Θ(𝑚𝑛) となる。

[^7]: <i>空の範囲</i>は、セルに直接出力すると `#REF`（<ruby>参照が存在しません。<rt lang="en">Reference does not exist</ruby>）を返すが、セルに出力されない限り、サイズ[0]{.upright}の範囲として振る舞ふ。

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

探索に使ふ関数は変更する必要がある。[`MATCH`](https://support.google.com/docs/answer/3093378) は、`search_type` が `1` `-1` または<i>空白</i>[^5]なら、恐らく二分探索で実行される。しかし、このモードの `MATCH` は、`search_type` が[1]{.upright}の場合、`range` に含まれる `search_key` 以下で最大の値の位置を返す。この仕様と `INDEX` `FILTER` との噛み合はせの悪さから、`MATCH` を使った実装はうまくいかなかった。

[^5]: 空白セルへの参照や、省略された引数など、`ISBLANK` が true を返す値。省略された引数が<i>空白</i>であることを確かめるには、`ISBLANK(LAMBDA(_a, b, b)(1,))` のやうな数式を実行する。

そこで、代はりに `XMATCH` を採用した。[`XMATCH`](https://support.google.com/docs/answer/12406049) は、`search_mode` が `2` なら、昇順でソートされた範囲を二分探索する。`match_mode` が `1` `-1` でない限り、`search_key` と異なる値にマッチすることもない。

新しい `INTERSECTION` の実装は、

``` excel
=LET(
  left_flat, TOCOL(left, 1),
  right_flat_sorted, SORT(TOCOL(right, 1)),
  TOCOL(IFNA(FILTER(left_flat, IFNA(XMATCH(left_flat, right_flat_sorted,, 2)))), 1)
)
```

となる。

## <s>`FORALL` `EXISTS`</s>

範囲内の値が全て条件を満たすかどうかや、範囲内に条件を満たす値が存在するかどうかが知りたいことがある。

この操作は `ARRAYFORMULA` を用ゐると効率良く行へる。たとへば、範囲 `A2:A` に素数が存在することを調べるには、`OR(ARRAYFORMULA(ISPRIME(A2:A)))` などゝする。計算量は常に Θ(𝑛) となる。

`MAP` を使ふ方法もあるが、私の環境では `ARRAYFORMULA` を使った方法のはうが[1]{.upright}～[10]{.tate-chu-yoko}倍ほど速く動作した。

もし名前付き関数にするなら、シグネチャは

``` excel
FORALL(range, pred)
EXISTS(range, pred)
```

とし、実装は

``` excel
=AND(MAP(range, pred))
=OR(MAP(range, pred))
```

のやうにする。`EXISTS(A2:A, ISPRIME)` といふゝうに使ふ。[`MAP`](https://support.google.com/docs/answer/12568985) の `LAMBDA` はラムダ関数でなければならないが、名前付き関数を `LAMBDA` 仮引数として渡すこともできる。`ARRAYFORMULA` の引数となる数式を範囲と条件に分けることは恐らくできない。

`FORALL` `EXISTS` は名前と実装がほとんど同じで、名前付き関数として定義する意義が少ない。むしろ、もっぱらスプレッドシートに慣れてゐる人にとっては、組み込み関数で書かれてゐるはうが分かりやすいだらう。

`ARRAYFORMULA` と `MAP` は[2]{.upright}行[2]{.upright}列以上の範囲も走査できる。便利な仕様だが、この機能性のせゐで、右に挙げた方法で行単位または列単位の条件の全称・存在性を調べることはできない。これを解決させるには `BYROW` `BYCOL` を使ふ。範囲 `A2:B` に含まれる全ての行が双子素数のペアであることを調べるには、`AND(BYROW(A2:B, ISTWINPRIME))` とする。

## `REVERSE` `VREVERSE` `HREVERSE`

範囲の反転は、

``` excel
REVERSE(range)
```

``` excel
=LET(
  empty_rows, TOCOL(, 1),
  REDUCE(empty_rows, range, LAMBDA(total, value, VSTACK(value, total)))
)
```

のやうに書ける。たゞし、`REDUCE` は[2]{.upright}行[2]{.upright}列以上の範囲を取れるので、この関数は、どんな形の範囲が渡されても、行優先で平滑化した上で、[1]{.upright}列の範囲を返す。

そこで、行方向または列方向の範囲を反転させる方法を考へる。まづ、範囲がセル参照なら、行方向の範囲の反転は

``` excel
VREVERSE(rows)
```

``` excel
=SORT(rows, ROW(rows), false)
```

のやうに書ける。この方法は、行番号をキーとして降順にソートすることで、行方向の範囲の反転を実現させてゐる。しかし、`ROW` はシート上の行番号を返すものなので、セル参照（例: `A1:B`）に対してしか動作しない。

また、この方針では `HREVERSE` を実装することも恐らくできない。`SORT` は行方向のソートしか行へないので、上の `VREVERSE` と同じやうな実装はできないし、`ROW` はセル参照しか取れないので、`=TRANSPOSE(VREVERSE(TRANSPOSE(cols)))` みたいな実装もうまくいかない。

### `VLEN`

これを解決させるには、`ROW` の代はりに `SEQUENCE` を使ふとよい。範囲のサイズを知る必要があるので、まづは `VLEN` を作る。シグネチャは

``` excel
VLEN(rows)
```

として、実装は

``` excel
=SUM(BYROW(rows, LAMBDA(_, 1)))
```

とする。計算量は Θ(𝑛) である[^8]。

[^8]: 遅さうに見えるが、サイズのためのフィールドがない場合は妥当だと思ふ。

---

新しい `VREVERSE` の実装は、

``` excel
=SORT(rows, SEQUENCE(VLEN(rows)), false)
```

となる。このバージョンはセル参照でない範囲に対してもうまく動作する。また、`HREVERSE` も `TRANSPOSE` と `VREVERSE` で実装できる。シグネチャは

``` excel
HREVERSE(cols)
```

とし、実装は

``` excel
=TRANSPOSE(VREVERSE(TRANSPOSE(cols)))
```

とする。

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

とする。[`LET`](https://support.google.com/docs/answer/13190535) は、`value_expression` の中でより左で宣言された `name` が使へるやうにするために、`name` `value_expression` ペアを左から順に逐次的に処理する。 

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
