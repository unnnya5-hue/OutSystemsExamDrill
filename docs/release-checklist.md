# リリースチェックリスト

## 実装

- [x] アプリ名を `OS資格ドリル` に設定
- [x] Bundle ID を `com.kairi.OutSystemsExamDrill` に設定
- [x] Version / Build を `1.0 / 1` に設定
- [x] ライトモード固定
- [x] 輸出コンプライアンス用 `ITSAppUsesNonExemptEncryption = NO` を設定
- [x] ログインなし
- [x] Google Mobile Ads SDKを追加
- [x] AdMob App IDを設定
- [x] App Open広告を設定
- [x] バナー広告を設定
- [x] インタースティシャル広告を設定
- [x] 全画面広告の最低75秒間隔を設定
- [x] App Open広告を起動時と5分以上バックグラウンド後の復帰時に制限
- [x] クイズ完了後のインタースティシャル表示候補を設定
- [x] 教材詳細から一覧へ戻るタイミングで3教材に1回のインタースティシャル表示候補を設定
- [x] アプリ内課金なし
- [x] AdMob広告配信用の外部通信あり
- [x] オフライン時はアプリ利用不可
- [x] 端末内保存
- [x] Privacy Manifestで端末内保存（UserDefaults）の利用理由を宣言

## App Store Connect

- [ ] Apple DeveloperでBundle IDを作成
- [ ] App Store Connectで新規アプリを作成
- [x] サポートURLを公開
- [x] プライバシーポリシーURLを公開
- [x] スクリーンショットを作成
- [ ] 年齢レーティング回答
- [ ] Appプライバシー回答
- [x] app-ads.txtをDeveloper Websiteのホスト直下で公開
- [ ] ArchiveしてUpload
- [ ] ビルド処理完了後に審査提出

## AdMob確認

- [x] App ID: `ca-app-pub-6961277874965643~4120849032`
- [x] App Open Unit ID: `ca-app-pub-6961277874965643/1714177546`
- [x] Banner Unit ID: `ca-app-pub-6961277874965643/1686292775`
- [x] Interstitial Unit ID: `ca-app-pub-6961277874965643/7706694657`
- [ ] AdMob側でiOSアプリを登録
- [x] Developer Websiteのホスト直下に`app-ads.txt`を配置
- [ ] 実機で本番広告またはAdMob側の配信状態を確認

## 提出前検索

以下がRelease提出物に残っていないことを確認します。

- `ca-app-pub-3940256099942544`
- `広告テスト`
- `テスト通知`
- `Debug`
- `TODO`

以下の本番IDがRelease提出物に含まれていることを確認します。

- `ca-app-pub-6961277874965643~4120849032`
- `ca-app-pub-6961277874965643/1714177546`
- `ca-app-pub-6961277874965643/1686292775`
- `ca-app-pub-6961277874965643/7706694657`
