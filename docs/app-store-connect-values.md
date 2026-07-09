# App Store Connect 入力案

## 基本情報

- プラットフォーム: iOS
- 名前: OS資格ドリル
- プライマリ言語: 日本語
- Bundle ID: com.kairi.OutSystemsExamDrill
- SKU: os-certification-drill-ios
- カテゴリ: 教育
- 価格: 無料
- ログイン: 不要
- 課金: なし
- 広告: あり
- 外部サーバー通信: Google Mobile Ads SDKによる広告配信
- オフライン利用: 不可

## 公開URL

- Marketing URL / Developer Website: `https://unnnya5-hue.github.io/OutSystemsExamDrill/`
- サポートURL: `https://unnnya5-hue.github.io/OutSystemsExamDrill/support.html`
- プライバシーポリシーURL: `https://unnnya5-hue.github.io/OutSystemsExamDrill/privacy.html`
- app-ads.txt: `https://unnnya5-hue.github.io/OutSystemsExamDrill/app-ads.txt`

AdMobのapp-ads.txtクロールはDeveloper Websiteのホスト直下も確認します。GitHub Pagesのプロジェクト配下URLをDeveloper Websiteに使う場合でも、`https://unnnya5-hue.github.io/app-ads.txt` は公開済みです。

## サブタイトル

OutSystems資格の予想問題で反復学習

## 説明

OS資格ドリルは、OutSystems資格試験の学習をスキマ時間で進めるための予想問題アプリです。

ODC Agentic AI Specialization 70問、O11 Architecture Specialist 30問の対策問題を収録し、練習モード、模試モード、誤答復習、ブックマーク復習で理解を確認できます。教材タブでは資格一覧からODC / O11を選び、ODCの生成AI・Agentic AI・OutSystems実装要点、O11のArchitecture Canvas・設計プロセス・ECS・検証ルールを章別に確認できます。

模試では制限時間と合格ラインを意識した演習ができ、結果画面ではドメイン別の正答状況を確認できます。

本アプリの問題は公式サンプル試験のスタイルを参考にした自作の予想問題です。OutSystems社の公式アプリ、公式教材、公式試験問題ではありません。

## キーワード案

OutSystems,資格,試験対策,ODC,O11,ローコード,学習,模試

## App Review メモ案

ログインは不要です。アプリ起動後、ホームから試験を選び、練習モードまたは模試モードを開始できます。Google Mobile Ads SDKによる広告を表示します。画面下部にバナー広告を常時表示し、起動時または一定時間バックグラウンド後の復帰時にApp Open広告を表示します。インタースティシャル広告はクイズ完了後、または教材詳細から一覧へ戻る自然な区切りで表示候補にします。全画面広告には最低75秒の間隔を設け、問題回答中や教材閲覧中には表示しません。

広告配信とオンライン確認のため、インターネット接続が必要です。オフライン時は学習画面を表示せず、接続が必要な旨を表示します。成績、誤答、ブックマークは端末内に保存されます。アプリ内課金とログイン機能はありません。

## AdMob設定

- App ID: `ca-app-pub-6961277874965643~4120849032`
- App Open Unit ID: `ca-app-pub-6961277874965643/1714177546`
- Banner Unit ID: `ca-app-pub-6961277874965643/1686292775`
- Interstitial Unit ID: `ca-app-pub-6961277874965643/7706694657`
