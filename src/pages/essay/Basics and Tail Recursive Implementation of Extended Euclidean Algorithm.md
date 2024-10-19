---
title: 拡張ユークリッドの互除法の基礎と末尾再帰実装
useKaTeX: true
date: 2024-09-12
---

<i>拡張ユークリッドの互除法^[<i>拡張<b>された</b>ユークリッドの互除法</i>とも。]</i>といふアルゴリズムがある。これは、<i>ユークリッドの互除法</i>のついでに、<i><ruby>ベズー係数<rt lang="en">Bézout coefficients</ruby></i>の最小対を1組求めるものだが、巷にある、このアルゴリズムの実装は、例へば、Gist を <i>[extended euclidean]{lang=en}</i> で検索してみると分かるやうに、そのほとんどがループによるものと、非末尾再帰によるものである。<i>末尾再帰は？</i>　といふ話。

$$
\\gdef\\oint{\\operatorname{int}}
\\gdef\\qed{∎}
$$
{.display-none}

## ユークリッドの互除法

こちらから書かう。<em><ruby>ユークリッドの互除法<rt lang="en">Euclidean algorithm</ruby></em>は、アレクサンドリアのエウクレイデスが『<i><ruby>原論<rt lang="grc">Στοιχεῖα</ruby></i>』第7巻で記述した、*2つの整数^[『<i>原論</i>』では自然数。]の最大公約数を求める*アルゴリズムである。現代では、次のやうに記述される[^bmod]:

[^bmod]: 剰余演算 \\( \\left( \\bmod \\right) \\colon \\Z \\times \\Z \\to \\Z \\) は<i>除法の原理</i>を満たす。すなはち、\\( a \\) を整数、\\( b \\) を \\( 0 \\) でない整数とすると、<i>除法の原理</i>より、\\( a = q b + r, \\left\| r \\right\| < \\left\| b \\right\| \\) を満たすやうな整数 \\( q, r \\) が存在し、\\( a \\bmod b = r = a - q b \\) である。

<div class="indented">

  整数 \\( a, b \\) が与へられる。\\( b = 0 \\) ならば \\( a \\) を返却する。さもなければ \\( a \\gets b, b \\gets a \\bmod b \\) とし、直前の手順に戻って続ける。

</div>

``` ts
function gcd(a: number, b: number): number {
  while (b !== 0) {
    ;[a, b] = [b, a % b]
  }

  return a
}
```

宣言的に述べると、次のやうになる:

<div class="indented">

  \\( a, b \\) を整数とする。このとき、求めるべき値は、\\( b = 0 \\) ならば \\( a \\) であり、さもなければ、\\( b \\) と \\( a \\bmod b \\) について、このアルゴリズムを再帰的に適用し、得られた値を \\( gcd \\) として、\\( gcd \\) である。

</div>

``` ts
function gcd(a: number, b: number): number {
  if (b === 0) {
    return a
  } else {
    return gcd(b, a % b)
  }
}
```

### 証明

<a id="euclidean-halting"></a>

停止性
: 上の手続き的アルゴリズムを、適用過程が保存されるやうに変更する:

  <div class="indented">

    整数 \\( a, b \\) が与へられる。\\( r_0 \\coloneqq a, r_1 \\coloneqq b \\) とおき、\\( k \\coloneqq 0 \\) として、\\( k \\) を \\( 1 \\) づゝ増分させながら[^k-supremum]、次の手順を繰り返す。\\( r_{k + 1} = 0 \\) ならば \\( r_k \\) を返却し、さもなければ \\( r_{k + 2} \\coloneqq r_k \\bmod r_{k + 1} \\) とする。

    [^k-supremum]: 上限は、<i><ruby>ラメの定理<rt lang="en">Lamé’s theorem</ruby></i>より、\\( k < 5 \\left( \\left⌊ \\log_{10} b \\right⌋ + 1 \\right) + 1 \\) である。最後の反復では除算（剰余算）が行はれないことに注意。

  </div>

  このとき、\\( a = 0 \\) ならば \\( \\gcd(a, b) = b \\) であり、また、\\( \\left\| r_{k + 1} \\right\| = \\left\| r_{k - 1} \\bmod r_k \\right\| < \\left\| r_k \\right\| \\) より、数列 \\( \\bm{r_{\\geq 1}} = \\left\| r_1 \\right\|, \\left\| r_2 \\right\|, \\dots \\) の項は、\\( 0 \\) が現れるまでの区間において、狭義単調減少するので、*このアルゴリズムは停止する*。

正当性
: \\( a \\) を整数、\\( b \\) を \\( 0 \\) でない整数とすると、<i>除法の原理</i>より、\\( a = q b + r, \\left\| r \\right\| < \\left\| b \\right\| \\) を満たすやうな整数 \\( q, r \\) が存在する。こゝで、\\( a, b \\) の公約数は \\( r = a - q b \\) の約数でもあり、\\( b, r \\) の公約数は \\( a = q b + r \\) の約数でもあるから、\\( a, b \\) の公約数は \\( b, r \\) の公約数でもあり、逆も然り。よって、*\\( \\gcd(a, b) = \\gcd(b, r) \\) である*。\\( \\qed \\)

## 拡張ユークリッドの互除法

<em><ruby>拡張ユークリッドの互除法<rt lang="en">Extended Euclidean algorithm</ruby></em>（<i>EEA</i>）は、<i>ユークリッドの互除法</i>から派生したアルゴリズムで、2つの整数 \\( a, b \\) の最大公約数 \\( \\gcd(a, b) \\) を求め、同時に、*不定方程式 \\( ax + by = \\gcd(a, b) \\) の整数解であって、\\( \\left\| x \\right\| \\leq \\left\| \\frac{b}{\\gcd(a, b)} \\right\|, \\left\| y \\right\| \\leq \\left\| \\frac{a}{\\gcd(a, b)} \\right\| \\) を満たす[^min-bezout-coeffs]やうなものを1組求める*ものである。このアルゴリズムは、手続き的に記述すると、次のやうになる[^int]:

[^min-bezout-coeffs]: \\( a \\ne 0, b \\ne 0 \\) の場合に限る。\\( a = 0 \\) の場合、\\( \\left\| y \\right\| \\leq \\left\| \\frac{a}{\\gcd(a, b)} \\right\| \\) を満たす \\( y \\) が存在しない。\\( b \\) と \\( x \\) についても同じ。

[^int]:
    \\( \\oint(x) \\) は \\( x \\) の*整数部分*を表す。\\( a \\) を整数、\\( b \\) を \\( 0 \\) でない整数とすると、剰余演算と商の整数部分は、次の関係を満たす:

    $$
    a \\bmod b = a - \\oint \\left( \\frac{a}{b} \\right) b
    $$

    <i>拡張ユークリッドの互除法</i>の実装では、商と剰余の計算方法を、この関係を満たすやうに選択する必要がある。例へば、CommonLisp で剰余演算に `(mod a b)` を用ゐるなら、整数商は `(floor (/ a b))` のやうにして計算されるべきだし、Dart で剰余演算に `a % b` を用ゐるなら、整数商は `b.sign * (a / b.abs()).floor()` のやうにして計算されるべきである。

<div class="indented">

  整数 \\( a, b \\) が与へられる。\\( x \\coloneqq 1, y \\coloneqq 0, x^\\prime \\coloneqq 0, y^\\prime \\coloneqq 1 \\) とする。\\( b = 0 \\) ならば3つ組 \\( \\left( a, x, y \\right) \\) を返却する。さもなければ、\\( a \\gets b, b \\gets a \\bmod b, x \\gets x^\\prime, x^\\prime \\gets x - \\oint \\left( \\frac{a}{b} \\right) x^\\prime, y \\gets y^\\prime, y^\\prime \\gets y - \\oint \\left( \\frac{a}{b} \\right) y^\\prime \\) とし、直前の手順に戻って続ける。

</div>

``` ts
function extGcd(a: number, b: number): { gcd: number; x: number; y: number } {
  let x = 1, y = 0, sx = 0, sy = 1

  while (b !== 0) {
    const q = Math.trunc(a / b)

    ;[a, b] = [b, a % b]
    ;[x, sx] = [sx, x - q * sx]
    ;[y, sy] = [sy, y - q * sy]
  }

  return { gcd: a, x, y }
}
```

宣言的には斯う:

<div class="indented">

  \\( a, b \\) を整数とする。このとき、求めるべき3つ組は、\\( b = 0 \\) ならば \\( \\left( a, 1, 0 \\right) \\) であり、さもなければ、\\( b \\) と \\( a \\bmod b \\) について、このアルゴリズムを再帰的に適用し、得られた3つ組を \\( \\left( gcd, x^\\prime, y^\\prime \\right) \\) として、\\( \\left( gcd, y^\\prime, x^\\prime - \\oint \\left( \\frac{a}{b} \\right) y^\\prime \\right) \\) である。

</div>

<a id="non-tail-extgcd"></a>

``` ts
function extGcd(a: number, b: number): { gcd: number; x: number; y: number } {
  if (b === 0) {
    return { gcd: a, x: 1, y: 0 }
  } else {
    const { gcd, x: sx, y: sy } = extGcd(b, a % b)

    return { gcd, x: sy, y: sx - Math.trunc(a / b) * sy }
  }
}
```

### 証明

停止性
: [ユークリッドの互除法の証明](#証明)に同じ。

正当性
: とくに上の再帰的アルゴリズムについて、

  1.  \\( b \\ne 0 \\) のとき、このアルゴリズムが求める整数解のペアは、\\( b x^\\prime + r y^\\prime = \\gcd(b, r) \\) となる \\( x^\\prime, y^\\prime \\) を用ゐて、\\( \\left( y^\\prime, x^\\prime - \\oint \\left( \\frac{a}{b} \\right) y^\\prime \\right) \\) と表される。このとき、

      $$
      \\begin{align*}
      ax + by
        & = \\left( \\oint \\left( \\frac{a}{b} \\right) b + r \\right) y^\\prime + b \\left( x^\\prime - \\oint \\left( \\frac{a}{b} \\right) y^\\prime \\right) \\\\
        & = \\oint \\left( \\frac{a}{b} \\right) b y^\\prime + r y^\\prime + b x^\\prime - \\oint \\left( \\frac{a}{b} \\right) b y^\\prime \\\\
        & = r y^\\prime + b x^\\prime \\\\
      \\end{align*}
      $$

      であり、また、[ユークリッドの互除法の証明](#証明)より、\\( \\gcd(a, b) = \\gcd(b, r) \\) であるから、*この変換は妥当である*。

  2.  \\( b = 0 \\) のとき、このアルゴリズムが求める整数解のペアは \\( \\left( 1, 0 \\right) \\) である。\\( b = 0 \\) となる*直前*の反復を考へる。すなはち、\\( x_p \\coloneqq y, y_p \\coloneqq x - \\oint \\left( \\frac{a_p}{a} \\right) y \\) とおき、\\( a_p \\bmod a = b = 0 \\) とする。また、こゝでは、\\( a_p \\ne 0 \\) とする。このとき、\\( \\gcd(a_p, a) = a \\) なので、\\( a_p x_p + a y_p = a \\) であり、係数比較によって、\\( x_p = y = 0, y_p = x - \\oint \\left( \\frac{a_p}{a} \\right) y = x = 1 \\) を得る。したがって、*この基礎ケースは妥当である*。

  3.  また、\\( a, b \\ne 0 \\) の場合、このアルゴリズムが求める整数解 \\( \\left( x, y \\right) \\) は、\\( \\left\| x \\right\| \\leq \\left\| \\frac{b}{\\gcd(a, b)} \\right\|, \\left\| y \\right\| \\leq \\left\| \\frac{a}{\\gcd(a, b)} \\right\| \\) を満たす。\\( a > b > 1, \\gcd(a, b) = 1 \\) の場合について、これを**略証**する。今、[ユークリッドの互除法の停止性の証明](#証明)と同様に、<i>EEA</i> の再帰的アルゴリズムが、適用過程が保存されるやうに変更された[^modified-eea-algorithm]とすると、数列 \\( \\bm{x_k}, \\bm{y_k} \\) の項は、\\( r_{k_t} = \\gcd(a, b) \\) となる \\( k_t \\) を用ゐて、
      
      $$
      \\begin{alignat*}{2}
      & x_{k} && = \\begin{cases}
        1         & \\text{if } k = k_t, \\\\
        y_{k + 1} & \\text{otherwise}, \\\\
        \\end{cases} \\\\
      & y_{k} && = \\begin{cases}
        0         & \\text{if } k = k_t, \\\\
        x_{k + 1} - \\oint \\left( \\frac{r_k}{r_{k + 1}} \\right) y_{k + 1} 
                  & \\text{otherwise}. \\\\
        \\end{cases} \\\\
      \\end{alignat*}
      $$
      
      と表せる。また、\\( k \\leq k_t \\) となるやうな任意の \\( k \\in \\N \\) について、\\( r_k > 0, r_{k} x_{k} + r_{k + 1} y_{k} = 1 \\) である。こゝで、述語 \\( \\varphi(n) \\) を次のやうに定義する:

      $$
      \\varphi(n) \\colon \\quad \\left\| x_n \\right\| \\leq r_{n + 1}, \\left\| y_n \\right\| \\leq r_n
      $$

      このとき、

      1.  \\( \\varphi(k_t - 2) \\) は、\\( x \\) に関する条件は、

          $$
          \\begin{align*}
          & \\phantom{\\iff} \\left\| x_{k_t - 2} \\right\| \\leq r_{k_t - 1} \\\\
          &           \\iff  \\left\| y_{k_t - 1} \\right\| \\leq r_{k_t - 1} \\\\
          &           \\iff  \\left\| x_{k_t} - \\oint \\left( \\frac{r_{k_t - 1}}{r_{k_t}} \\right) y_{k_t} \\right\| \\leq r_{k_t - 1} \\\\
          &           \\iff  1 \\leq r_{k_t - 1}
          \\end{align*}
          $$

          なので、真であり、\\( y \\) に関する条件は、

          $$
          \\begin{align*}
          & \\phantom{\\iff} \\left\| y_{k_t - 2} \\right\| \\leq r_{k_t - 2} \\\\
          &           \\iff  \\left\| x_{k_t - 1} - \\oint \\left( \\frac{r_{k_t - 2}}{r_{k_t - 1}} \\right) y_{k_t - 1} \\right\| \\leq r_{k_t - 2} \\\\
          &           \\iff  \\left\| y_{k_t} - \\oint \\left( \\frac{r_{k_t - 2}}{r_{k_t - 1}} \\right) y_{k_t - 1} \\right\| \\leq r_{k_t - 2} \\\\
          &           \\iff  \\oint \\left( \\frac{r_{k_t - 2}}{r_{k_t - 1}} \\right) \\leq r_{k_t - 2} \\\\
          \\end{align*}
          $$

          なので、真である。

      2.  \\( \\varphi(k) \\)、即ち、

          $$
          \\begin{align*}
          \\varphi(k) 
            & \\iff \\left\| x_k \\right\| \\leq r_{k + 1}, \\left\| y_k \\right\| \\leq r_k \\\\
          \\end{align*}
          $$

          のときについて考へる。まづ、\\( x_k = y_{k + 1} \\) なので、

          $$
          \\begin{align*}
          & \\phantom{\\iff} \\left\| y_k \\right\| \\leq r_k \\\\
          &           \\iff  \\left\| x_{k - 1} \\right\| \\leq r_{k} \\\\
          \\end{align*}
          $$

          である。また、もし \\( x_k > 0 \\) ならば、\\( -y_k \\leq r_k \\) なので、
          
          $$
          \\begin{align*}
          && \\phantom{\\iff}    & x_k \\leq r_{k + 1} \\\\
          &&           \\iff     & y_{k - 1} + \\oint \\left( \\frac{r_{k - 1}}{r_k} \\right) y_k \\leq r_{k - 1} - \\oint \\left( \\frac{r_{k - 1}}{r_k} \\right) r_k \\\\
          &&           \\iff     & y_{k - 1} \\leq r_{k - 1} - \\oint \\left( \\frac{r_{k - 1}}{r_k} \\right) (y_k + r_k) \\\\
          &&           \\implies & y_{k - 1} \\leq r_{k - 1} \\\\
          \\end{align*}
          $$

          である。\\( x_k < 0 \\) の場合も同様。したがって、\\( \\varphi(k) \\) ならば \\( \\varphi(k - 1) \\) である。

      よって、数学的帰納法により、\\( k \\leq k_t - 2 \\) であるやうな*任意の \\( k \\) について*、\\( \\varphi(k) \\)、すなはち、*\\( \\left\| x_k \\right\| \\leq r_{k + 1}, \\left\| y_k \\right\| \\leq r_k \\) である*。\\( \\qed \\)

[^modified-eea-algorithm]:
    参考までに、変更後のアルゴリズムの実装例を示す:

    ``` ts
    function extGcd(a: number, b: number): { gcd: number; x: number; y: number } {
      const rs = [a, b]
      const xs: number[] = []
      const ys: number[] = []

      function go(k = 0): { gcd: number; x: number; y: number } {
        if (rs[k + 1] === 0) {
          xs[k] = 1
          ys[k] = 0

          return { gcd: rs[k], x: xs[k], y: ys[k] }
        } else {
          rs[k + 2] = rs[k] % rs[k + 1]

          const { gcd, x: sx, y: sy } = go(k + 1)

          console.assert(sx === xs[k + 1])
          console.assert(sy === ys[k + 1])

          xs[k] = ys[k + 1]
          ys[k] = xs[k + 1] - Math.trunc(rs[k] / rs[k + 1]) * ys[k + 1]

          console.assert(rs[k] * xs[k] + rs[k + 1] * ys[k] === gcd)

          return { gcd, x: xs[k], y: ys[k] }
        }
      }

      return go()
    }
    ```

---

さて、冒頭でも述べたやうに、巷の <i>EEA</i> の実装はほとんど、ループによるものか、非末尾再帰によるものだ。これはなぜなのか。……といふところから筆を執った記事だったけれど、考へてみると、<i>EEA</i> は反復回数が非常に少ない[^k-supremum]ので、非末尾再帰であっても、さして問題にならなかったのだらう。

むしろ、非末尾再帰のアルゴリズムは、上の[変換の正当性の証明](#証明-1)の逆を示さうとするだけで、容易に導出できる[^eea-derivation]ので、<i>EEA</i> の変種の中でも、とくに覚えやすく、理解しやすい、良い変種である。したがって、非常に巨大な整数を扱はない限り[^rec-eea-segfault]、これを用ゐるのがベターだ。

[^eea-derivation]:
    \\( a \\) を整数、\\( b \\) を \\( 0 \\) でない整数とし、\\( r = a \\bmod b \\) とおくと、<i><ruby>ベズーの補題<rt lang="en">Bézout’s lemma</ruby></i>より、\\( ax + by = \\gcd(a, b) \\) を満たす \\( x, y \\) と、\\( b x^\\prime + r y^\\prime = \\gcd(b, r) \\) を満たす \\( x^\\prime, y^\\prime \\) がそれぞれ存在する。[ユークリッドの互除法の正当性の証明](#証明)より、\\( \\gcd(a, b) = \\gcd(b, r) \\) なので、\\( ax + by = b x^\\prime + r y^\\prime \\) である。こゝで、\\( a = \\oint \\left( \\frac{a}{b} \\right) b + r \\) を用ゐて、右辺から \\( r \\) を消去し、適当に整理すると、次のやうになり:

    $$
    \\begin{align*}
    ax + by 
      & = b x^\\prime + r y^\\prime \\\\
      & = b x^\\prime + \\left( a - \\oint \\left( \\frac{a}{b} \\right) b \\right) y^\\prime \\\\
      & = b x^\\prime + a y^\\prime - \\oint \\left( \\frac{a}{b} \\right) b y^\\prime \\\\
      & = a y^\\prime + b \\left( x^\\prime - \\oint \\left( \\frac{a}{b} \\right) y^\\prime \\right) \\\\
    \\end{align*}
    $$

    係数比較によって、\\( x = y^\\prime, y = x^\\prime - \\oint \\left( \\frac{a}{b} \\right) y^\\prime \\) を得る。

[^rec-eea-segfault]: Boost.Multiprecision の `checked_cpp_int` を用ゐて、手元で実験したところ、スタックサイズが 8 MiB なら、最初の呼び出しを含めて、47635回の再帰呼び出しが可能だった。それ以上は [segfault]{lang=en} となった。47636番目のフィボナッチ数は、\\( 96771159739 \\cdots \\) と続く9955桁の数なので、引数が \\( \\lfloor \\frac{9955}{\\log_{10} 2} \\rfloor = 33069 \\) ビットに収まるならば、非末尾再帰のアルゴリズムで計算できるといふことになる。あるいは、スタックサイズが 1 MiB なら、1245桁、4135ビット程度。

といふわけで、<i>EEA</i> を末尾再帰で実装する動機はもはやほとんど無いのだけれど、冒頭でも嘆じたやうに、<i><b>私は</b>末尾再帰で書きたい</i>。そこで、上の[非末尾再帰実装](#non-tail-extgcd)を末尾再帰に書き換へる手順を<b>いくらか丁寧に</b>説明する。まづ、非末尾再帰実装を再掲する:

``` ts
function extGcd(a: number, b: number): { gcd: number; x: number; y: number } {
  if (b === 0) {
    return { gcd: a, x: 1, y: 0 }
  } else {
    const { gcd, x: sx, y: sy } = extGcd(b, a % b)

    return { gcd, x: sy, y: sx - Math.trunc(a / b) * sy }
  }
}
```

非末尾再帰実装を末尾再帰に書き換へる基本的な方針は、*計算結果の累積値を引数として連れ回し、基礎ケースに到達したら、その値を返す*といふものである。シグネチャと基礎ケースは次のやうになる:

``` ts
function extGcd(a: number, b: number, x = 1, y = 0): { gcd: number; x: number; y: number } {
  if (b === 0) {
    return { gcd: a, x, y }
  } else {
    throw new Error('Unimplemented!')
  }
}
```

`extGcd(a, 0)` の結果が変はってはならないため、これらの引数のデフォルト値は、<i>非末尾再帰において、基礎ケースで返却してゐた値</i>と同一となる。

<!-- こゝで、*累積値*について整理しておく。よく誤解されてゐることだが、<i>EEA</i> や階乗、フィボナッチ数といった、非末尾再帰で<i>自然に</i>実装されるアルゴリズムの、累積値による末尾再帰実装が積み上げる累積値が表すものは、最後に返却される値を除いて、計算の途中結果であって、より小さい \\( n \\) に関する計算結果ではない。階乗の実装が2つある:

``` ts
function factorial(n: number): number {
  if (n === 0) return 1
  else return n * factorial(n - 1)
}
```

``` ts
function factorial(n: number, acc = 1): number {
  if (n === 0) return acc
  else return factorial(n - 1, n * acc)
}
``` -->

<!-- これらの関数をそれぞれ、`factorial(5)` として実行すると、前者は、スタックを

1. `factorial(5)`
2. `5 * factorial(4)`
3. `5 * (4 * factorial(3))`
4. `5 * (4 * (3 * factorial(2)))`
5. `5 * (4 * (3 * (2 * factorial(1))))`
6. `5 * (4 * (3 * (2 * (1 * factorial(0)))))`

となるまで積み上げた後、

7. `5 * (4 * (3 * (2 * (1 * 1))))`
8. `5 * (4 * (3 * (2 * 1)))`
9.  `5 * (4 * (3 * 2))`
10. `5 * (4 * 6)`
11. `5 * 24`
12. `120`
 -->

次に、再帰ステップについて考へる。非末尾再帰ではかうなってをり:

``` ts
const { gcd, x: sx, y: sy } = extGcd(b, a % b)

return { gcd, x: sy, y: sx - Math.trunc(a / b) * sy }
```

<!-- 

また、末尾再帰実装は、再帰呼び出しの結果をそのまゝ返却するので、再帰プロセスが終了するまでの間、一貫して、同じ値を返しつゞけるはずだ。したがって、`extGcd` の再帰呼び出しに用ゐる、新たな `x` `y` を `px` `py` とすると、これらの変数は、`extGcd(a, b, x, y) === extGcd(b, a % b, px, py)` を満たすことになる。

さて、基礎ケースで `x` `y` を返却することにしたので、 -->

<!-- この実装の 5–7 行目では、 -->

1.  `extGcd` を再帰呼び出しして、返却値を `sx` `sy` に分割代入し、
2.  `sx` `sy` を使って、`x` `y` の値を計算し、
3.  `x` `y` を返却してゐる。

この過程が区別できるやうに書き直すと、次のやうになる

``` ts
const { gcd, x: sx, y: sy } = extGcd(b, a % b)

const x = sy
const y = sx - Math.trunc(a / b) * sy

return { gcd, x, y }
```

末尾再帰では、*再帰呼び出しの結果がそのまゝ返却される*のだから、`x` `y` の値の計算は、再帰呼び出しよりも上で行はれるはずだ。順序を入れ替へてみよう:

``` ts
const x = sy
const y = sx - Math.trunc(a / b) * sy

const { gcd, x: sx, y: sy } = extGcd(b, a % b)

return { gcd, x, y }
```

さうすると、<i lang="en">Variable 'sx' is used before being assigned. (2454)</i> などのエラーが報告される。これを解決するには、`sx` `sy` をより早く割り当てる必要があるのだけれど、`x` `y` の値の計算よりも上で `extGcd` を呼び出すことはできない。そこで、その場で計算する代はりに、現在の `extGcd` を呼び出すときに、こゝで必要になる `sx` `sy` を豫め計算しておき、それを引数として受け取ることにしよう。

首尾よく `extGcd` が `sx` `sy` を受け取ったとする。このとき、非末尾再帰のときと変はらず、次の等式が全て満たされてゐるはずだ:

- `x === sy`
- `y === sx - Math.trunc(a / b) * sy`
- `a * x + b * y = gcd(a, b)`

したがって、新しい `extGcd` の実装の初めの方、とくに再帰の基礎ケースは、大凡、次のやうになる:

``` ts
function extGcd(a: number, b: number, sx: number, sy: number): { gcd: number; x: number; y: number } {
  if (b === 0) {
    return { gcd: a, x: sy, y: sx - Math.trunc(a / b) * sy }
  } else {
    throw new Error('Unimplemented!')
  }
}
```

零除算が含まれてゐるのが見て取れよう。したがって、`b === 0` の場合、`sx` `sy` から `x` `y` を逆算することはできない。代はりに、現在の `x` `y` の値も引数として受け取り、これをそのまゝ返却することにする:

``` ts
function extGcd(a: number, b: number, x: number, y: number, sx: number, sy: number): { gcd: number; x: number; y: number } {
  if (b === 0) {
    return { gcd: a, x: sy, y: sx - Math.trunc(a / b) * sy }
  } else {
    throw new Error('Unimplemented!')
  }
}
```

、次の `extGcd` の呼び出しで計算されて、`x` `y` として返却されるものであるから、`a % b` の結果が `0n` かどうかによって、
また、この変換プロセスにあたって、

現在の反復で必要になる `sx` `sy`、すなはち、次の `x` `y` は、前回の反復から見れば、*次の次*の `x` `y` であるから、これを計算する方法を確立

数列 \\( \\bm{x_k}, \\bm{y_k} \\) の項は、次のやうな連立漸化式で記述された:

$$
\\begin{alignat*}{2}
& x_{k} && = \\begin{cases}
  1         & \\text{if } k = k_t, \\\\
  y_{k + 1} & \\text{otherwise}, \\\\
  \\end{cases} \\\\
& y_{k} && = \\begin{cases}
  0         & \\text{if } k = k_t, \\\\
  x_{k + 1} - \\oint \\left( \\frac{r_k}{r_{k + 1}} \\right) y_{k + 1} 
            & \\text{otherwise}. \\\\
  \\end{cases} \\\\
\\end{alignat*}
$$

こゝで、\\( k_t \\) は、\\( r_{k_t} = \\gcd(a, b) \\) となるやうな整数 \\( k_t \\) であった。

``` ts
function extGcd(a: number, b: number, sx: number, sy: number): { gcd: number; x: number; y: number } {
  if (b === 0) {
    return { gcd: a, x: 1, y: 0 }
  } else {
    const x = sy
    const y = sx - Math.trunc(a / b) * sy

    const { gcd, x, y } = extGcd(b, a % b)

    return { gcd, sx, sy }
  }
}
```

`extGcd` を再帰呼び出しして、その結果を使って、次の \\( \\left( x, y \\right) \\) を計算してゐる。
