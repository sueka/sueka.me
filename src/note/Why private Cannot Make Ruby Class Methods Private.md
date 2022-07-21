---
title: なぜ Ruby のクラスメソッドは `private` で [private]{lang=en} にできないのか
date: 2022-07-22
vertical: false
---

表題の通り、Ruby には `private` といふメソッド[^1]があるが、次のやうに、クラスメソッドの可視性を [private]{lang=en} にするためにこれを使ふことはできない:

``` ruby
class A
  private def self.f; end
end
```

[^1]: これがメソッドだといふ認識が無い人も少なくないと思ふ。本文ですぐに説明する。

代はりに、`private_class_method` メソッドを使って、

``` ruby
class A
  private_class_method def self.f; end
end
```

とするか、特異クラスを使って、

``` ruby
class A
  class << self
    private def f; end
  end
end
```

とするのが主流である。また、

``` ruby
class A
  private def _f; end

  def self.f
    self.new._f
  end
end
```

としても、ほゞ同じ結果が得られる。この記事では、表題（についての私の理解）を説明する。

---

特定のオブジェクトに固有のメソッドをそのオブジェクトの特異メソッドと言ひ、クラスの特異メソッドを（そのクラスの）クラスメソッドと言ふ。クラスは `Class` クラスのインスタンスである。特異メソッドは、メソッド定義と同じやうな構文で、

``` ruby
def nil.empty?
  true
end
```

といふゝうに定義する。このコードを実行すると、`nil` オブジェクトに `:empty?` といふ名前のメソッドが追加される。この記事では、このやうなメソッドを参照するために `nil.method(:empty?)` と書くことがある。`nil.empty?` と `nil.method(:empty?).call` は同じ結果を与へる。

特異メソッドのうち、メソッド名の左の `.` の左の部分がクラスであるものがクラスメソッドである。例へば、

``` ruby
class A; end

def A.f(x)
  -x
end
```

の `A.method(:f)` がこれに当たる。他のオブジェクト指向プログラミング言語と同様に、クラスメソッドは継承される。つまり、

``` ruby
class B < A; end

fail unless A.f(2) == B.f(2)
```

が成功する。

---

執筆の都合で、メソッド定義構文も確認する。次のコードを実行すると、[2–4]{.upright}行目で、クラス `A` に `:f` といふ名前のインスタンスメソッドが追加[^2]される:

``` ruby
class A
  def f(x)
    -x
  end
end
```

[^2]:
    `class A` が処理され、クラス定義の中に入った時点で、すでにクラス `A` は存在する。

    ``` ruby
    class A
      p A.new.class
    end
    ```

    は `A` を印字する。

この記事では、このやうなメソッドを参照するために `A.instance_method(:f)` と書くことがある。次の[2]{.upright}つのコードは同じ結果を与へる:

``` ruby
a = A.new
a.f(42)
``` 

``` ruby
a = A.new
A.instance_method(:f).bind(a).call(42)
```

---

クラス定義やモジュール定義の中では、`self` はそのクラスやモジュール自身を指す。

``` ruby
class A
  p self
end
```

``` ruby
module A
  p self
end
```

はいづれも `A` を印字する。（モジュールについては以下扱はない。）　これを使ふと、クラスメソッドは

``` ruby
class A
  def self.f(x)
    -x
  end
end
```

といふゝうに定義することもできる。なほ、メソッド定義の中では、`self` は、そのメソッド呼び出しのレシーバーを指す。つまり、

``` ruby
class A
  def receiver
    self
  end
end

fail unless A.new.receiver.class == A
```

が成功する。なぜ特異メソッド定義の `def` の右の部分ではこのやうにレシーバーを指さないのかといふと、先の

``` ruby
class A
  def self.f(x)
    -x
  end
end
```

は

``` ruby
class A
  self.define_singleton_method(:f) do |x|
    -x
  end
end
```

と同等だからである。この `self` は明らかにクラス定義の中、メソッド定義の外にある。

より一般的に言へば、`self` は

> 現在のコンテキストにおいて、暗黙のレシーバーとなるオブジェクト。

である。（引用元は[Ruby用語集 (Ruby 3.1 リファレンスマニュアル)](https://docs.ruby-lang.org/ja/3.1/doc/glossary.html#S)。）

---

今、話題にしてゐる `private` は、`Module` クラスのメソッドで[^4]、メソッド名を引数に取って、そのメソッドを*明示的なレシーバーを使って呼び出せなくする*ものである。例へば、

[^4]: クラスは `Class` クラスのインスタンスであり、`Class` は `Module` のサブクラスであり、クラス定義の中では `self` はそのクラス自身を指し、[private]{lang=en} メソッドはサブクラスからも呼び出せるので、クラス定義の中でも、`private :f` みたいな文がうまく動作する。

``` ruby
class A
  def f; end

  private :f
end
```

を実行すると、[2]{.upright}行目で `A.instance_method(:f)` が追加され、[4]{.upright}行目でその可視性が [private]{lang=en} になる。このことから逆に、[private]{lang=en} メソッドとは、明示的なレシーバーを使って呼び出せないメソッドであるとも言へる。そのため、他の多くの言語とは異なり、Ruby の [private]{lang=en} メソッドは、サブクラスからも普通に呼び出すことができる。

`Module` クラスの `private` メソッドも [private]{lang=en} メソッドである。よって、

``` ruby
class A
  def f; end
end

A.private :f
```

のやうにして、クラス定義の外でメソッドの可視性を変更することはできない。（リフレクション無しに）こんなことができてしまっては、定義を変更せずにクラスが破壊できてしまふので、当然の設計である。

そのため、このメソッドは、クラス定義の中で使ふときも、`private :f` といふゝうに、レシーバーを明示せずに呼び出さなければならない。明示的なレシーバーが無ければ `self` が暗黙のレシーバーとして振る舞ふことゝ、クラス定義の中では `self` はそのクラス自身を指すことゝから、

``` ruby
class A
  def f; end

  private :f
end
```

のやうに呼び出された `private :f` は、そのクラスをレシーバーとして実行される。

つまり、`private :f` は、実質的には、暗黙のレシーバー `self` と引数 `:f` を取って、`self.instance_method(:f)` を [private]{lang=en} にする。これに対して、`private_class_method :f` は、`self` と `:f` を取って、`self.method(:f)` を [private]{lang=en} にする。これがクラスメソッドを [private]{lang=en} にするために `private` ではなく `private_class_method` を使ふ理由である。

これに対して、`private_class_method` は [public]{lang=en} メソッドである。よって、冒頭のコードは

``` ruby
class A
  def self.f; end
end

A.private_class_method(:f)
```

としてもうまく動作する。この設計も `private` の場合と同じく危険だが、クラスメソッド定義の中ではクラスが暗黙のレシーバーになるので、もし、このメソッドの可視性が [private]{lang=en} だとしても、次のやうにすれば、クラスメソッドの可視性を外から変更することができる:

``` ruby
class A
  def self.f; end
end

def A.private_A_method(name)
  private_class_method name
end

A.private_A_method(:f)
```

ところで、Ruby のクラスにはオープンクラスといふ性質があり、定義済みのクラスと同じ名前のクラスを再度定義して、元のクラスを変更することができる。例へば、

``` ruby
class NilClass
  def empty?
    true
  end
end
```

を実行すると、`nil.empty?` が `true` を返すやうになる。これを使ふと、

``` ruby
class A
  def f; end
end

class A
  private :f
end
```

のやうにして、元のクラス定義の外からメソッドの可視性を変更することもできる。これを回避するための簡単な方法として、*`private` メソッドは `private def .. end` の形式で使ふ*といふものがある[^3]。

[^3]:
    世間のほとんどのスタイルガイドは

    ``` ruby
    class A
      def f; end

      private

      def g; end
      def h; end
    end
    ```

    みたいな書き方を推奨してゐると思ふ。メソッド名をリテラルで取らないといふ点で、この形式と `private def .. end` 形式とは同じである。

なぜこの書き方がうまくいくのかといふと、メソッド定義は、成功すると、定義されたメソッドの名前を返すからである。例へば、

``` ruby
class A
  p def f; end
end
```

は `:f` を印字する。メソッド呼び出しよりもメソッド定義<b>構文</b>の方が優先順位が高いので、このコードの[2]{.upright}行目は `p (def f; end)` に等しい。また、特異メソッド定義も同様に、定義されたメソッドの名前を返す。名前だけを返すことに注意。次のコードは `:f` を印字する:

``` ruby
class A
  p def self.f; end
end
```

---

といふわけで、冒頭の

``` ruby
class A
  private def self.f; end
end
```

のやうなコードが実行されると、クラス `A` が定義された後、まづ、`def self.f; end` が呼び出され、特異メソッド `A.method(:f)` が定義される。次に、この部分はメソッド名、つまり `:f` を返すので、`private :f` が呼び出される。`private` メソッドは、対象のメソッド、つまり `A.instance_method(:f)` が存在しない場合、`NameError` を投げるので、このコードは失敗する。また、

``` ruby
class A
  def f; end

  private def self.f; end
end
```

とすると、クラス `A` が定義された後、まづ、`def f; end` が呼び出されて、メソッド `A.instance_method(:f)` が定義され、その後は同じやうに動作する。`private :f` の対象のメソッドが存在するので、このコードは成功するが、`private` はインスタンスメソッドの可視性を変更するメソッドなので、特異メソッド `A.method(:f)` ではなくメソッド `A.instance_method(:f)` が [private]{lang=en} になってしまふ。めでたし。

---

なほ、冒頭の

``` ruby
class A
  class << self
    private def f; end
  end
end
```

や

``` ruby
class A
  private def _f; end

  def self.f
    A.new._f
  end
end
```

がうまくいくのは、これらのコードの `private` が（特異メソッド定義ではなく）メソッド定義を引数に取ってゐるからである。これらの方法はいづれも、事実上、一度インスタンスメソッドとして定義してから、クラスメソッドに置き換へるものである。

前者の `class << expr` は、特異クラスを定義する構文である。特異クラスは、[Ruby用語集 (Ruby 3.1 リファレンスマニュアル)](https://docs.ruby-lang.org/ja/3.1/doc/glossary.html#ta) では、

> すべてのオブジェクトには自身が属すクラスとは別に、オブジェクト固有のクラスがあり、特異クラスと呼ばれる。

と説明されてゐる。`class << expr` は、`expr` の特異クラスを定義する。あるオブジェクトの特異クラスのメソッドは、そのオブジェクトの特異メソッドである。つまり、`expr` の特異クラスの定義の中で定義されるメソッドは、`expr` の特異メソッドとなる。クラス定義の中では `self` はそのクラス自身を指すので、このコードの `self` はクラス `A` を指し、`class << self` は `A` の特異クラスを定義する。その中で定義されるメソッドは `A` の特異メソッドとなる。そのため、

``` ruby
class A; end

class << A
  private def f; end
end
```

としても同じ結果が得られる。
