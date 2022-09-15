---
title: シェルスクリプト・ベタープラクティス
date: 2022-06-12
lastmod: 2022-07-20
vertical: false
---

自分用のメモ。

## 引用部分の凡例

- 文脈上不要なリンクは削除した。
- [マーク]{.mark-like}を施した箇所がある。

---

## 文字符号化スキーム

シェルスクリプトは *UTF-8（BOM 無し）で保存する*。シェルはファイルの先頭の EF BB BF を BOM として解釈できず、そのまゝトークン化してしまふ。例へば、

*[BOM]: Byte Order Mark

``` sh:okbom.sh
() {
	echo OK
}

﻿ # こゝに EF BB BF がある。
```

を UTF-8（BOM 附き）で保存して Bash で[^1]実行すると、`OK` と印字される。

[^1]: [Shebang]{lang=en} が無いので、現在のシェルで実行される。Bourne Shell では関数名は `[A-Z_a-z][0-9A-Z_a-z]*` (ERE) に従ふので、BOM は関数名にならない。

## 改行コード

シェルの*改行コードは LF (U+000A)* である。CR はほゞ本来の意味で使はれる[^2]。

[^2]:
    [3.86 Carriage-Return Character (\<carriage-return\>)](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_86){lang=en} には

    <div class="blockquote-like">

      出力ストリームで、キャリッジリターンが現れたのと同じ物理行の先頭から印字が始まるといふことを示す文字。[C]{.upright} 言語では `'\r'` で示される文字である。この文字が行の先頭への移動を達成するためにシステムが出力デバイスに送信する正確なシーケンスであるかどうかは<ruby>規定されてゐない<rt lang="en">unspecified</ruby>。

    </div>

    +++ 原文
    <blockquote lang="en">

      A character that in the output stream indicates that printing should start at the beginning of the same physical line in which the carriage-return occurred. It is the character designated by `'\r'` in the C language. It is unspecified whether this character is the exact sequence transmitted to an output device by the system to accomplish the movement to the beginning of the line.

    </blockquote>
    +++

    とある。

## 字下げ

*TAB (`	`; U+0009) と空白 (` `; U+0020) を混在させない*。既存のファイルを{編輯|へん|しふ}するときは元の方法に従ふ。その他の場合は *TAB を使ふ*。

字下げに TAB を使ってゐる場合、リダイレクト演算子に `<<-` を使へば、出力の行頭に TAB がある場合を除いて、ほとんどの場面でヒアドキュメントがインデントできる[^3]。空白を使ってゐる場合は、ヒアドキュメントのインデントを取り除かなければならず、ヒアドキュメントが忌避されて、代はりに無駄な一時ファイルや `echo` などが使はれるおそれがある。

[^3]:
    [2.7.4 Here-Document](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_04){lang=en} には

    <div class="blockquote-like">

      リダイレクト演算子が `"<<-"` なら、入力行と、末尾の区切り文字がある行から、全ての行頭の \<tab\> 文字が取り除かれる。

    </div>

    +++ 原文
    <blockquote lang="en">

      If the redirection operator is `"<<-"`, all leading \<tab\> characters shall be stripped from input lines and the line containing the trailing delimiter.

    </blockquote>
    +++

    とある。

## 終了ステータス

*終了ステータスをよく設計する*。失敗を全て[1]{.upright}にするのはコードスメルである。[0]{.upright}と[1]{.upright}しか使ってゐない場合、失敗の種類を区別するために不要なパラメーターや、一時ファイル、標準入出力などを経由するはめになる。

### 使用できる値

通常、*終了ステータスに使用できる値は[0]{.upright}から[127]{.upright}まで*ゞある。[126]{.upright}はコマンド名は見付かったが、実行可能なユーティリティでなかったときに使ひ、[127]{.upright}はコマンドが見付からなかったときに使ふ[^4]。[128]{.upright}は使はない[^5][^6]。[128]{.upright}より大きな値は、シグナルを受け取って終了したことを表す[^7]ので、他の用途では使はない。

[^4]:
    [2.8.2 Exit Status for Commands](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#){lang=en} には

    <div class="blockquote-like">

      コマンドが見付からなかった場合、終了ステータスは[127]{.upright}となる。コマンド名は見付かったが、実行可能なユーティリティではなかった場合、終了ステータスは[126]{.upright}となる。シェルを使はずにユーティリティを呼び出すアプリケーションは、同様のエラーを報告するためにこれらの終了ステータスを使ふべきである。

    </div>

    +++ 原文
    <blockquote lang="en">

      If a command is not found, the exit status shall be 127. If the command name is found, but it is not an executable utility, the exit status shall be 126. Applications that invoke utilities without using the shell should use these exit status values to report similar errors.

    </blockquote>
    +++

    とある。

[^5]:
    [128]{.upright}は、シグナル番号が[0]{.upright}のシグナルを受け取って終了したときに<u>返される</u>。[kill](https://pubs.opengroup.org/onlinepubs/9699919799/functions/kill.html){lang=en} には

    <div class="blockquote-like">

      <i>sig</i> が[0]{.upright}（null シグナル）の場合、エラーチェックは実行されるが、シグナルは実際には送信されない。null シグナルは <i>pid</i> の妥当性を調べるために使はれることがある。

    </div>

    +++ 原文
    <blockquote lang="en">

      If <i>sig</i> is 0 (the null signal), error checking is performed but no signal is actually sent. The null signal can be used to check the validity of <i>pid</i>.

    </blockquote>
    +++

    とあり、実際には使はれない。

[^6]:
    [Appendix E. Exit Codes With Special Meanings](https://tldp.org/LDP/abs/html/exitcodes.html){lang=en} には

    <div class="blockquote-like" lang="en">

    | Exit Code Number   | Meaning                  | Example      | Comments                                                                      |
    |:-------------------|:-------------------------|:-------------|:------------------------------------------------------------------------------|
    | 128                | Invalid argument to exit | exit 3.14159 | <b>exit</b> takes only integer args in the range 0 - 255 (see first footnote) |
    | 255*               | Exit status out of range | exit -1	     | <b>exit</b> takes only integer args in the range 0 - 255                      |

    </div>

    とある（行を抜粋した。）が、実際は `exit 3.14159` を実行すると[255]{.upright}が返る。また、`exit -1` を実行すると[255]{.upright}が返るのは、[-1]{.tate-chu-yoko} の下位[8]{.upright}ビットが返されてゐる（この振る舞ひは<ruby>未規定<rt lang="en">unspecified</ruby>[^9]。）だけである。

[^7]:
    [2.8.2 Exit Status for Commands](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_02){lang=en} には

    <div class="blockquote-like">

      シグナルを受け取ったせゐで終了したコマンドの終了ステータスは[128]{.upright}より大きいものとして報告される。

    </div>

    +++ 原文
    <blockquote lang="en">

      The exit status of a command that terminated because it received a signal shall be reported as greater than 128.

    </blockquote>
    +++

    とある。

### 設計方法

設計方法としては、まづ、POSIX のビルトインや標準ユーティリティに倣ふのが良い。例へば、

- `sh` や `nice` などのユーティリティを実行するユーティリティは、実行するユーティリティが[126]{.upright}や[127]{.upright}を返すやうな場合、その値をそのまゝ返す。
- `test` や `grep` などの真偽値を返すユーティリティは、真を[0]{.upright}、偽を[1]{.upright}で表す。
- `expr` の[1]{.upright}と[2]{.upright}や `tty` の[1]{.upright}などのやうに、エラーではない失敗が規定されてゐる場合は、[1]{.upright}から順に消費する。

BSD 系の sysexits.h[^8] に従ふのも良い習慣だと思ふ。

[^8]: [sysexits(3)](https://www.freebsd.org/cgi/man.cgi?query=sysexits&manpath=FreeBSD+13.0-RELEASE+and+Ports){lang=en}

---

因みに、ほとんどの実装で、`exit` や `return` に範囲外の値を渡すと下位[8]{.upright}ビットがそのまゝ返されるが、この動作は<ruby>未規定<rt lang="en">unspecified</ruby>である[^9]。

[^9]:
    [return](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#return){lang=en} と [exit](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#exit){lang=en} にはそれぞれ

    > If n is not an unsigned decimal integer, or is greater than 255, the results are unspecified.
    {lang=en}

    > If n is specified, but its value is not between 0 and 255 inclusively, the exit status is undefined.
    {lang=en}

    とある。

## [Shebang]{lang=en}

シェルスクリプトは *[Shebang]{lang=en} で書きはじめる*。[Shebang]{lang=en} は、UNIX で、実行するファイルのインタープリターを指定する方法である。

古い実装では [Shebang]{lang=en} `#!` の右側全部がコマンドインタープリターの名前として使はれた[^10]。よって、移植可能性を重視するときは、[Shebang]{lang=en} は、

``` sh
#!/bin/sh
```

といふゝうに書く。

[^10]:
    [exec](https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html){lang=en} には

    <div class="blockquote-like">

      いくつかの歴史的な実装がシェルスクリプトを処理する方法は、そのファイルの最初の[2]{.upright}バイトが文字列 `"#!"` であることを認識すると、そのファイルの最初の行の残りを、実行するコマンドインタープリターの名前として使ふといふものである。

    </div>

    +++ 原文
    <blockquote lang="en">

      Another way that some historical implementations handle shell scripts is by recognizing the first two bytes of the file as the character string `"#!"` and using the remainder of the first line of the file as the name of the command interpreter to execute.

    </blockquote>
    +++

    とある。

FreeBSD、Linux、Max OS X、Cygwin を含むほとんどの OS は引数が[1]{.upright}つだけなら同様に解釈する[^11]ので、

[^11]: [The #! magic, details about the shebang/hash-bang mechanism on various Unix flavours](https://www.in-ulm.de/~mascheck/various/shebang/){lang=en} を参照。

``` sh
#!/bin/sh -eu
```

としても大抵は問題無い。

たゞし、*`env` を使って `$PATH` の `sh` を使はうとするのはやめた方が良い*。`env` の場所が変はることもあるし、別のプログラムによって `$PATH` が書き換へられてゐることもある[^12]。

[^12]: 例へば、`sh` が空ファイルに差し替へられると、[Shebang]{lang=en} に `env` を使ってゐるプログラムは動作しなくなる。脆弱性のある `sh` がインストールされるとさらに悪いことが起こる。念のために附け加へると、`$PATH` が書き換へられたり、さういふ `sh` がインストールされたりしてゐる時点で、サーバーにログインされたり、不審なプログラムを自ら実行したりしてゐるはずなので、`env` 自体が脆弱といふわけではない。

Bourne Shell 以外のシェルを使ひたいときはさうしてもよい。この文章では主に Bourne Shell について書き、時々 Bash に触れる。Bash を使ふ場合、[Shebang]{lang=en} は、

``` sh
#!/bin/bash
```

または

``` sh
#!/bin/bash -eu
```

とする。

## シェルオプション

`set` ビルトインを使ふと、シェルオプションが設定できる。`errexit`[^13] と `nounset`[^14] は最初に有効にする:

[^13]:
    [set](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#set){lang=en} には

    <div class="blockquote-like">

      このオプションが有効な場合、（<ruby>[シェルエラーの結果](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_01)<rt lang="en">Consequences of Shell Errors</ruby>に列挙されてゐる理由のいづれかで、あるいは[0]{.upright}より大きな終了ステータスの返却によって、）コマンドが失敗すると、シェルが即座に終了する。

    </div>

    +++ 原文
    <blockquote lang="en">

      When this option is on, when any command fails (for any of the reasons listed in [Consequences of Shell Errors](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_01) or by returning an exit status greater than zero), the shell immediately shall exit,

    </blockquote>
    +++

    とある。

[^14]:
    [set](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#set){lang=en} には

    <div class="blockquote-like">

      シェルが<ruby>未定義の<rt lang="en">unset</ruby>パラメーター（`'@'` 特殊パラメーターと `'*'` 特殊パラメーターは除く。）を展開しようとすると、標準エラーにメッセージが書き込まれ、<ruby>[シェルエラーの結果](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_01)<rt lang="en">Consequences of Shell Errors</ruby>にある結果で展開が失敗する。

    </div>

    +++ 原文
    <blockquote lang="en">

      When the shell tries to expand an unset parameter other than the `'@'` and `'*'` special parameters, it shall write a message to standard error and the expansion shall fail with the consequences specified in [Consequences of Shell Errors](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_01).

    </blockquote>
    +++

    とある。

``` sh
set -eu
```

Bash では `pipefail`[^15] を有効にしてもよい:

[^15]:
    [Chapter 33. Options](https://tldp.org/LDP/abs/html/options.html){lang=en} に:

    <div class="blockquote-like">

      パイプラインに、[0]{.upright}以外の返り値を返したパイプ内の最後のコマンドの終了ステータスを返させる。

    </div>

    +++ 原文
    <blockquote lang="en">

      Causes a pipeline to return the exit status of the last command in the pipe that returned a non-zero return value.

    </blockquote>
    +++

``` sh
set -eu -o pipefail
```

たゞし、これを立てたせゐで `|| true` みたいなバッドイディオムが横行するやうなら、使はない方が良い。

### 一時的な変更

オプションを一時的に変更したいときは、

``` sh
reset_cmd=$(set +o)
set +e
false
eval "$reset_cmd"
```

のやうにする。Bash ではうまくいかないので、一時ファイルを使ふ:

``` sh
reset=/tmp/reset_$(date +%s)
set +o >"$reset"
set +e
false
. "$reset"
```

一時ファイルや `eval` `.` は普通は使はない。この節は例外。必要なら `/dev/urandom` や `mktemp` などを使ってもよい。

## ファイルモード作成マスク

*ファイルやディレクトリを作成するときは、事前にファイルモード作成マスクを設定する*。

``` sh
umask go-w
```

とするか、機密ファイルを扱ふ場合は、

``` sh
umask go-rw
```

とする。ファイルモード作成マスクが 022 未満の環境でファイルを作成すると、作成してからファイルモードを変更するまでの間にファイルが改竄されるおそれがある。

### 一時的な変更

ファイルモード作成マスクを一時的に変更したいときは、

``` sh
current_umask=$(umask -S)
umask go-rw
echo "anon:bad password" >credentials
umask "$current_umask"
```

のやうにする。

## trap

`trap` 特殊ビルトインを使ふと、シグナルをトラップすることができる。例へば、一時ファイルを掃除するには、

``` sh
cleanup() {
	rm "$tmpfile"
}

trap cleanup EXIT

tmpfile=$(mktemp)
```

のやうにする[^16]。

[^16]: `mktemp` は POSIX には含まれてゐない。

トラップアクションはシグナルごとに[1]{.upright}つしか設定できない[^17]。例へば、

[^17]:
    [trap](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap){lang=en} には

    <div class="blockquote-like">

      *trap* のアクションは前のアクション（デフォルトのアクションと明示的に設定されたアクションのどちらか）をオーバーライドする。

    </div>

    +++ 原文
    <blockquote lang="en">

      The action of *trap* shall override a previous action (either default action or one explicitly set).

    </blockquote>
    +++

    とある。

``` sh
trap 'echo exit' EXIT SIGQUIT
trap 'echo quit' SIGQUIT
```

としてから SIGQUIT を受信すると、`quit` とだけ印字される。

複数のシグナルをトラップした場合のアクションの実行順序は<ruby>規定されてゐない<rt lang="en">unspecified</ruby>[^18]。

[^18]:
    [2.11. Signals and Error Handling](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_11){lang=en} には

    <div class="blockquote-like">

      {関聯|くゎん|れん}するトラップアクションのあるシェルに対して複数のシグナルが保留されてゐる場合、トラップアクションの実行の順序は<ruby>規定されない<rt lang="en">unspecified</ruby>。

    </div>

    +++ 原文
    <blockquote lang="en">

      If multiple signals are pending for the shell for which there are associated trap actions, the order of execution of trap actions is unspecified.

    </blockquote>
    +++

    とある。

SIGKILL や SIGSTOP はトラップできないことがある[^19]。よって、*実行しなければならないコマンドをトラップアクションにしてはならない*。

[^19]:
    [trap](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap){lang=en} には

    <div class="blockquote-like">

      SIGKILL や SIGSTOP へのトラップの設定は未定義の結果を生ずる。

    </div>

    +++ 原文
    <blockquote lang="en">

      Setting a trap for SIGKILL or SIGSTOP produces undefined results.

    </blockquote>
    +++

    とある。

### 一時的な変更

trap を一時的に変更したいときは、

``` sh
reset_trap=$(trap)
trap - EXIT
eval "$reset_trap"
```

のやうにする。`eval` は普通は使はない。この節は例外。

## 一時ファイル

*一時ファイルはなるべく使はない*。已むを得ないときは、以下のことに注意して使ふ。

ファイルを作成するよりも早く、ファイルモード作成マスクを 022 以上に設定する。[ファイルモード作成マスク](#ファイルモード作成マスク)も参照。

作成したファイルはシェルが終了するときに削除する[^20]。SIGKILL や SIGSTOP はトラップされないことがある。[trap](#trap) も参照。

[^20]: /tmp や /var/tmp に作成したものはそのまゝにしてもよいと思ふ。

## `eval`

*`eval` 特殊ビルトインはなるべく使はない*。已むを得ないときは、以下のことに注意して使ふ。

**ユーザーの入力を `eval` に渡してはならない**。他の多くのプログラミング言語の場合におけると同様に、ユーザーの入力を無害化せずに `eval` に渡すコマンドには、注入攻撃に対する脆弱性がある。例へば、

``` sh
read greeting
eval "echo \"$greeting\""
```

は、`"; ls #` と入力されると、作業ディレクトリの内容を印字してしまふ。

[シェルオプションの一時的な変更](#一時的な変更)や [trap の一時的な変更](#一時的な変更-2)のやうな場合は、決まった方法で使ふ。

## コマンド

シェルで実行可能な文をコマンドと言ふ。POSIX のコマンドは

- シンプルコマンド
- パイプライン
- リスト
- 複合コマンド
- 関数定義コマンド

の[5]{.upright}種類に分類されてゐる。

### シンプルコマンド

[0]{.upright}個以上の変数代入、[0]{.upright}個以上の入出力リダイレクト、省略可能なコマンド名、そして、コマンド名がある場合、[0]{.upright}個以上の引数を適当に組み合はせたものであって、空でないものゝことを*シンプルコマンド*と言ふ。変数代入はコマンド名の左側にあり、引数はコマンド名の右側にある[^46]。よって、次のやうなコード片もシンプルコマンドである:

[^46]: [2.9.1 Simple Commands](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01){lang=en} も参照。

``` sh
foo=1 bar=2
```

``` sh
>>a
```

``` sh
<<-EOD >cwd cat
	$PWD
EOD
```

コマンド名も単語展開されることに注意。つまり、

``` sh
cmd="ls /"
$cmd
```

とすると、`ls /` が実行される[^28]。*ユーザーの入力をコマンド名にしない*。

[^28]: 例ではフィールド分割も利用してゐる。

### パイプライン

[1]{.upright}つ以上のコマンドを `|` で繋ぎ、左端に省略可能な `!` を附け加へたものを、文法上、パイプラインと言ふ[^45]。

[^45]: [2.9.2 Pipelines](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_02){lang=en} を参照。

*while 文や for 文にパイプしない*。パイプラインの各コマンドはサブシェルで実行される[^30]から、パイプラインで実行される変数代入やビルトインコマンドは、現在の環境には影響しない[^31]。そのため、ファイルリストにある名前が `.` で始まるファイルの個数を数へるプログラム[^32]は、

[^30]:
    [2.12. Shell Execution Environment](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_12){lang=en} には

    <div class="blockquote-like">

      コマンド置換、丸括弧でグループされたコマンド、および非同期リストは、サブシェル環境で実行される。==加へて、複数コマンドのパイプラインの各コマンドも、サブシェル環境にある。たゞし、拡張機能として、パイプラインの一部または全部のコマンドが現在の環境で実行されてもよい==。他のコマンドは全て現在のシェル環境で実行される。

    </div>

    +++ 原文
    <blockquote lang="en">

      Command substitution, commands that are grouped with parentheses, and asynchronous lists shall be executed in a subshell environment. ==Additionally, each command of a multi-command pipeline is in a subshell environment; as an extension, however, any or all commands in a pipeline may be executed in the current environment==. All other commands shall be executed in the current shell environment.

    </blockquote>
    +++

    とある。

[^31]:
    サブシェルの挙動については、[2.9.4 Compound Commands](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_04){lang=en} や [2.12. Shell Execution Environment](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_12){lang=en} に

    <div class="blockquote-like">

      ( <i>compound-list</i> )
      : <i>compound-list</i> をサブシェル環境で実行する。[シェル実行環境](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_12){hreflang=en}を見よ。変数代入と環境に影響を与へるビルトインコマンドは、リストが終了した後も有効なまゝであってはならない。

    </div>

    +++ 原文
    <blockquote lang="en">

      ( <i>compound-list</i> )
      : Execute <i>compound-list</i> in a subshell environment; see [Shell Execution Environment](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_12). Variable assignments and built-in commands that affect the environment shall not remain in effect after the list finishes.

    </blockquote>
    +++

    <div class="blockquote-like">

      サブシェル環境は、無視されないシグナルトラップはデフォルトのアクションに設定されるといふことを除いて、シェル環境の複製として作られる。サブシェル環境に加へられた変更はシェル環境に影響しない。

    </div>

    +++ 原文
    <blockquote lang="en">

      A subshell environment shall be created as a duplicate of the shell environment, except that signal traps that are not being ignored shall be set to the default action. Changes made to the subshell environment shall not affect the shell environment.

    </blockquote>
    +++

    とある。

[^32]:
    別の実装:

    ``` sh
    while IFS= read file; do
    	case $file in
    		(.*) echo ;;
    	esac
    done </path/to/file | wc -l
    ```

    この方法なら while 文にパイプしてもうまく動く。たゞし、ファイルリストが{厖大|ばう|だい}になるにつれて、本文の方法よりも早くパフォーマンスが悪化する。

``` sh
count=0
cat /path/to/filelist | while IFS= read file; do
	case $file in
		(.*) (( ++count )) ;;
	esac
done
echo "$count"
```

と書くべきではない[^42]。代はりに、

[^42]:
    [2.12. Shell Execution Environment](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_12){lang=en} には

    <div class="blockquote-like">

      たゞし、拡張機能として、パイプラインの一部または全部のコマンドが現在の環境で実行されてもよい。

    </div>

    +++ 原文
    <blockquote lang="en">

      as an extension, however, any or all commands in a pipeline may be executed in the current environment.

    </blockquote>
    +++

    とあるため、シェルの実装によってはうまく動くこともある。

``` sh
count=0
while IFS= read file; do
	case $file in
		(.*) (( ++count )) ;;
	esac
done </path/to/filelist
echo "$count"
```

とするのが主流である。

ファイルの内容ではなく標準出力をループに渡したいときは、名前付きパイプを使ふ。例へば、作業ディレクトリにある名前が `.` で始まるファイルの個数を数へるプログラムは、

``` sh
umask go-w
trap "rm /tmp/filelist" EXIT
mkfifo /tmp/filelist
ls -Ap | grep -v /$ >/tmp/filelist &
count=0
while IFS= read file; do
	case $file in
		(.*) (( ++count )) ;;
	esac
done </tmp/filelist
echo "$count"
```

のやうに書く。

Bash ならプロセス置換を使って、

``` sh
count=0
while IFS= read file; do
	case $file in
		(.*) (( ++count )) ;;
	esac
done < <(ls -Ap | grep -v /$)
echo "$count"
```

としてもよい。

Bash 4.2 以上では、`lastpipe` オプションを使ふと、パイプラインの最後のコマンドを現在のシェルで実行することができる[^33]。

[^33]:
    [37.3. Bash, version 4](https://tldp.org/LDP/abs/html/bashver4.html){lang=en} には

    <div class="blockquote-like">

      `lastpipe` シェルオプションが設定されてゐる場合、パイプの最後のコマンドは*サブシェルで実行されない*。

    </div>

    +++ 原文
    <blockquote lang="en">

      When the `lastpipe` shell option is set, the last command in a pipe *doesn't run in a subshell*.

    </blockquote>
    +++

    とある。

通常のパイプラインの終了ステータスについては [2.9.2 Pipelines](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_02){lang=en} に

<div class="blockquote-like">

  ==パイプラインが{豫約|よ|やく}語 <b class="r upright">!</b> で始まらないなら、終了ステータスは、パイプラインで指定された最後のコマンドの終了ステータスとなる==。さうでなければ、終了ステータスは、最後のコマンドの終了ステータスの論理 NOT となる。つまり、最後のコマンドが[0]{.upright}を返せば終了ステータスは[1]{.upright}となり、最後のコマンドが[0]{.upright}より大きな値を返せば、終了ステータスは[0]{.upright}となる。

</div>

+++ 原文
<blockquote lang="en">

  ==If the pipeline does not begin with the <b class="r">!</b> reserved word, the exit status shall be the exit status of the last command specified in the pipeline==. Otherwise, the exit status shall be the logical NOT of the exit status of the last command. That is, if the last command returns zero, the exit status shall be 1; if the last command returns greater than zero, the exit status shall be zero.

</blockquote>
+++

とある。わざわざ<q lang="en">in the pipe</q>とか<q lang="en">specified in the pipeline</q>とか書かれてゐるのは、恐らく、時間的に最後に返された値を使ふのではなく、字句的に最後に書かれてゐるコマンドによって返された値を使ふといふことを明示してゐるのだと思ふ。

### 関数定義コマンド

*先頭に `function` を附けない*。POSIX の関数定義コマンドの構文は、

> <i>fname</i> ( ) <i>compound-command</i> [<i>io-redirect</i> ...]

である。引用元は [2.9.5 Function Definition Command](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_05){lang=en}。

本文にはブレースグループ[^34]以外の複合コマンドを使ふこともできる。例へば、サブシェルを使った

[^34]:
    複合リストを波括弧で囲んだもの。複合リストについては [2.9.3 Lists](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_03){lang=en} を引いておく:

    <div class="blockquote-like">

      「複合リスト」といふ用語は、[シェル文法](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_10){hreflang=en}にある文法に由来するもので、\<newline\> 文字で区切られた<i><ruby>リスト<rt lang="en">lists</ruby></i>のシーケンスであり、任意個数の \<newline\> 文字が先行し、または後続することができるものである。

    </div>

    +++ 原文
    <blockquote lang="en">

      The term "compound-list" is derived from the grammar in [Shell Grammar](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_10); it is equivalent to a sequence of <i>lists</i>, separated by \<newline\> characters, that can be preceded or followed by an arbitrary number of \<newline\> characters.

    </blockquote>
    +++

``` sh
oldpwd() (cd -)
```

のやうな関数[^35]や、while 文を使った

[^35]:
    別の実装:

    ``` sh
    oldpwd() {
    	echo ~-
    }
    ```

``` sh
yes() while :; do
	echo "${1-y}"
done
```

のやうな関数が書ける。

## 変数代入

シェルの変数代入はシンプルコマンドの一部で、コマンド名の左にあって、変数名の右に `=` と変数の値が続くものである。シンプルコマンドは[0]{.upright}個以上の変数代入を持つ。

コマンド名と引数は省略できるので、

``` sh
foo=1 bar=2
```

のやうに、[1]{.upright}つのコマンドで複数の変数代入を行ひ、その変数代入を現在の環境に影響させることもできる。[シンプルコマンド](#シンプルコマンド)も参照。

シンプルコマンドは、変数代入でもリダイレクトでもない部分を単語展開し、リダイレクトを実行し、変数代入を単語展開し、それから変数代入を行ふといふ順で実行される[^21]。コマンドは、コマンド名があれば、その後に実行される[^44]。よって、例へば、

[^21]:
    [2.9.1 Simple Commands](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01){lang=en} には

    <div class="blockquote-like">

      与へられたシンプルコマンドが実行される必要がある場合（すなはち、AND-OR リストや case 文などの条件構造がそのシンプルコマンドをバイパスしてゐない場合）、コマンドテキストの最初から最後まで、次の展開、代入、およびリダイレクトが全て実行される:

      1. [シェル文法規則](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_10_02){hreflang=en}に従って、変数代入またはリダイレクトとして認識される単語が、ステップ[3]{.upright}とステップ[4]{.upright}の処理のために保存される。
      2. 変数代入でもリダイレクトでもない単語が展開される。展開後にフィールドが残ってゐる場合、最初のフィールドはコマンド名と見做され、残りのフィールドはそのコマンドの引数と見做される。
      3. [リダイレクト](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07)に記述されてゐるやうに、リダイレクトが実行される。
      4. それぞれの変数代入は、値を代入する前に、チルダ展開、パラメーター展開、コマンド置換、算術展開、そして引用符削除される。

      先のリストにおいて、ステップ[2]{.upright}からコマンド名が生じない場合、またはコマンド名が特殊ビルトインユーティリティ（[特殊ビルトインユーティリティ](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_14){hreflang=en}を見よ。）の名前に一致する場合、ステップ[3]{.upright}とステップ[4]{.upright}の順序は入れ替はってもよい。

    </div>

    +++ 原文
    <blockquote lang="en">

      When a given simple command is required to be executed (that is, when any conditional construct such as an AND-OR list or a case statement has not bypassed the simple command), the following expansions, assignments, and redirections shall all be performed from the beginning of the command text to the end:

      1. The words that are recognized as variable assignments or redirections according to [Shell Grammar Rules](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_10_02) are saved for processing in steps 3 and 4.
      2. The words that are not variable assignments or redirections shall be expanded. If any fields remain following their expansion, the first field shall be considered the command name and remaining fields are the arguments for the command.
      3. Redirections shall be performed as described in [Redirection](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07).
      4. Each variable assignment shall be expanded for tilde expansion, parameter expansion, command substitution, arithmetic expansion, and quote removal prior to assigning the value.

      In the preceding list, the order of steps 3 and 4 may be reversed if no command name results from step 2 or if the command name matches the name of a special built-in utility; see [Special Built-In Utilities](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_14).

    </blockquote>
    +++

    とある。

[^44]:
    [2.9.1 Simple Commands](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01){lang=en} には

    <div class="blockquote-like">

      コマンド名がある場合、[コマンドの検索と実行](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01_01){hreflang=en}に記述されてゐるやうに実行が続行する。コマンド名は無いが、コマンドはコマンド置換を含んでゐたやうな場合、コマンドは、最後に実行されたコマンド置換の終了ステータスで完了する。その他の場合、コマンドは終了ステータス[0]{.upright}で完了する。

    </div>

    +++ 原文
    <blockquote lang="en">

      If there is a command name, execution shall continue as described in [Command Search and Execution](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01_01) . If there is no command name, but the command contained a command substitution, the command shall complete with the exit status of the last command substitution performed. Otherwise, the command shall complete with a zero exit status.

    </blockquote>
    +++

    とある。

``` sh
foo=1 bar=$foo
echo "$bar"
```

は空行を出力し、

``` sh
foo=1 echo hello >"$foo"
```

は `sh: : No such file or directory` のやうなメッセージを標準エラー出力に印字する。この振る舞ひは見落としやすいので、**注意して使ふ**[^22]。

[^22]: しばらく考へたけれど、実用性を犠牲にせずに構文でうまく立ち回る方法は思ひ付かなかった。

コマンド名が存在する場合、そのコマンド名が標準ユーティリティなら変数代入はそのコマンドの環境にしか影響せず、特殊ビルトインや関数なら現在の環境に影響する[^23]。例へば、

[^23]:
    [2.9.1 Simple Commands](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01){lang=en} には

    <div class="blockquote-like">

      変数代入は次のやうに実行される:

      - 結果としてコマンド名が無い場合、変数代入は現在の実行環境に影響する。
      - ==コマンド名が特殊ビルトインユーティリティでも関数でもない場合、変数代入は、そのコマンドの実行環境にエクスポートされ==、ステップ[4]{.upright}で実行される展開の副作用を除いて、==現在の実行環境には影響しない==。この場合、次のことは<ruby>規定されない<rt lang="en">unspecified</ruby>:
        - 代入がステップ[4]{.upright}のその後の展開において可視かどうか
        - これらの展開の副作用として実行される変数代入がステップ[4]{.upright}のその後の展開、現在のシェル実行環境、またはその両方において可視かどうか
      - コマンド名が関数として実装された標準ユーティリティ（XBD の[ユーティリティ](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_22){hreflang=en}を見よ。）の場合、変数代入の影響は、そのユーティリティが関数として実装されてゐなかったかのやうに現れる。
      - ==コマンド名が特殊ビルトインユーティリティの場合、変数代入は現在の実行環境に影響する==。<i>set</i> <b>-a</b> オプションが有効でない場合（[set](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_25){lang=en} を見よ。）、次のことは<ruby>規定されない<rt lang="en">unspecified</ruby>:
        - 特殊ビルトインユーティリティの実行中に変数が export 属性を得るかどうか
        - 特殊ビルトインユーティリティの完了後に、変数代入の結果として得た export 属性が永続するかどうか
      - コマンド名が関数として実装された標準ユーティリティでない関数の場合、その関数の実行中は、変数代入が現在の実行環境に影響する。次のことは<ruby>規定されない<rt lang="en">unspecified</ruby>:
        - 関数の完了後に変数代入が永続するかどうか
        - 関数の実行中に変数が export 属性を得るかどうか
        - （関数の完了後に変数代入が永続する場合、）関数の完了後に変数代入の結果として得た export 属性が永続するかどうか

    </div>

    +++ 原文
    <blockquote lang="en">

      Variable assignments shall be performed as follows:

      - If no command name results, variable assignments shall affect the current execution environment.
      - ==If the command name is not a special built-in utility or function, the variable assignments shall be exported for the execution environment of the command and shall not affect the current execution environment== except as a side-effect of the expansions performed in step 4. In this case it is unspecified:
        - Whether or not the assignments are visible for subsequent expansions in step 4
        - Whether variable assignments made as side-effects of these expansions are visible for subsequent expansions in step 4, or in the current shell execution environment, or both
      - If the command name is a standard utility implemented as a function (see XBD [Utility](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_22)), the effect of variable assignments shall be as if the utility was not implemented as a function.
      - ==If the command name is a special built-in utility, variable assignments shall affect the current execution environment==. Unless the <i>set</i> <b>-a</b> option is on (see [set](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_25)), it is unspecified:
        - Whether or not the variables gain the export attribute during the execution of the special built-in utility
        - Whether or not export attributes gained as a result of the variable assignments persist after the completion of the special built-in utility
      - If the command name is a function that is not a standard utility implemented as a function, variable assignments shall affect the current execution environment during the execution of the function. It is unspecified:
        - Whether or not the variable assignments persist after the completion of the function
        - Whether or not the variables gain the export attribute during the execution of the function
        - Whether or not export attributes gained as a result of the variable assignments persist after the completion of the function (if variable assignments persist after the completion of the function)

    </blockquote>
    +++

    とある。

``` sh
foo=1
foo=2 true
echo "$foo"
```

は `1` を印字し、

``` sh
foo=1
foo=2 :
echo "$foo"
```

は `2` を印字する。

この振る舞ひもかなりやゝこしいので、*特殊ビルトインや関数を実行するときは、そのコマンドで変数代入を行はない*やうにする。POSIX の特殊ビルトインは `.` `:` `break` `continue` `eval` `exec` `exit` `export` `readonly` `return` `set` `shift` `times` `trap` `unset` の[15]{.tate-chu-yoko}個。なほ、`export` や `readonly` の右にあるものは引数であって、変数代入ではない。

## 単語展開

単語展開は、まづ、チルダ展開、パラメーター展開、コマンド置換、算術展開が同時に起こり、続いて、フィールド分割、パス名展開、引用符削除がこの順で起こる[^24]。引用符削除が最後に起こるため、単語[^25]を引用符で囲むと、他の種類の単語展開が{沮止|そ|し}できる。引用符には `"` と `'` が使へる。`"` で囲まれた部分では、`` ` `` `$` `\` が特別扱ひされる[^26]ので、パラメーター展開、コマンド置換、算術展開は起こる。つまり、チルダ展開、フィールド分割、パス名展開だけが沮止される。よって、*フィールド分割またはパス名展開（またはチルダ展開）が起こる部分で、チルダ展開、フィールド分割、およびパス名展開のいづれも使はずに、パラメーター展開、コマンド置換、または算術展開を使ふ場合、その部分を `"` で囲む*のが良い。これに相当する部分には

[^24]:
    [2.6 Word Expansions](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06){lang=en} には

    <div class="blockquote-like">

      単語展開の順序は次の通り:

      1. チルダ展開（[チルダ展開](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_01){hreflang=en}を見よ。）、パラメーター展開（[パラメーター展開](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02){hreflang=en}を見よ。）、コマンド置換（[コマンド置換](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_03){hreflang=en}を見よ。）、そして算術展開（[算術展開](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_04){hreflang=en}を見よ。）が全て実行される。[トークン認識](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_03){hreflang=en}の第[5]{.upright}項目を見よ。
      2. <i>IFS</i> が null でなければ、ステップ[1]{.upright}で生成されたフィールドの部分に対して、フィールド分割（[フィールド分割](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_05){hreflang=en}を見よ。）が実行される。
      3. <i>set</i> <b>-f</b> が有効でなければ、パス名展開（[パス名展開](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_06){hreflang=en}を見よ。）が実行される。
      4. 最後に、引用符削除（[引用符削除](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_07){hreflang=en}を見よ。）が常に実行される。

    </div>

    +++ 原文
    <blockquote lang="en">

      The order of word expansion shall be as follows:

      1. Tilde expansion (see [Tilde Expansion](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_01)), parameter expansion (see [Parameter Expansion](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02)), command substitution (see [Command Substitution](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_03)), and arithmetic expansion (see [Arithmetic Expansion](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_04)) shall be performed, beginning to end. See item 5 in [Token Recognition](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_03).
      2. Field splitting (see [Field Splitting](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_05)) shall be performed on the portions of the fields generated by step 1, unless IFS is null.
      3. Pathname expansion (see [Pathname Expansion](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_06)) shall be performed, unless <i>set</i> <b>-f</b> is in effect.
      4. Quote removal (see [Quote Removal](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_07)) shall always be performed last.

    </blockquote>
    +++

    とある。

[^25]: 単語展開されるトークン。

[^26]:
    [2.2.3 Double-Quotes](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02_03){lang=en} には

    <div class="blockquote-like">

      二重引用符（`""`）で<ruby>文字<rt lang="en">characters</ruby>を囲むと、次のやうに、その二重引用符の中の（バッククォート、\<dollar-sign\>、および \<backslash\> を除く）全ての文字のリテラル値が保持される:

    </div>

    +++ 原文
    <blockquote lang="en">

      Enclosing characters in double-quotes ( `""` ) shall preserve the literal value of all characters within the double-quotes, with the exception of the characters backquote, \<dollar-sign\>, and \<backslash\>, as follows:

    </blockquote>
    +++

    とある。

- コマンド名
- 引数
- 変数代入の左辺
- <u>変数代入の右辺</u>
- ヒアドキュメントの区切り文字を除く、リダイレクトの右辺
- for 文の `in` の右の部分
- <u>case 文の `case` の右の部分</u>

などがある。

たゞし、変数代入の右辺や case 文の `case` の右の部分は、フィールド分割とパス名展開が起こらないため、`"` で囲んでも、チルダ展開が起こらなくなるだけである。これらの部分で `~` を使ふときは大抵、チルダ展開を期待してゐる[^27]ので、`"` で囲む理由は少ない。

ヒアドキュメントの区切り文字では引用符削除しか起こらないので、区切り文字の単語展開を沮止するために引用符で囲む必要性は無い。`'` で囲むと、ヒアドキュメントの単語展開が沮止できる。

[^27]:
    次のやうなコマンドを想像すると分かりやすいと思ふ:

    ``` sh
    tilde="~"
    home=~
    ```

    ``` sh
    case ~ in
    	(/home/* | /Users/*) echo 'I'"'"'m a huperoffspring!'
    esac
    ```

---

`${TMPDIR:-/tmp}` などの `$foo` 以外の形式のパラメーター展開は、パフォーマンスに貢献することが多いので、積極的に使ふ。

*コマンド置換には `$(command)` を使ひ*、`` `command` `` は使はない。`"` で囲まれた部分では ` `` ` も展開されることに注意。例へば、``echo "`(cd ..; pwd)`"`` は作業ディレクトリの親ディレクトリのパスを印字する。

## 関数

関数は以下のことに注意して使ふ。

### 引数

引数は位置パラメーターとして渡される。位置パラメーターとは、数字で識別され、`$0` `$1` といった形式で参照されるパラメーターである。[10]{.tate-chu-yoko}以上のものは `${10}` のやうに数字を波括弧で囲まなければならない[^43]。引数に使はれるのは[1]{.upright}以上のものであり、`$0` はシェルかシェルスクリプトの名前を持つ。

[^43]:
    [2.6.2 Parameter Expansion](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02){lang=en} には

    <div class="blockquote-like">

      パラメーターが波括弧で囲まれてをらず、かつ名前である場合、その名前で表される変数が存在するかどうかにかゝはらず、展開は最長の妥当な名前（XBD の[名前](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_235){hreflang=en}を見よ。）を使ふ。その他の場合、パラメーターは[1]{.upright}文字のシンボルであり、その文字が数字でも特殊パラメーター（[特殊パラメーター](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_05_02){hreflang=en}を見よ。）の内の一つでもない場合の振る舞ひは<ruby>未規定<rt lang="en">unspecified</ruby>である。

    </div>

    +++ 原文
    <blockquote lang="en">

      If the parameter is not enclosed in braces, and is a name, the expansion shall use the longest valid name (see XBD [Name](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_235)), whether or not the variable represented by that name exists. Otherwise, the parameter is a single-character symbol, and behavior is unspecified if that character is neither a digit nor one of the special parameters (see [Special Parameters](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_05_02)).

    </blockquote>
    +++

    とある。

読みづらいときは適当な名前のパラメーターに代入すると良い。位置が決まってゐるならそのまゝ代入し、さうでない場合は `getopts` を使ふ。シェルスクリプトでは `getopts` より複雑なことはしない方が良いと思ふ。位置パラメーターのまゝ使ふ場合、ドキュメントで役割を説明する。

*加工して返すべき値は標準入力として受け取る*。

### 返り値

返り値は終了ステータスとして返される。終了ステータスは単なる[8]{.upright}ビット非負整数なので、関数やプログラムの結果を表すには心許ない。そのため、シェルでは、真偽値を返す場合を除いて、*結果は標準出力に送る*。

## 条件

シェルの条件の正体は、真なら[0]{.upright}を、偽なら[0]{.upright}でない値を返すコマンドである。if 文の `if` `elif` の右の部分と while 文の `while` の右の部分は複合コマンドである[^36]。

[^36]:
    この性質のおかげで、例へば、

    ``` sh
    if case $PWD in ($HOME*) true ;; (*) false; esac; then
    	cat <<-'EOD'
    		I'm in my own $HOME.
    	EOD
    fi
    ```

    みたいに case 文を条件にして、ある文字列の中に別のある文字列が含まれるかどうかを判定することができる。`test` にはかういふ機能は無い。

### 複合条件

*複合条件は、AND-OR リスト `&&` `||` を使って*、

``` sh
if [ -n "$foo" ] && [ -e "$file_path" ]; then
	echo no good
fi
```

のやうに書く。`test` の `-a` `-o` プライマリは使はない。`test` は引数の個数が[4]{.upright}より大きい場合については<ruby>規定されてゐない<rt lang="en">unspecified</ruby>[^37]。例へば、

[^37]: [test](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html){lang=en} を参照。

``` sh
[ -n "=" -a -e "/path/to/file" ]
```

はうまく動かないことがある[^38]が、

[^38]:
    GNU bash 5.1（POSIX モード）で実行すると、標準エラーに

    ``` txt
    sh: [: too many arguments
    ```

    と印字された。

``` sh
[ -n "=" ] && [ -e "/path/to/file" ]
```

はうまく動く。

### 否定条件

*否定条件は、パイプラインの `!` を使って*、

``` sh
if ! command -v openssl >/dev/null; then
	echo "No command 'openssl' found." >&2

	return 69 # EX_UNAVAILABLE
fi
```

のやうに書く。`test` の `!` プライマリは使はない。

### 条件のグループ

*条件をグループするときはブレースグループ[^34]を使ふ*。サブシェルは使はない。例へば、複合条件の否定は、

``` sh
if ! { [ -n "$foo" ] && [ -e "$file_path" ]; } then
	echo good
fi
```

といふゝうに書く。ブレースグループの終はりには `;`[^39] が無ければならない。サブシェルを用ゐて

[^39]: より一般的にはセパレーター。`;` もしくは `&` の右に[0]{.upright}個以上の改行が続くもの、または[1]{.upright}つ以上の改行。

``` sh
! ([ -n "$foo" ] && [ -e "$file_path" ])
```

のやうにする方法は、一見すると良さゝうだが、かうすると、サブシェルで実行されるコマンドがシェルを終了させるやうな場合に、現在のシェルが終了しなくなってしまふ[^41]。なほ、この条件を

[^41]:
    [exit](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#exit){lang=en} には

    <div class="blockquote-like">

      現在の実行環境がサブシェル環境の場合、シェルは、指定された終了ステータスでそのサブシェル環境を終了し、==そのサブシェル環境が呼び出された環境で続行する==。

    </div>

    +++ 原文
    <blockquote lang="en">

      If the current execution environment is a subshell environment, the shell shall exit from the subshell environment with the specified exit status and ==continue in the environment from which that subshell environment was invoked==;

    </blockquote>
    +++

    とある。

``` sh
! [ -n "$foo" ] && [ -e "$file_path" ]
```

と書くことはできない。`!` はパイプラインの一部であり、AND-OR リスト `&&` `||` はパイプラインを被演算子に取るので、かうすると、`! [ -n "$foo" ]` と `[ -e "$file_path" ]` の論理積として解釈されてしまふ。

## その他の一般的なパターン

### エントリーポイント

*スクリプトのほゞ全体を `main` といふ名前の関数にする*。例へば、

``` sh
#!/bin/sh
set -eu

main() {
	echo OK
}

main "$@"
```

といふゝうにする。かうすると、[2]{.upright}つ良いことがある。[1]{.upright}つはエントリーポイントが明確になり、関数定義が `main` のロジックから自然に分離されることである。

もう[1]{.upright}つは関数定義はキャッシュされるといふことである。例へば、

``` sh:poc1.sh
#!/bin/sh
set -eu

main() {
	foo=1
	sleep 2
	# unset foo
	echo "foo: $foo"
}

main "$@"
```

は、

``` sh
./poc1.sh &
sleep 1
sed "s/# //" <poc1.sh >/tmp/poc1.sh
cat /tmp/poc1.sh >poc1.sh
```

のやうに実行されても、[2]{.upright}秒後に `foo: 1` を印字する。`main` が無ければ、`echo "foo: $foo"` でパラメーター展開に失敗して終了する。

### 無駄な〇〇を避ける

*無駄な `cat` を避ける*。例へば、`cat |` といふコード片は、`cat` は標準入力を標準出力に移し、パイプラインの `|` は左辺のコマンドの標準出力を右辺のコマンドの標準入力に繋げるだけなので、いつでも省略できる。

[Useless Use of Cat Award](https://www.iki.fi/era/unix/award.html){lang=en} も参照。

*無駄な `echo` を避ける*。例へば、複数行の文字列を印字するときは、

``` sh
	echo "line 1" >&2
	echo "line 2" >&2
```

よりも

``` sh
	cat <<-EOF >&2
	line 1
	line 2
	EOF
```

と書くやうにする。
