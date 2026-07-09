# App Store Connect 登録情報まとめ

最終更新: 2026-07-09

## 1. Apple DeveloperでBundle IDを作成

Apple Developer > Certificates, Identifiers & Profiles > Identifiers > + から作成します。

- 種別: App IDs
- Type: App
- App ID Type: Explicit App ID
- Description: OS資格ドリル
- Bundle ID: `com.kairi.OutSystemsExamDrill`
- Capabilities: 追加ONなし

補足:

- Xcode側のBundle Identifierも `com.kairi.OutSystemsExamDrill` です。
- Push Notifications、iCloud、Sign in with Apple、Game Center、Associated Domains、App Groupsは現状不要です。
- In-App PurchaseはExplicit App IDで既定有効になる場合がありますが、アプリ実装としてはアプリ内課金なしです。

## 2. App Store Connectで新規アプリ作成

App Store Connect > Apps > + > New App で作成します。

- Platforms: iOS
- Name: OS資格ドリル
- Primary Language: Japanese
- Bundle ID: `com.kairi.OutSystemsExamDrill`
- SKU: `os-certification-drill-ios`
- User Access: Full Access

## 3. App情報

- App名: OS資格ドリル
- サブタイトル: OutSystems資格の予想問題で反復学習
- カテゴリ: Education
- 価格: Free
- 配信地域: 日本から開始推奨
- 対応デバイス: iPhone / iPad
- 最小iOS: iOS 18.0
- バージョン: 1.0
- ビルド番号: 1
- アプリ内課金: なし
- ログイン: なし
- 広告: あり
- オフライン利用: 不可

## 4. 公開URL

- Marketing URL / Developer Website: `https://unnnya5-hue.github.io/OutSystemsExamDrill/`
- Support URL: `https://unnnya5-hue.github.io/OutSystemsExamDrill/support.html`
- Privacy Policy URL: `https://unnnya5-hue.github.io/OutSystemsExamDrill/privacy.html`
- app-ads.txt: `https://unnnya5-hue.github.io/OutSystemsExamDrill/app-ads.txt`

AdMobクロール向けに、ホスト直下の `https://unnnya5-hue.github.io/app-ads.txt` も公開済みです。

## 5. App Store掲載文

### 説明

OS資格ドリルは、OutSystems資格試験の学習をスキマ時間で進めるための予想問題アプリです。

ODC Agentic AI Specialization 70問、O11 Architecture Specialist 30問の対策問題を収録し、練習モード、模試モード、誤答復習、ブックマーク復習で理解を確認できます。教材タブでは資格一覧からODC / O11を選び、ODCの生成AI・Agentic AI・OutSystems実装要点、O11のArchitecture Canvas・設計プロセス・ECS・検証ルールを章別に確認できます。

模試では制限時間と合格ラインを意識した演習ができ、結果画面ではドメイン別の正答状況を確認できます。

本アプリの問題は公式サンプル試験のスタイルを参考にした自作の予想問題です。OutSystems社の公式アプリ、公式教材、公式試験問題ではありません。

### キーワード

OutSystems,資格,試験対策,ODC,O11,ローコード,学習,模試

## 6. App Review情報

### Sign-in information

- ログイン不要
- テストアカウント不要

### Review notes

ログインは不要です。アプリ起動後、ホームから試験を選び、練習モードまたは模試モードを開始できます。Google Mobile Ads SDKによる広告を表示します。画面下部にバナー広告を常時表示し、起動時または一定時間バックグラウンド後の復帰時にApp Open広告を表示します。インタースティシャル広告はクイズ完了後、または教材詳細から一覧へ戻る自然な区切りで表示候補にします。全画面広告には最低75秒の間隔を設け、問題回答中や教材閲覧中には表示しません。

広告配信とオンライン確認のため、インターネット接続が必要です。オフライン時は学習画面を表示せず、接続が必要な旨を表示します。成績、誤答、ブックマークは端末内に保存されます。アプリ内課金とログイン機能はありません。

本アプリはOutSystems社の公式アプリ、公式教材、公式試験問題ではありません。

## 7. Appプライバシー回答案

現在の実装前提:

- Google Mobile Ads SDKによる広告あり
- 本アプリ独自のログイン、解析SDK、クラウド同期なし
- 学習履歴、正答率、誤答、ブックマークは端末内保存のみ
- ATT許可ダイアログは未実装

推奨回答:

- データを収集しますか: はい
- Privacy Policy URL: `https://unnnya5-hue.github.io/OutSystemsExamDrill/privacy.html`
- User Privacy Choices URL: 空欄可
- Tracking: いいえ（現実装のまま、IDFA/パーソナライズ広告を使わない前提）

データタイプ候補:

- Location > Coarse Location
- Identifiers > Device ID
- Usage Data > Product Interaction
- Usage Data > Advertising Data
- Diagnostics > Crash Data
- Diagnostics > Performance Data

利用目的候補:

- Third-Party Advertising
- Analytics
- App Functionality

注意:

- AdMobでIDFA、パーソナライズ広告、他社アプリ/サイト横断トラッキングを使う運用にする場合は、提出前に `NSUserTrackingUsageDescription`、ATT許可フロー、必要に応じてGoogle User Messaging Platformの同意管理を追加し、Trackingを「はい」に更新してください。
- App Store Connectの最終回答は、AdMob管理画面の広告設定とGoogleの最新開示情報に合わせて確認してください。

## 8. 年齢レーティング回答案

- 対象年齢: 子ども向けとして申告しない
- 暴力表現: なし
- 性的表現: なし
- 医療・治療情報: なし
- ギャンブル: なし
- ユーザー生成コンテンツ: なし
- 外部Web検索・任意URL表示: なし
- 無制限Webアクセス: なし
- 正確な位置情報取得: なし
- 広告: あり

想定レーティング: 4+

## 9. 輸出コンプライアンス

- `ITSAppUsesNonExemptEncryption`: `NO`
- 独自暗号、非標準暗号、VPN、金融暗号機能なし
- App Store Connectで暗号に関する質問が出た場合は、非免除暗号を使っていない前提で回答します。

## 10. Content Rights / 知的財産

- アプリはOutSystems社の公式アプリではありません。
- 説明文とサポートページに非公式である旨を記載済みです。
- 問題・教材は自作の予想問題・要約教材として扱います。
- 公式教材や試験問題の原文転載が含まれていないことを提出前に確認してください。

## 11. スクリーンショット

対応デバイスがiPhone/iPadのため、最低限以下を用意します。

- iPhone 6.9インチ用: 1290 x 2796、1320 x 2868、または 1260 x 2736 の縦画像
- iPad 13インチ用: 2048 x 2732 または 2064 x 2752 の縦画像
- 枚数: 各デバイスサイズで3〜5枚推奨

候補画面:

- ホーム/資格選択
- クイズ画面
- 結果画面
- 教材一覧
- 教材詳細

## 12. AdMob情報

- App ID: `ca-app-pub-6961277874965643~4120849032`
- App Open Unit ID: `ca-app-pub-6961277874965643/1714177546`
- Banner Unit ID: `ca-app-pub-6961277874965643/1686292775`
- Interstitial Unit ID: `ca-app-pub-6961277874965643/7706694657`

運用:

- バナー: 全画面下部に常時表示
- App Open: 起動時、5分以上バックグラウンド後の復帰時
- クイズ完了後: 毎回インタースティシャル表示候補
- 教材閲覧後: 3教材に1回インタースティシャル表示候補
- 全画面広告の最低間隔: 75秒
- 問題回答中、教材閲覧中、起動直後のインタースティシャルは出さない

## 13. まだ必要な作業

- Apple DeveloperでBundle ID作成
- App Store Connectで新規アプリ作成
- Appプライバシー回答入力
- 年齢レーティング回答入力
- スクリーンショット作成
- AdMob側でiOSアプリ登録、App Store公開後にリンク
- XcodeでArchiveしてUpload
- App Store Connectでビルド選択、審査提出

## 14. 参考

- Apple Developer: Register an App ID
  `https://developer.apple.com/help/account/identifiers/register-an-app-id/`
- App Store Connect: Add a new app
  `https://developer.apple.com/help/app-store-connect/create-an-app-record/add-a-new-app/`
- App Store Connect: App privacy
  `https://developer.apple.com/help/app-store-connect/reference/app-information/app-privacy`
- App Store Connect: Screenshot specifications
  `https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications`
