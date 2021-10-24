---
title: ソフトウェアテストの健全性と完全性
vertical: false
date: 2021-10-24
---

製品にバグがあれば必ず失敗するテストを健全なテスト、バグが無ければ必ず通過するテストを完全なテストと言ふ。例へば、

``` ts
function testF1() {
  throw new Error()
}
```

は健全なテスト、

``` ts
function testF2() {
}
```

は完全なテストである。

---

テストは、形式的に言へば、製品の妥当な入出力が実際に妥当であることを証明する手続きである。例へば、恒等関数

``` ts
function identity(x: number) {
  return x
}
```

の妥当な入出力は

- (0, 0)
- (1, 1)

などであり、これらの妥当性は

``` ts
import assert from 'assert'

interface IdentityFunction {
  (x: number): number
}

function testIdentity1(sut: IdentityFunction) {
  assert(sut(0) === 0)
  assert(sut(1) === 1)
}
```

といふふうにして証明できる。

`testIdentity1` は、

``` ts
testIdentity1(identity) // will be passed
```

のやうに製品にバグが無ければ通過するので完全だが、

``` ts
function wrongIdentity(x: number) {
  if (x === 54) return 42

  return x
}

testIdentity1(wrongIdentity) // will be passed
```

のやうにバグがあっても通過することがあるので健全ではない。

---

健全なテストは、

- 全ての妥当な入出力の妥当性を証明するか、さもなくば
- 失敗する。

`identity` のやうな小さな関数であっても、全ての妥当な入出力の妥当性を証明するには、家庭用 PC で数百万年から数億年、スーパーコンピューターでも数分から数時間を要するので、普通のソフトウェアのために健全なテストが書かれることはほゞ無い。

---

製品を実行する直前の<i>環境</i>や実行手順などを入力に含め、製品を実行した直後の<i>環境</i>や、例外を投げること、停止性などを出力に含めれば、<b>製品の実行に関しては</b>、全ての妥当な入出力が実際に妥当であることゝバグが無いことは同値と言へる。

<i>環境</i>にはコンピューターの内部状態（とくに製品の実行可能ファイルや、処理系、設定、永続化されたデータなど）や外の状態（ハードウェア、気温、湿度、……、全ての素粒子の状態）を含めることもできる。また、一般に停止性問題は解けない。
