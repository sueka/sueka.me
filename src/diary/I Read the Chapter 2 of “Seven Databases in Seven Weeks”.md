---
title: 『[7]{.upright}つのデータベース [7]{.upright}つの世界』第[2]{.upright}章を読んだ
url: ./i-read-7dbs-2-postgres.html
date: 2022-08-12
vertical: false
---

『<a href="https://www.ohmsha.co.jp/book/9784274069086/">[7]{.upright}つのデータベース [7]{.upright}つの世界</a>』（[2013]{.upright}年、オーム社）第[2]{.upright}章を読んだ。この記事は単なる日記であって、書籍の内容を要約しようとしたり、抜粋しようとしたりするものではない。

## PostgreSQL

第[2]{.upright}章（最初）の題材は PostgreSQL だった。この本で取り上げられてゐる唯一の関係データベースである。[1]{.upright}日目に入る前に、PostgreSQL とモジュールをインストールした[^1]:

[^1]:
    本では PostgreSQL 9.0 が使はれてゐるが、あまり気にせずに最新版をインストールした。`psql -V` は

    ``` txt
    psql (PostgreSQL) 14.4
    ```

    を印字する。バージョンによる差異があったら本文で触れる。

``` sh
brew install postgres
brew services restart postgresql
createdb book
psql book
```

``` pgsql
CREATE EXTENSION tablefunc;
CREATE EXTENSION dict_xsyn;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION pg_trgm;
CREATE EXTENSION cube;
\q
```

`psql book -c \\dx` とすると、インストールされてゐる拡張の一覧が印字される。

[1]{.upright}日目はリレーションの基礎と CRUD、結合について学ぶ。適当に手を動かしながら読んだ。

- [Loompaland]{lang=en} は『[Charlie and the Chocolate Factory]{lang=en}』に登場する地名らしい。
- `events.venue_id` の型は `integer` にした。
- <i>宿題</i>では [5.4. Constraints](https://www.postgresql.org/docs/14/ddl-constraints.html){lang=en} や [52.11. pg_class](https://www.postgresql.org/docs/14/catalog-pg-class.html){lang=en} などを参考にした。
- <i>宿題</i>の<i>やってみよう[1]{.upright}</i>の<q>選択</q>は `SELECT` のこと。

[2]{.upright}日目に入る前に、`psql` では補完がうまくいかないことが多かったので、`pgcli` をインストールした。こゝからは `pgcli book` でサーバーに接続する。

[2]{.upright}日目も適当に読んだ。

- p.21 の `INSERT` クエリを発行してゐないと、p.22 の `min` `max` を使ったクエリが

  ``` txt
  +--------+--------+
  | min    | max    |
  |--------+--------|
  | <null> | <null> |
  +--------+--------+
  ```

  を返してしまふ。
- pp.24–25 の

  > 我々は、`PARTITION BY` を `GROUP BY` と同じものだと考えている。ただし、`SELECT` の外側で結果をグループ化するのではなく（結果の行数をまとめるのではなく）、グループ化した値を別のフィールド（グループ化した変数や属性を計算したもの）として返すのである。==SQL 的に言えば、結果セットの `PARTITION` に集約関数 `OVER` を適用した結果を返す==のである。

  はよく理解できなかったので原文に当たった[^3]。この部分の原文は

  [^3]: わざわざ初版を買うのは勿体無い気がしたので、[Second Edition]{lang=en} を買った。この部分には差異は無いと思ふ。

  > We like to think of `PARTITION BY` as akin to `GROUP BY`, but rather than grouping the results outside of the `SELECT` attribute list (and thus combining the results into fewer rows), it returns grouped values as any other field (calculating on the grouped variable but otherwise just another attribute). Or in *SQL* parlance, ==it returns the results of an aggregate function `OVER` a `PARTITION` of the result set==.
  {lang=en}

  だった。最後の文の<q lang="en">OVER</q>は前置詞として使はれてをり、<q lang="en">PARTITION</q>にもわざわざ不定冠詞が付けてあった。それなら、[マーク]{.mark-like}した部分の訳は、

  <div class="blockquote-like">

    結果集合の<ruby>分割<rt lang="en">PARTITION</ruby><ruby>全体に亙って<rt lang="en">OVER</ruby>集約関数を適用した結果を返す

  </div>

  とでもすべきだったと思ふ。*集合の分割*は次の性質を持つ:

  - 空集合を含まない。
  - 分割前の集合の被覆である。
  - [pairwise disjoint]{lang=en} である。

  <ruby>結果集合<rt lang="en">the result set</ruby>といふのは恐らく、`FROM` 句や `WHERE` 句などの結果のことだらう。
- `createlang` は PostgreSQL 9.1 で非推奨になり、10 で廃止された。p.28 では `createlang book --list` の代はりに `psql book -c \\dL` を使った。
- PostgreSQL 9.3 では<i>自動的に更新可能な VIEW</i> が導入された。[リリースノート](https://www.postgresql.org/about/news/postgresql-93-released-1481/)。[CREATE VIEW](https://www.postgresql.org/docs/14/sql-createview.html#SQL-CREATEVIEW-UPDATABLE-VIEWS) には

  <div class="blockquote-like">

    ビューは、次の条件を全て満たす場合、自動的に更新可能です:

    - ビューが FROM リストにたゞ[1]{.upright}つのエントリーを持つ。そのエントリーはテーブルまたは他の更新可能なビューである。
    - ビューの定義がトップレベルに `WITH` 句、`DISTINCT` 句、`GROUP BY` 句、`HAVING` 句、`LIMIT` 句および `OFFSET` 句のいづれも含まない。
    - ビューの定義がトップレベルに集合演算（`UNION`、`INTERSECT` および `EXCEPT`）を含まない。
    - ビューの<ruby>選択<rt lang="en">select</ruby>リストがいかなる集約、ウィンドウ関数、あるいは集合を返す関数をも含まない。

  </div>

  +++ 原文
  <blockquote lang="en">

    A view is automatically updatable if it satisfies all of the following conditions:

    - The view must have exactly one entry in its FROM list, which must be a table or another updatable view.
    - The view definition must not contain `WITH`, `DISTINCT`, `GROUP BY`, `HAVING`, `LIMIT`, or `OFFSET` clauses at the top level.
    - The view definition must not contain set operations (`UNION`, `INTERSECT` or `EXCEPT`) at the top level.
    - The view's select list must not contain any aggregates, window functions or set-returning functions.

  </blockquote>
  +++

  とある。そのため、本の通りに進めると、p.30 の `UPDATE` クエリが成功してしまふ。そこで、同じく p.30 の `CREATE OR REPLACE VIEW` クエリに `LIMIT 100` を附け加へて発行した。さうすると、無事に

  ``` txt
  cannot update view "holidays"
  DETAIL:  Views containing LIMIT or OFFSET are not automatically updatable.
  HINT:  To enable updating the view, provide an INSTEAD OF UPDATE trigger or an unconditional ON UPDATE DO INSTEAD rule.
  ```

  と出力された。あとは<i>学校のルール？</i>から続行した。
- <i>宿題</i>の<i>やってみよう[3]{.upright}</i>はかなり難しかった。次のやうにして解いた:
  1.  ピボットテーブルは値を集約することはできるが、値の無い箇所を埋めることはできない。よって、目標の月に含まれる日の一覧が必要だ。これは

      ``` sql
      SELECT * FROM generate_series(
        '2012-02-01',
        '2012-03-01'::date - '1 day'::interval,
        '1 day'::interval
      ) date;
      ```

      のやうにして取得した。これをビュー `Feb_2012` とする。
  2.  次に、日ごとにその日にあったイベントの個数を数へる。まづ、`Feb_2012` に `events` を左結合する:

      ``` sql
      SELECT date, title, starts
      FROM Feb_2012
      LEFT JOIN events
        ON date <= starts AND starts < date + '1 day'::interval
      ```
  3.  そして、`date` でグループしてから `events` の個数を数へる:

      ``` sql
      SELECT date, count(events)
      FROM Feb_2012
      LEFT JOIN events
        ON date <= starts AND starts < date + '1 day'::interval
      GROUP BY date
      ORDER BY date
      ```
  4.  次に、週と曜日を [SELECT]{lang=en} してみる:

      ``` sql
      SELECT date,
             extract(week from date) week,
             extract(dow from date) dow
      FROM Feb_2012
      ```

      すると、次のやうに出力される:

      ``` txt
      +---------------------+------+-----+
      | date                | week | dow |
      |---------------------+------+-----|
      | 2012-02-01 00:00:00 | 5    | 3   |
      | 2012-02-02 00:00:00 | 5    | 4   |
      | 2012-02-03 00:00:00 | 5    | 5   |
      | 2012-02-04 00:00:00 | 5    | 6   |
      | 2012-02-05 00:00:00 | 5    | 0   |
      | 2012-02-06 00:00:00 | 6    | 1   |
      | 2012-02-07 00:00:00 | 6    | 2   |
      | 2012-02-08 00:00:00 | 6    | 3   |
      | 2012-02-09 00:00:00 | 6    | 4   |
      | 2012-02-10 00:00:00 | 6    | 5   |
      ⋮
      ```

      週が変はるところと曜日が[0]{.upright}に戻るところとが異なるやうに見えるが、これは、`extract` の `week` は ISO 週（月曜日で始まる。）を返し、`dow` は日曜始まりの値を返すからである。[9.9. Date/Time Functions and Operators](https://www.postgresql.org/docs/14/functions-datetime.html){lang=en} も参照。
  5.  よって、日曜始まりのカレンダーを作るには、`week` を補正する必要がある。`dow` が[0]{.upright}なら `week` を[1]{.upright}だけ増やす。

      ``` sql
      SELECT date,
             extract(week from date) + (CASE WHEN extract(dow from date) = 0 THEN 1 ELSE 0 END) week,
             extract(dow from date) dow
      FROM Feb_2012
      ```

      とした。もっと巧い方法がありさう。
  6.  必要なものは `date` ではなくイベントの個数だった:

      ``` sql
      SELECT extract(week from date) + (CASE WHEN extract(dow from date) = 0 THEN 1 ELSE 0 END) week,
             extract(dow from date) dow,
             count(events)
      FROM Feb_2012
      LEFT JOIN events
        ON date <= starts AND starts < date + '1 day'::interval
      GROUP BY date
      ORDER BY date
      ```
  7.  最後に、`dow` つまり [0–6]{.upright} をカテゴリにして、このテーブルのピボットテーブルを作成した:

      ``` sql
      SELECT *
      FROM crosstab(
        'SELECT extract(week from date) + (CASE WHEN extract(dow from date) = 0 THEN 1 ELSE 0 END) week,
                extract(dow from date) dow,
                count(events)
         FROM Feb_2012
         LEFT JOIN events
           ON date <= starts AND starts < date + ''1 day''::interval
         GROUP BY date
         ORDER BY date',
        'SELECT * from generate_series(0, 6)')
      AS (
        week int,
        Sun int, Mon int, Tue int, Wed int, Thu int, Fri int, Sat int
      )
      ORDER BY week
      ```
  8.  本では `0` や `<null>` は取り除くことになってゐる。

3日目は全文検索と多次元クエリについて学んだ。

- p.38 に次のやうな入出力がある:

  > ``` sql
  > SELECT show_trgm('Avatar');
  > ```
  > 
  > ``` txt
  >               show_trgm              
  > -------------------------------------
  >  {"  a"," av","ar ",ata,ava,tar,vat}
  > ```

  手元の環境で実行しても同じ結果が得られた。多少引数を変へても同様だった。`ava` `vat` `ata` `tar` だけを返すか、`r  ` も返すかゞ適当だと思ふが、どういふ仕様なんだらう。なほ、

  ``` sql
  SELECT show_trgm('Avatar  ')
  ```

  のやうに [trailing spaces]{lang=en} を補っても、`r  ` は含まれない。
- `pgcli` では `\dFd` がうまく動作しなかった。`psql` なら動作する。
- p.40 の

  > 「machst」（行う）や「gerade」（今）は語幹だ。

  はかなり違和感があった。

  <div class="blockquote-like">

    「machst」（行う）や「gerade」（今）は<ruby>語幹化される<rt lang="en">are stemmed</ruby>。

  </div>

  くらゐが妥当だと思ふ。
- p.41 の[3]{.upright}つ目の `EXPLAIN` クエリは、行数が少ないときは、上[2]{.upright}つと同じ [Seq Scan on movies]{lang=en} プランを表示する。[Seven Databases in Seven Weeks, Second Edition](https://pragprog.com/titles/pwrdata/seven-databases-in-seven-weeks-second-edition/){lang=en} から[^5] [Source Code]{lang=en} をダウンロードして、

  [^5]: [First Edition]{lang=en} 用のページは恐らくもう公開されてゐない。

  ``` pgsql
  \i /path/to/code/postgres/movies_data.sql 
  ```

  を発行すると、[Bitmap Heap Scan on movies]{lang=en} プランを表示するやうになった。恐らく Postgres がどこかのバージョンで、行数が少ないときは全表スキャンするやうになったのだらう[^6]。

  [^6]: PostgreSQL 9.1 では[0]{.upright}行でも [Bitmap Heap Scan on movies]{lang=en} プランが表示された。

  事前に `SET enable_seqscan = false;` としておけば、行数が少なくても [Bitmap Heap Scan on movies]{lang=en} プランを表示する。`enable_seqscan` を `false` にしても、全表スキャンが完全に制御されるわけではない。[20.7. Query Planning](https://www.postgresql.org/docs/14/runtime-config-query.html){lang=en} も参照。

<i>まとめ</i>の節では PostgreSQL の強みと弱みが述べられてゐた。とくに、

> 他のオープンソースデータベースには複雑なライセンス規約があるが、PostgreSQL は純粋なオープンソースソフトウェアだ。誰もコードを所有していない。誰でも何でも好きなことができる（著作権を主張すること以外）。

は重要だと思ふ。[*The PostgreSQL License*]{lang=en} はパーミッシブ・ライセンスの中でもかなり緩やかで、MIT ライセンスや[1]{.upright}条項 BSD ライセンスによく似てゐる。

### 正誤表

誤字脱字を少し見付けてしまった。版は第[1]{.upright}版第[2]{.upright}刷。出版社による正誤表は無い。

| ページ               | 正                                            | 誤                                            |
|:---------------------|:----------------------------------------------|:----------------------------------------------|
| [37]{.tate-chu-yoko} | [2]{.upright}つの文字を置換（b=>f、t=>==d==） | [2]{.upright}つの文字を置換（b=>f、t=>==b==） |
| [39]{.tate-chu-yoko} | `$ cat`                                       | `cat`                                         |
