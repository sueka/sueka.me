---
title: GDPR 対応の必要性
date: '2022-08-27'
lastmod: '2023-05-22'
templateEngine: null
draft: true
---
## TL;DR

少なくとも、

- EU 域内の<i><ruby>個人データ<rt lang="en">personal data</ruby></i>を<i><ruby>処理<rt lang="en">processing</ruby></i>し、かつ
- 次のいづれかである:
  - 個人情報保護法を遵守していないか、
  - <i>個人情報取扱事業者</i>でないか、または
  - <i>追加条件</i>を満たしていない

場合は、GDPR に関して、何らかの対策を講ずる必要がある。

## 十分性認定

日本[^1]は EU と相互認證している。EU から日本への移転については、[Adequacy decisions | European Commission](https://ec.europa.eu/info/law/law-topic/data-protection/international-dimension-data-protection/adequacy-decisions_en){lang=en} に次のやうにある[^2]:

[^1]: この記事では日本と EU の関係だけに集中する。
[^2]: LED は、<ruby>決定<rt lang="en">Decision</ruby> (EU) 2021/1772 と合はせて、EU がイギリスの十分性認定を行ふ。

<div class="blockquote-like">

  さういふ決定の効果は、追加の保護措置を必要とせずに、個人データが EU（ならびにノルウェー、リヒテンシュタインおよびアイスランド）からそれらの第三国へ流れることがあるといふことです。言ひ換へれば、当該国への移転は EU 域内のデータ転送に同化されます。

  欧州委員会はこれまでのところ、アルゼンチン、アンドラ、イギリス、イスラエル、カナダ（営利組織）、ガーンジー、ジャージー、スイス、ニュージーランド、フェロー諸島、マン島、日本、韓国を GDPR および LED の下で認めてをり、また、ウルグアイを適切な保護を提供していると認めています。

</div>

+++ 原文
<blockquote lang="en">

  The effect of such a decision is that personal data can flow from the EU (and Norway, Liechtenstein and Iceland) to that third country without any further safeguard being necessary. In others words, transfers to the country in question will be assimilated to intra-EU transmissions of data.

  The European Commission has so far recognised Andorra, Argentina, Canada (commercial organisations), Faroe Islands, Guernsey, Israel, Isle of Man, Japan, Jersey, New Zealand, Republic of Korea, Switzerland, the United Kingdom under the GDPR and the LED, and Uruguay as providing adequate protection.

</blockquote>
+++

日本から EU への移転については、平成[31]{.tate-chu-yoko}年個人情報保護委員会告示第[1]{.upright}号による。この告示は<i>個人情報保護法施行規則[15]{.tate-chu-yoko}条[1]{.upright}項の各号のいづれにも該当する外国等</i>を定めるものであり、同条は

> 第十五条　==法第二十八条==第一項の規定による個人情報の保護に関する制度を有している外国として……

としていることに注意。法[71]{.tate-chu-yoko}条の規定には係らないため、日本の*行政機関*から EU への個人データの移転は、十分性認定の枠組みでは認められていない。逆（EU から[公共部門団体への移転](#公共部門団体への移転)）も同様。

また、EU による日本の<ruby>十分性認定<rt lang="en">Adequacy decision</ruby>は、個人情報保護法の適用を受ける組織への、<i>追加条件</i>に従ふ<ruby>移転<rt lang="en">Transfer</ruby>に限定されてをり、EU[^3] 域内で取得した個人データが無条件に日本に<ruby>移転<rt lang="en">Transfer</ruby>できるといふわけではない[^4]。[Commission Implementing Decision (EU) 2019/419](https://eur-lex.europa.eu/eli/dec_impl/2019/419/oj){lang=en}（<i>決定</i>）リサイタル[4]{.upright}には次のやうにある（脚注は省略した。）:

[^3]: 右引用に倣って、この記事では、地域について言ふときは、クロアチアを含む EU 加盟国[27]{.tate-chu-yoko}か国、およびスイスを除く EFTA 加盟国[3]{.upright}か国、合はせて[30]{.tate-chu-yoko}か国を差して「EU」と言ふ。なほ、クロアチアは、[2014]{.upright}年から EEA を暫定的に適用しているが、EEA 加盟国ではない。
[^4]: カナダと同様に「[\(private-sector organisations\)]{lang=en}」などゝ付記した方が良いと思ふ。

<div class="blockquote-like">

  委員会は日本の法律と慣行を注意深く分析してきた。委員会は、リサイタル[6]{.upright}から[175]{.upright}で展開される調査結果に基づいて、日本は、個人情報の保護に関する法律<sup>(5)</sup>の適用範囲内にあり、かつ==この決定で言及する追加条件に従ふ==組織に移転される個人データについて、適切なレベルの保護を保證すると結論付ける。これらの条件は、個人情報保護委員会 (PPC)<sup>(6)</sup> が策定した補完的ルール（附属書 I）ならびに日本政府による欧州委員会への公式の説明、表明およびコミットメント（附属書 II）に規定されている。

</div>

+++ 原文
<blockquote lang="en">

  The Commission has carefully analysed Japanese law and practice. Based on the findings developed in recitals 6 to 175, the Commission concludes that Japan ensures an adequate level of protection for personal data transferred to organisations falling within the scope of application of the Act on the Protection of Personal Information (<sup>5</sup>) and ==subject to the additional conditions referred to in this Decision==. These conditions are laid down in the Supplementary Rules (Annex I) adopted by the Personal Information Protection Commission (PPC) (<sup>6</sup>) and the official representations, assurances and commitments by the Japanese government to the European Commission (Annex II).

</blockquote>
+++

なほ、日本が十分性認定を行ふ外国[^5]は、クロアチアを含む EU 加盟国、スイスを除く EFTA 加盟国、およびイギリスの[31]{.tate-chu-yoko}か国のみ。イギリスは [Brexit]{lang=en} 時点（[2020]{.upright}年[1]{.upright}月[31]{.tate-chu-yoko}日）における EU の十分性認定をそのまゝ引き継いでいる。[UK approach to international data transfers - GOV.UK](https://www.gov.uk/government/publications/uk-approach-to-international-data-transfers){lang=en} も参照。

[^5]: 個人情報保護法[28]{.tate-chu-yoko}条[1]{.upright}項における「個人の権利利益を保護する上で我が国と同等の水準にあると認められる個人情報の保護に関する制度を有している外国」。

## 公共部門団体への移転

EU 域内から日本の行政機関や独立行政法人等への移転は、<i>決定</i>では認められていない。<i>決定</i>リサイタル[10]{.tate-chu-yoko}には、

<div class="blockquote-like">

  後者の[2]{.upright}つの法律（[2016]{.upright}年に改正された。）には、公共部門団体による個人情報の保護に適用される規定が含まれる。これらの法律の適用範囲内にあるデータ処理は、本決定に含まれる十分性認定（個人情報保護法の〔規定する〕意味における<mark>「==個人情報取扱事業者==」による個人情報の保護に限定される。</mark>）の対象ではない。

</div>

+++ 原文
<blockquote lang="en">

  The two latter acts (amended in 2016) contain provisions applicable to the protection of personal information by public sector entities. Data processing falling within the scope of application of those acts is not the object of the adequacy finding contained in this Decision, <mark>which is limited to the protection of personal information by "==Personal Information Handling Business Operators==" (PIHBOs)</mark> within the meaning of the APPI.

</blockquote>
+++

とあり、個人情報保護法[16]{.tate-chu-yoko}条[2]{.upright}項には、

> この章及び第六章から第八章までにおいて「==個人情報取扱事業者==」とは、個人情報データベース等を事業の用に供している者をいう。==ただし、次に掲げる者を除く==。
>
> 1.  国の機関
> 1.  地方公共団体
> 1.  独立行政法人等
> 1.  地方独立行政法人

とある。

### 展開

デジタル社会の形成を図るための関係法律の整備に関する法律（<i>整備法</i>）では、<i>学術研究分野を含めた GDPR（EU 一般データ保護規則）の十分性認定への対応を目指し、学術研究に係る適用除外規定について、一律の適用除外ではなく、義務ごとの例外規定として精緻化</i>することゝなった[^7]。<i>整備法</i>[50]{.tate-chu-yoko}条（個人情報保護法の一部改正）は[2022]{.upright}年[4]{.upright}月[1]{.upright}日に施行された。

[^7]: [法令｜デジタル庁](https://www.digital.go.jp/laws/)も参照。

また、<i>決定</i>リサイタル[181]{.upright}は、発効後[2]{.upright}年以内に最初のレビューを行ひ、その後は少なくとも[4]{.upright}年ごとにレビューを行ふとしている。最初のレビュー会合は、オンラインで、[2021]{.upright}年[10]{.tate-chu-yoko}月[26]{.tate-chu-yoko}日に行はれた[^8]。

[^8]: [Joint statement](https://ec.europa.eu/newsroom/just/items/724795/en){lang=en}

<i>整備法</i>[50]{.tate-chu-yoko}条は、<i>最初のレビュー</i>の[5]{.upright}か月後に施行されたゝめ、<i>決定</i>にはまだ反映されていない。[3]{.upright}年後のレビューでは、この改正についても議論されるだらう[^6]。

[^6]:
    GDPR <ruby>[45]{.tate-chu-yoko}条[3]{.upright}項<rt lang="en">Article 45(3)</ruby>には、

    <div class="blockquote-like">

      その実施法は、定期的な（少なくとも[4]{.upright}年ごとに行はれる）レビューの仕組みを規定するものとし、==そのレビューは、その第三国または国際機関における全ての関連する進展を考慮に入れるものとする==。

    </div>

    +++ 原文
    <blockquote lang="en">

      The implementing act shall provide for a mechanism for a periodic review, at least every four years, ==which shall take into account all relevant developments in the third country or international organisation==.

    </blockquote>
    +++

    とある。

[2023]{.upright}年[4]{.upright}月[4]{.upright}日に行はれたレビュー会合では、右<i>整備法</i>[50]{.tate-chu-yoko}条の施行など（同法[51]{.tate-chu-yoko}条の施行なども考慮された。）を受けて、EU から日本への十分性認定の範囲を学術研究分野や公的部門などに拡大する可能性を模索することで合意された[^9]。

[^9]: [Joint Press Statement](https://commission.europa.eu/news/joint-press-statement-conclusion-first-review-japan-eu-mutual-adequacy-arrangement-2023-04-04_en){lang=en}

## 追加条件

<i>追加条件</i>については、個人情報保護委員会が附属書 I の日本語版と附属書 II の参考仮訳を公開している:

附属書 I
: [個人情報の保護に関する法律に係る EU 域内及び英国から十分性認定により移転を受けた個人データの取扱いに関する補完的ルール \(PDF\)](https://www.ppc.go.jp/files/pdf/Supplementary_Rules.pdf)

附属書 II
: [法執行及び国家安全保障目的の日本の公的機関による個人情報の収集及び使用 \(PDF\)](https://www.ppc.go.jp/files/pdf/kariyaku_government_access.pdf)

---

**このサイトは法解釈を行はず、法律意見を提供しない。**[CC-BY-SA-4.0](https://github.com/sueka/sueka.me/blob/master/LICENSE){lang=en} <ruby>[5]{.upright}条<rt lang="en">Section 5</ruby>も参照されたい。
