# sueka.me

[sueka.me](//sueka.me) は、私の個人ブログです。このリポジトリでは、このブログのソースコードをホストしてゐます。

[![Build Status](https://travis-ci.org/sueka/sueka.me.svg?branch=master)](https://travis-ci.org/sueka/sueka.me)

## 他言語版

- [English](./README.md)

## 使用例

`bundle exec jekyll build --source source` を実行すると、 `_site` ディレクトリが生成されます。

ブラウザーテストを行ふには、 `bundle exec jekyll serve --source source` を実行してローカルサーバーを立ち上げてから `bundle exec rspec` を実行します。

### デプロイメント

[sueka.me](https://sueka.me) は Travis CI によって自動デプロイされてゐます。 master ブランチがコミットされると、 Travis は、そのブランチからドキュメントルートディレクトリをビルドし、 HTML ファイルを検査し、生成されたディレクトリを ConoHa にデプロイします。

`http` としてログインするときは、あらかじめ `usermod --shell /bin/bash http` を実行してください。

手動でデプロイする場合は、 `scp -r _site/ http@203.0.113.89:/srv/http/www/html` のやうなコマンドを実行するか、他の方法を用ゐるかして、 `_site` ディレクトリをサーバーにアップロードしてください。

## ライセンス

[CC0 1.0 Universal](./UNLICENSE.txt) (English)
