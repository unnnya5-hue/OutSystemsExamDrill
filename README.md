# OS資格ドリル

OutSystems資格対策向けのiOS学習アプリです。`exam_app_prototype_1.html` のUIと問題データをSwiftUIへ移植したMVPです。

## MVP

- ODC Agentic AI Specialization 70問、O11 Architecture Specialist 30問の予想問題を収録
- 教材タブは資格一覧からODC / O11を選んで学習教材へ移動
- 練習モード、模試モード、誤答復習、ブックマーク復習
- ODCは生成AI基礎、エージェント設計、OutSystems実装、デプロイ、直前暗記を章別に確認
- O11はArchitecture Canvas、設計プロセス、ECS、検証ルール、リファクタリングを章別に確認
- 模試タイマー、合格ライン判定、ドメイン別スコア
- 成績履歴、誤答リスト、ブックマークを端末内に保存

## 初期リリース方針

- ログイン: なし
- 課金: なし
- 広告: Google Mobile Ads SDK
  - App Open: `ca-app-pub-6961277874965643/1714177546`
  - Banner: `ca-app-pub-6961277874965643/1686292775`
  - Interstitial: `ca-app-pub-6961277874965643/7706694657`
- 外部通信: AdMob広告配信とオンライン確認のためあり
- オフライン利用: 不可
- 保存先: 端末内 `UserDefaults`

## 広告仕様

- 画面下部にバナー広告を常時表示します。
- 起動時と5分以上バックグラウンド後の復帰時にApp Open広告を表示候補にします。
- クイズ完了後にインタースティシャル広告を表示候補にします。
- 教材詳細から一覧へ戻るタイミングで、3教材に1回インタースティシャル広告を表示候補にします。
- 全画面広告はApp OpenとInterstitialを合わせて最低75秒の間隔を空けます。
- 問題回答中、教材閲覧中、画面遷移の毎タップ直後、起動直後のInterstitialは表示しません。
- インターネット未接続時は学習画面を表示せず、接続が必要な旨を表示します。

## Xcode

- Project: `OutSystemsExamDrill.xcodeproj`
- Scheme: `OutSystemsExamDrill`
- Bundle ID: `com.kairi.OutSystemsExamDrill`
- Display Name: `OS資格ドリル`
- Version / Build: `1.0 / 1`
- AdMob App ID: `ca-app-pub-6961277874965643~4120849032`
