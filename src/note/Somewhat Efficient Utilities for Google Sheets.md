---
title: Google スプレッドシートのための効率的なユーティリティ集
date: 2023-09-26
lastmod: 2023-10-16
---

## `SMALLER` `LARGER`

同じサイズの[2]{.upright}つの範囲に関して、それぞれのペアのうちより小さい方のデータからなる範囲が知りたいとしよう。

スプレッドシートでは、かういふゝうに範囲[^9]に含まれる各データについて何らかの計算をしたいときは `ARRAYFORMULA` を使ふことが多い。`ARRAYFORMULA` は、配列[^9]でないデータ（の組）を引数に取る関数の適用を、配列（の組）を引数に取る関数の適用に移す。ほとんど同じ機能を持つ関数として `MAP` があり、次の[2]{.upright}行は大抵同じ結果になる:

``` excel
ARRAYFORMULA(FOO(A1:A, B1:B))
MAP(A1:A, B1:B, LAMBDA(a, b, FOO(a, b)))
```

[^9]: スプレッドシートでは「範囲」と「配列」はほゞ同じものを指す。

たゞし、`ARRAYFORMULA` は配列（の組）を引数に取る関数とは協調しない。もし `FOO` が引数に配列を取れるなら、`ARRAYFORMULA` は何もせず、`FOO(A1:A, B1:B)` が返す値をそのまゝ返す。

冒頭の問題に戻ると、組み込みの `MIN` は引数に範囲を取れる[^1]ので、`ARRAYFORMULA(MIN(A1:A, B1:B))` は、`A1:A` と `B1:B` の最小値を表示してしまふ。これを回避するために、丁度[2]{.upright}つの引数を取る `MIN` の代替物を用意する:

``` excel
SMALLER(left, right)
=IF(left < right, left, right)
```

C1 を `=ARRAYFORMULA(SMALLER(A1:A, B1:B))` とすれば、C1 には A1 と B1 のうち小さい方が、C2 には A2 と B2 のうち小さい方が……表示される。

`LARGER` も同様に実装する:

``` excel
LARGER(left, right)
=IF(left > right, left, right)
```

## `CONJ` `DISJ`

同じ理由で、[2]{.upright}変数の `AND` `OR` もあると嬉しい:

``` excel
CONJ(left, right)
=IF(NOT(left), false, IF(NOT(right), false, true))
```

``` excel
DISJ(left, right)
=IF(NOT(NOT(left)), true, IF(NOT(NOT(right)), true, false))
```

## `SLICE`

同じヘッダーを持つ[2]{.upright}つの表をマージするために、[2]{.upright}つ目の表の先頭からヘッダーを取り除きたいとする。

かういふとき、もし<i>この表</i>がシート上にあるなら、セル参照を直接書き換へるか、`OFFSET` 関数で参照をシフトさせるかすればよい。たとへば、`A1:G100` から先頭[2]{.upright}行をヘッダーとして取り除くには、セル参照を直接 `A3:G100` に書き換へるか、あるいは `OFFSET(A1:G100, 2,, 98)` とする。

けれど、扱ふ範囲がいつもセル参照として表せるとは限らない。たとへば、

- `IMPORTHTML` で取得した HTML テーブル
- セル参照の配列。e.g., `{C1:C; A1:A}`

などはセル参照ではない。

こゝでは、かういふものを受け入れつゝ行のみについて働く `OFFSET` の簡易版、`SLICE` を作る:

``` excel
SLICE(range, offset_rows, _height)
=LET(
  height, IF(ISBLANK(_height), ROWS(range) - offset_rows, _height), 
  CHOOSEROWS(range, SEQUENCE(height, 1, offset_rows + 1))
)
```

[^1]: 組み込みの関数はほゞ全て、可変長引数を取る部分には配列も渡せるやうになってゐる。

名前付き関数はオプション引数を扱へないので、`_height` を省略するときは `SLICE(range, 2, )` といふゝうに、末尾のカンマを置いて使ふ。

## `UNION` `INTERSECTION`

範囲や配列を集合のやうに使ひたいことも多い。`UNION` は割合簡単に実装できる[^2]:

``` excel
UNION(left, right)
=LET(
  left_flat, TOCOL(left, 1),
  right_flat, TOCOL(right, 1),
  VSTACK(left_flat, right_flat)
)
```

[^2]: `UNIQUE` は使はない。`UNIQUE` の計算量は Θ(𝑛 log 𝑛) もあるが、その割に嬉しいことが少ない。

計算量は `left` `right` のサイズを 𝑚、𝑛 として、Θ(𝑚 + 𝑛) 程度。`left` `right` が[2]{.upright}次元でも動作する。

---

`INTERSECTION` は、`FILTER` と `XMATCH` を用ゐて、

``` excel
INTERSECTION(left, right)
=LET(
  left_flat, TOCOL(left, 1),
  right_flat_sorted, SORT(TOCOL(right, 1)),
  TOCOL(IFNA(FILTER(left_flat, IFNA(XMATCH(left_flat, right_flat_sorted,, 2)))), 1)
)
```

と実装した。`FILTER` は返すものがないときは `#N/A` を返すので、`IFNA` と `TOCOL` を使って<i>空の範囲</i>[^7]に置き換へてゐる。この実装の計算量は、`left` `right` のサイズを 𝑚、𝑛 として、Θ((𝑚 + 𝑛) log 𝑛) 程度となる[^4]。

[^7]: <i>空の範囲</i>は、セルに直接出力すると `#REF`（<ruby>参照が存在しません。<rt lang="en">Reference does not exist</ruby>）を返すが、セルに出力されない限り、サイズ[0]{.upright}の範囲として振る舞ふ。

---

配列の共通部分の計算には Θ(𝑚 + 𝑛) の実装がある:

``` ts:intersect.ts
function intersect<T>(xs: T[], ys: T[]): T[] {
  const yy = new Set(ys) // Θ(n)

  return xs.filter( // Θ(m)
    x => yy.has(x) // Θ(1)
  )
}
```

<s>Θ(1) の `CONTAINS` を用意して、`XMATCH` をそれで置き換へればよい</s>[^12]。

[^12]: これは嘘だった。`CONTAINS` のみを Apps Script に委譲する場合、`new Set(ys)` 相当の処理が 𝑚 回ほど実行されることになる。配列から集合への変換は Θ(𝑛) を要するので、`XMATCH` を `CONTAINS` で置き換へた実装の計算量は、良くて Θ(𝑚𝑛) となる。

スプレッドシートの関数だけでこれを実装することはできない[^3]が、Apps Script に委譲すればうまくいく。多少のオーバーヘッドはあるが、計算量は変はらないだらう。

[^3]: 多分。

[^4]: `SORT` が最悪時間計算量が Θ(𝑛 log 𝑛) で済むアルゴリズムで実装されてゐることを期待してゐる。

## <s>`FORALL` `EXISTS`</s>

範囲内のデータが全て条件を満たすかどうか、あるいは範囲内に条件を満たすデータが存在するかどうかゞ知りたいこともある。

この操作は `ARRAYFORMULA` を使ふと効率良く行へる。たとへば、範囲 `A2:A` に素数が存在することを調べるには、`OR(ARRAYFORMULA(ISPRIME(A2:A)))` などゝする。計算量は、`ISPRIME` の計算量を Θ(𝑔(𝑘)) として、常に Θ(Σₖ 𝑔(𝑘)) となる[^10]。

[^10]: 𝑔(𝑘) がどういふ形をしてゐるかは分からないが、とにかく全て足し合はせた程度の時間を要し、途中で打ち切られない。念のために補足すると、仕様ではないので、タイミング攻撃への対策として利用しないこと。

`MAP` を使ふ方法もあるが、私の環境では `ARRAYFORMULA` を使った方法のはうが[1]{.upright}～[10]{.tate-chu-yoko}倍ほど速く動作した。

もし名前付き関数にするなら、

``` excel
FORALL(range, pred)
=AND(MAP(range, pred))
```

``` excel
EXISTS(range, pred)
=OR(MAP(range, pred))
```

のやうにする。`EXISTS(A2:A, ISPRIME)` といふゝうに使ふ。[`MAP`](https://support.google.com/docs/answer/12568985) の `LAMBDA` はラムダ関数でなければならないが、名前付き関数を `LAMBDA` 仮引数として渡すこともできる。`ARRAYFORMULA` の引数となる数式を範囲と条件に分けることは恐らくできない。

この `FORALL` `EXISTS` は名前と実装がほとんど同じで、名前付き関数として定義する意義が少ない。むしろ、専らスプレッドシートに慣れてゐる人にとっては、組み込み関数で書かれてゐるはうが分かりやすいだらう。

`ARRAYFORMULA` と `MAP` は[2]{.upright}行[2]{.upright}列以上の範囲も走査できる。便利な仕様だが、この機能性のせゐで、右に挙げた方法で行単位または列単位の条件の全称・存在性を調べることはできない。これを解決させるには `BYROW` `BYCOL` を使ふ。たとへば、範囲 `A2:B` に含まれる全ての行が双子素数のペアであることを調べるには、`AND(BYROW(A2:B, ARETWINPRIMES))` とする。

## `REVERSE` `VREVERSE` `HREVERSE`

範囲の反転は、

``` excel
REVERSE(range)
=LET(
  empty_rows, TOCOL(, 1),
  REDUCE(empty_rows, range, LAMBDA(total, value, VSTACK(value, total)))
)
```

のやうに書ける。たゞし、`REDUCE` は[2]{.upright}次元の範囲を取れるので、この関数は、どんな形の範囲が渡されても、行優先で平滑化した上で、[1]{.upright}列の範囲を返す。

そこで、行方向または列方向の範囲を反転させる方法を考へる。まづ、範囲がセル参照なら、行方向の範囲の反転は

``` excel
FLIP(rows)
=SORT(rows, ROW(rows), false)
```

のやうに書ける[^11]。この方法は、行番号をキーとして降順にソートすることで、行方向の範囲の反転を実現させてゐる。しかし、`ROW` はシート上の行番号を返すものなので、セル参照に対してしか動作しない。

[^11]: [Flip Data Vertically - Google Docs Editors Community](https://support.google.com/docs/thread/133917778)

また、この方針では列方向の反転も恐らく実装できない。`SORT` は行方向のソートしか行へないので、上の `FLIP` と同じやうに実装することはできないし、`ROW` はセル参照しか取れないので、`=TRANSPOSE(FLIP(TRANSPOSE(cols)))` みたいな実装もうまくいかない。

### `VLEN`

これを解決させるには、`ROW` の代はりに `SEQUENCE` を使ふとよい。範囲のサイズを知る必要があるので、まづは `VLEN` を作る:

``` excel
VLEN(rows)
=SUM(BYROW(rows, LAMBDA(_, 1)))
```

計算量は Θ(𝑛) である[^8]。

[^8]: 遅さうに見えるが、サイズのためのフィールドがない場合は妥当だと思ふ。

---

これを使ふと、`VREVERSE` は

``` excel
VREVERSE(rows)
=SORT(rows, SEQUENCE(VLEN(rows)), false)
```

と書ける。このバージョンはセル参照でない範囲に対してもうまく動作する。

`HREVERSE` も `TRANSPOSE` と `VREVERSE` で実装できる:

``` excel
HREVERSE(cols)
=TRANSPOSE(VREVERSE(TRANSPOSE(cols)))
```

## `UNMERGE`

結合されたセルのデータはその結合の左上[^13]のみにあり、そのやうなセルを含む範囲は、左上以外の位置にはデータを持たない。一方、市井では、セルの結合は結合されたセルが全て同じデータを持つことを表すと解される。ナンセンスな例だが、

[^13]: 表示言語が RtL 言語でも同じ。

<table class="horizontal">
  <tr>
    <td></td>
    <th scope="col">A</th>
    <th scope="col">B</th>
    <th scope="col">C</th>
  </tr>
  <tr>
    <th scope="row">1</th>
    <td colspan="2" rowspan="2">BIG CELL</td>
    <td>meow</td>
  </tr>
  <tr>
    <th scope="row">2</th>
    <td>croak</td>
  </tr>
  <tr>
    <th scope="row">3</th>
    <td>coo</td>
    <td>buzz</td>
    <td>neigh</td>
  </tr>
</table>

のやうなシート片に対して

``` excel
=JOIN("
", BYROW(A1:C3, LAMBDA(row, JOIN(",", row))))
```

とすると、

``` txt
BIG CELL,,meow
,,croak
coo,buzz,neigh
```

と表示され、`B1` `A2` `B2` は空白であることが分かる。

かういふ表を結合のない範囲として扱ふために、結合されたセルを含む範囲に関して、結合されたセルを最も左上のデータで埋める関数 `UNMERGE` を作る。

スプレッドシートにはセルが結合されてゐるかどうかを知る方法が無いので、Apps Script を使用した。[sueka/google-sheets-unmerge](https://github.com/sueka/google-sheets-unmerge) に置いてゐる。

この Apps Script をインストールして、

``` excel
=UNMERGE("A1:C3")
```

とすると、

| -------- | -------- | ----- |
| BIG CELL | BIG CELL | meow  |
| BIG CELL | BIG CELL | croak |
| coo      | buzz     | neigh |
{.horizontal}

のやうに表示される。

この関数の計算量は、範囲に含まれる結合された範囲のサイズの和を 𝑛 として、Θ(𝑛) 程度となる。

なほ、スプレッドシートにおける<i>範囲</i>は、Apps Script に渡されると[2]{.upright}次元配列となり、結合に関する情報を失ってしまふため、~~`UNMERGE(A1:C3)`~~ のやうにセル参照を渡して実行されるものは作れない[^3]。

## `TIMESPENT`

数式の実行時間を計測するための関数 `TIMESPENT` を作った:

``` excel
TIMESPENT(proc)
=LET(
  start_time, NOW(),
  _result, proc(),
  end_time, NOW(),
  TIMEDIF(start_time, end_time, "Ms")
)
```

`proc` は引数を取らない関数。[`LET`](https://support.google.com/docs/answer/13190535) は、`value_expression` の中でより左で宣言された `name` が使へるやうにするために、`name` `value_expression` ペアを左から順に逐次的に処理する。 

多く `LAMBDA` を使って、`TIMESPENT(LAMBDA(MATCH("Pikachu", B2:B)))` といふゝうに使ふ。

### `TIMEDIF`

`TIMEDIF` は、組み込みの [`DATEDIF`](https://support.google.com/docs/answer/6055612) に似せて、

``` excel
TIMEDIF(start_time, end_time, unit)
=LET(
  diff, end_time - start_time,
  IFS(
    unit = "S", FLOOR(86400 * diff),
    unit = "Ms", FLOOR(86400 * 1000 * diff)
  )
)
```

のやうに実装した。ミリ秒のための `unit` を `"MS"` ではなく `"Ms"` にしたのは、[Seconds in Minute]{lang=en} と誤解されないやうにするため[^6]。

[^6]: [`DATEDIF`](https://support.google.com/docs/answer/6055612) の `unit` は `"YM"` `"MD"` `"YD"` といふ値を取ることがあり、これらはそれぞれ [Months in Year]{lang=en}、[Days in Month]{lang=en}、[Days in Year]{lang=en} を意味する。
