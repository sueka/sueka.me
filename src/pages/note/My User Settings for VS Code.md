---
title: VS Code のユーザー設定
date: '2023-01-04'
lastmod: '2023-09-10'
templateEngine: null
draft: true
---
先日、多分元日、はてなブックマークで、[VScodeの設定（settings.json）まとめ【<span class="upright">2023</span>年<span class="upright">1</span>月更新】](https://zenn.dev/sayuki_coding/articles/c389d9ad48feaa)なる記事を見た。[settings]{lang=en} か [setting]{lang=en} かなどゞうでもよい[^1]けれど、蓋し VS Code の設定で最も重大なのは以下の項目だらう。誤解のないやうに明記すると、リンク先の記事は、ツールとしての VS Code の設定について、誰にでも馴染むものではないにせよ、丁寧に記述された、良い記事だと思ふ。

[^1]: 私がその機能に名前を付けるなら、設定項目が[1]{.upright}つしかなくても [setting<b>s</b>]{lang=en} とするとは思ふ。

## エディター

改行コードを LF にする。多くの言語で、言語仕様かコーディング規約で LF が要求されてゐる。<ruby>メモ帳<rt lang="en">Notepad</ruby>が CRLF しか扱へなかったのも昔の話となった:

``` json
"files.eol": "\n",
```

CSV のやうな例外は個別に設定してもよいが、ほとんどの場合、言語サポートや EditorConfig などで適切に設定されるので、何もしなくてもよい。自分で設定するなら、

``` json
"[csv]": {
  "files.eol": "\r\n",
},
```

とする。

### ファイルの自動保存

手動保存する習慣が無い[^2]ので、エディターからフォーカスが外れたらファイルが自動保存されるやうにする。`off` でなければ何でもよいと思ふ:

``` json
"files.autoSave": "onFocusChange",
```

[^2]: 以前はあったが、SaaS が増えてきたので意識してやめた。ブラウザー上で動作する SaaS で <kbd>⌘ S</kbd> または <kbd>^ S</kbd> とすると、ウェブページを保存しようとしてしまふ。

## エクスプローラー

Unicode 順に竝べ替へる。README や COPYING をスクリーミングケースにしたのは、Unicode 順で竝べられたときにより上位に表示させるためだったはずだ。結果として、GitHub と同じ順で表示されることにもなる:

``` json
"explorer.sortOrderLexicographicOptions": "unicode",
```

## ターミナル

拡張機能が環境に参加したがってゐるときに、ターミナルが自動的に再起動しないやうにする。さういふときは手動で増設したり、再起動させたりすればよい。ターミナルみたいなものが勝手に再起動して嬉しかった試しはない:

``` json
"terminal.integrated.environmentChangesRelaunch": false,
```

ターミナルが子プロセスを実行してゐるときに VS Code を終了させようとすると、確認が入るやうにする:

``` json
"terminal.integrated.confirmOnExit": "hasChildProcesses",
```

## オーディオキュー

オーディオキューの音量を 100 % にする。オーディオキューは、主にスクリーンリーダーで VS Code を操作するときに使ふ、特定の状態に遭遇したことを特別な音で通知する機能だ。私は VoiceOver くらゐしか使はないが、VO の場合、行を移動すると、移動先の内容がすぐに読み上げられる。この声のボリュームは結構大きいので、読み上げの音量設定にもよるが、デフォルト (70 %) ではキューがほとんど聞こえないことがある:

``` json
"audioCues.volume": 100,
```

## 自動更新

拡張機能は有効なものゝみ自動更新する。特定のワークスペースで有効にしてゐるものは、そのワークスペースを開くまで更新しなくてもよいはずだ:

``` json
"extensions.autoUpdate": "onlyEnabledExtensions",
```

## テレメトリ

無効にする:

``` json
"telemetry.telemetryLevel": "off",
```

拡張機能は、追加の情報を蒐集する場合、テレメトリのための固有の設定を持ってゐることがある。さういふ設定の ID は大抵、`*.telemetry.enabled` のやうな形をしてゐるので、<kbd>⌘ ,</kbd> または <kbd>^ ,</kbd> で設定を開き、検索して無効にする。

## ワークスペースの信頼

<aside>

  今、これを書くために少し調べたところ、不要な機能だと思ってゐる人もそこ<span class="kunojiten">〳〵</span>居るらしい。私の考へでは、これが有効に機能する最も一般的な場面は、リポジトリを開くときではなく、[~/Downloads]{lang=} などにあるスタンドアロンのスクリプトを開くときだと思ふ。

</aside>

幸ひにも最近のバージョンでは、親ディレクトリを信頼できるやうになった。当初はできなかったと思ふ。自分のリポジトリを格納してゐる場所を信頼しよう。<kbd>⇧ ⌘ P</kbd> または <kbd>^ ⇧ P</kbd> でコマンドパレットを開いて、<i lang="en">Workspaces: Manage Workspace Trust</i> を実行し、<i>信頼済みフォルダーとワークスペース</i>に追加する。*かういふことを手作業で行ふと、その部分に関する精神的安定が得られる*。

## 外観

カラースキームを自動検出する。私は OS のライトテーマ[/]{.upright}ダークテーマをよく（と言っても、日に数回程度だが、）変更するので、できるだけ多くのアプリを同様に設定してゐる:

``` json
"window.autoDetectColorScheme": true,
```
