---
title: 浮動小数点数の比較と NaN のビットパターンの話
date: 2024-09-03
useKaTeX: true
---

IEEE 754 binary64 ビット列が示す値は、符号ビットを \\( s \\)、指数部を \\( e \\)、仮数部を \\( m \\) として、次の関数 \\( v(s ,\\, e ,\\, m) \\) で表される:

$$
\\begin{align*}
v(s ,\\, e ,\\, m) = 
\\begin{cases}
  (-1)^s \\left( 1 + \\frac{m}{2^{52}} \\right) 2^{e - 1023} & \\text{if } 0 < e < 2047 \\\\
  (-1)^s \\left( 0 + \\frac{m}{2^{52}} \\right) 2^{-1022} & \\text{if } e = 0 \\\\
  +\\infin & \\text{if } s = 0 ,\\, e = 2047 \\text{ and } m = 0 \\\\
  -\\infin & \\text{if } s = 1 ,\\, e = 2047 \\text{ and } m = 0 \\\\
  \\mathrm{NaN} & \\text{if } e = 2047 \\text{ and } m \\ne 0 \\\\
\\end{cases} \\\\
\\end{align*}
$$

このとき、\\( \\mathrm{NaN} \\) 以外の値は、\\( s ,\\, e ,\\, m \\) の順に比較することで、簡単に大小比較できる:

``` ts
class Binary64 {
  constructor(
    private sign: bigint, 
    private exponent: bigint, 
    private mantissa: bigint
  ) {
    console.assert(sign === ((1n << 1n) - 1n & sign))
    console.assert(exponent === ((1n << 11n) - 1n & exponent))
    console.assert(mantissa === ((1n << 52n) - 1n & mantissa))
  }

  lt(this: Binary64, that: Binary64): boolean {
    if (this.sign > that.sign) return true
    if (this.sign < that.sign) return false

    const gt0 = this.sign === 0n

    if (this.exponent < that.exponent) return gt0
    if (this.mantissa < that.mantissa) return gt0

    return false
  }
}
```

\\( \\mathrm{NaN} \\) をこの方法で大小比較しようとすると、ビット列が \\( s = 1 \\) のものは \\( -\\infin \\) よりも小さい値を示し、\\( s = 0 \\) のものは \\( +\\infin \\) よりも大きい値を示す。そのやうな数は存在しないので、*\\( \\mathrm{NaN} \\) は大小比較できない*と言へる。\\( \\mathrm{NaN} \\) のビットパターンが複数あって、しかも無限大よりも外側に設定されてゐるのは、一つには、この性質が必要だったからではないだらうか。
