import Foundation

enum ExamCatalog {
    static let odcQuestions: [DrillQuestion] = [
        DrillQuestion(
            id: "odc-0",
            domain: 1,
            kind: "定義",
            prompt: "事前学習済みLLMの『学習データのカットオフ（知識の鮮度の限界）』と『専門知識の欠如』を、外部検索で補って回答に反映させる技術はどれか。",
            options: ["RAG（検索拡張生成）", "ファインチューニング", "プロンプトチェイニング", "構造化出力"],
            answerIndex: 0,
            explanation: "RAGは検索で関連情報を取得しプロンプトに与えることで、最新知識・ドメイン知識の不足を補い、回答をグラウンディングする。",
            source: "ODCのAIモデルと検索サービス"
        ),
        DrillQuestion(
            id: "odc-1",
            domain: 1,
            kind: "設定",
            prompt: "要約タスクで、毎回ほぼ同じ安定した（決定論的な）出力を得たい。調整すべきパラメータと方向の組み合わせはどれか。",
            options: ["Temperature を高くする", "Temperature を低くする", "Max Tokens を増やす", "Stop を空にする"],
            answerIndex: 1,
            explanation: "Temperature は出力のランダム性を制御する。低いほど決定論的で安定し、高いほど多様になる。",
            source: "ODCのAIモデルと検索サービス"
        ),
        DrillQuestion(
            id: "odc-2",
            domain: 1,
            kind: "定義",
            prompt: "reason-act ループの最中に中間結果を保持し、単一タスク内で完結するメモリはどれか。",
            options: ["短期メモリ", "作業メモリ", "長期メモリ", "ドメイン知識"],
            answerIndex: 1,
            explanation: "作業メモリ（working memory）は単一タスク内で reason-act ループの中で更新される一時的な状態。短期メモリは単一セッション、長期メモリは複数セッションに永続。",
            source: "ODCのエージェント型アプリ"
        ),
        DrillQuestion(
            id: "odc-3",
            domain: 1,
            kind: "定義",
            prompt: "長期メモリ（複数セッションにまたがる永続化）の実装に用いられるストレージはどれか。",
            options: ["リレーショナルデータベース", "ベクトルデータベース", "セッションキャッシュ", "ローカルファイル"],
            answerIndex: 1,
            explanation: "長期メモリはベクトルデータベース（Vector DB）で実装され、複数セッションをまたいで情報を永続化する。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-4",
            domain: 1,
            kind: "設定",
            prompt: "AIモデル呼び出しで Max Tokens の上限を超える出力が発生した場合の挙動はどれか。",
            options: ["エラーをスローして停止する", "応答が切り詰められる（エラーは出ない）", "自動的に再試行される", "Temperature が下がる"],
            answerIndex: 1,
            explanation: "Max Tokens は出力長の上限で、超過すると応答が切り詰められるがエラーは出ない。プロセスを停止＋エラーにするのは Call condition。",
            source: "AIモデルと検索サービスを連携する（ODC）"
        ),
        DrillQuestion(
            id: "odc-5",
            domain: 2,
            kind: "定義",
            prompt: "ReAct ループの3段階の正しい順序はどれか。",
            options: ["Action → Thought → Observation", "Thought → Action → Observation", "Observation → Thought → Action", "Thought → Observation → Action"],
            answerIndex: 1,
            explanation: "ReAct は Thought（思考）→ Action（行動）→ Observation（観察）を、タスク完了まで繰り返す。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-6",
            domain: 2,
            kind: "比較",
            prompt: "シングルエージェントに対するマルチエージェント構成の主な利点として最も正確なものはどれか。",
            options: ["1回の推論で全タスクを完結できる", "モジュール性が高く、独立して開発・テスト・置換できる", "常にトークン消費が少ない", "システムプロンプトが不要になる"],
            answerIndex: 1,
            explanation: "マルチエージェントは各エージェントがスコープ限定の個別サービスとなるため、独立した開発・テスト・差し替えが可能でモジュール性が高い。",
            source: "ODCのエージェント型アプリ"
        ),
        DrillQuestion(
            id: "odc-7",
            domain: 2,
            kind: "パターン",
            prompt: "独立した複数のサブタスクを同時実行して処理を高速化し、最後に結果を1つに合成するパターンはどれか。",
            options: ["シーケンシャル", "並行（Parallel）", "ルーター", "ヒューマン・イン・ザ・ループ"],
            answerIndex: 1,
            explanation: "並行パターンは ディスパッチャが分割→ワーカーが同時実行→アグリゲータが合成、の流れで動く。独立サブタスクに分割できる場合に最適。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-8",
            domain: 2,
            kind: "パターン",
            prompt: "一元的なコントローラを持たず、複数の自律エージェントが事前定義ルールで直接、交渉・連携・競争するパターンはどれか。",
            options: ["階層", "スーパーバイザー", "ネットワーク", "共有メモリ"],
            answerIndex: 2,
            explanation: "ネットワークパターンは一元コントローラなしの共有環境で動作する（例：市場経済の売買交渉シミュレーション）。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-9",
            domain: 2,
            kind: "パターン",
            prompt: "受信リクエストの意図を分析して最適な下流エージェントへ振り分けるが、その後のタスクのライフサイクルには関与しないパターンはどれか。",
            options: ["ルーター", "スーパーバイザー", "アグリゲータ", "ループ"],
            answerIndex: 0,
            explanation: "ルーターは意図を分類して転送するのみ。計画→委任→監視→取りまとめとライフサイクル全体に関与するのはスーパーバイザー。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-10",
            domain: 3,
            kind: "挙動",
            prompt: "AgentFlow で、システムメッセージ（ペルソナ等の基盤メッセージ）を組み立てて挿入するアクションはどれか。",
            options: ["GetGroundingData", "BuildMessages", "Call<Model>", "StoreMemory"],
            answerIndex: 1,
            explanation: "BuildMessages がシステムメッセージを組み立てて挿入する。4アクションの順序は GetGroundingData→BuildMessages→Call<Model>→StoreMemory。",
            source: "ODC Studioでエージェント作成（ODC）"
        ),
        DrillQuestion(
            id: "odc-11",
            domain: 3,
            kind: "挙動",
            prompt: "Action calling の Call condition の式が True と評価されたときの挙動はどれか。",
            options: ["出力を切り詰めるがエラーは出ない", "実行を停止しエラーをスローする", "Temperature を再設定する", "次のアクションを並列実行する"],
            answerIndex: 1,
            explanation: "Call condition は各アクション後に式を評価し、True で実行停止＋エラースロー（無限ループ防止）。切り詰めるのは Max Tokens。",
            source: "AIエージェントのアクション（ODC）"
        ),
        DrillQuestion(
            id: "odc-12",
            domain: 3,
            kind: "比較",
            prompt: "Call condition と Max Tokens の違いとして正しいものはどれか。",
            options: ["どちらも出力を切り詰める", "Call condition は停止＋エラー、Max Tokens は切り詰めでエラーなし", "Call condition は出力長制御、Max Tokens はループ制御", "両者は同じ設定の別名"],
            answerIndex: 1,
            explanation: "Call condition はプロセス制御でエラーをスロー、Max Tokens は出力制御で切り詰めるだけ（エラーなし）。混同が典型的なディストラクタ。",
            source: "AIエージェントのアクション（ODC）"
        ),
        DrillQuestion(
            id: "odc-13",
            domain: 3,
            kind: "目的",
            prompt: "サーバーアクションが LLM に確実に解釈・選択される仕組みはどれか。",
            options: ["アクションのソースコードをそのまま渡す", "名前・説明・型を分析し構造化JSONスキーマに変換する", "Temperature を0にする", "アクションを画像化して渡す"],
            answerIndex: 1,
            explanation: "アクションのメタデータ（名前・説明・入力パラメータ）がJSONスキーマ化され、LLMが解釈・選択できる形になる。詳細な説明ほど精度が上がる。",
            source: "AIエージェントのアクション（ODC）"
        ),
        DrillQuestion(
            id: "odc-14",
            domain: 3,
            kind: "設定",
            prompt: "RAG用の検索コンテンツとして登録するドキュメントの最大サイズはどれか。",
            options: ["2MB／ドキュメント", "16MB／ドキュメント", "20MB／ドキュメント", "100MB／ドキュメント"],
            answerIndex: 1,
            explanation: "RAGドキュメントは最大16MB／ドキュメント。チャンクは2〜3ページが目安。画像入力の20MBと取り違えない。",
            source: "検索サービスを追加する（ODC）"
        ),
        DrillQuestion(
            id: "odc-15",
            domain: 3,
            kind: "設定",
            prompt: "AIモデルへの画像入力で許容される最大サイズはどれか。",
            options: ["2MB／画像", "16MB／画像", "20MB／画像", "50MB／画像"],
            answerIndex: 2,
            explanation: "画像入力は最大20MB／画像。形式は PNG/JPEG/WebP/GIF（アニメなし）。RAGドキュメントの16MBと区別する。",
            source: "AIモデルでの画像入力（ODC）"
        ),
        DrillQuestion(
            id: "odc-16",
            domain: 3,
            kind: "挙動",
            prompt: "エージェント型アプリ内のイベントをトリガーするワークフローをデプロイする場合、正しいデプロイ順序はどれか。",
            options: ["ワークフローを先にデプロイする", "エージェント型アプリを先にデプロイする", "同時にデプロイしなければならない", "順序は問わない"],
            answerIndex: 1,
            explanation: "エージェント型アプリを先にターゲットステージへデプロイする。存在しないと依存関係の欠落でワークフローのデプロイがブロックされる。",
            source: "アセットのデプロイ（ODC）"
        ),
        DrillQuestion(
            id: "odc-17",
            domain: 3,
            kind: "比較",
            prompt: "同一ステージにおける複数リビジョンの可否について正しいものはどれか。",
            options: ["アプリもワークフローも複数可", "ワークフローは複数可、アプリは1つのみ（上書き）", "アプリは複数可、ワークフローは1つのみ", "どちらも1つのみ"],
            answerIndex: 1,
            explanation: "ワークフローは同一ステージに複数リビジョンを設定でき、実行中インスタンスは新デプロイの影響を受けない。アプリは1リビジョンのみで上書きされる。",
            source: "アセットのデプロイ（ODC）"
        ),
        DrillQuestion(
            id: "odc-18",
            domain: 3,
            kind: "挙動",
            prompt: "アプリ内のサーバーアクションを、他アプリ（web/agentic）から再利用できるよう公開する方法はどれか。",
            options: ["Public プロパティを Yes にするだけ", "右クリック → Expose as Service Action", "Static entity に変換する", "Library に移動する"],
            answerIndex: 1,
            explanation: "サーバーアクションは直接 Public にできない。右クリック → Expose as Service Action でサービスアクション化して公開する。",
            source: "Reuse elements across apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-19",
            domain: 3,
            kind: "挙動",
            prompt: "Action calling と Structured output の併用について正しいものはどれか。",
            options: ["同一の Call Agent 呼び出しで併用できる", "同一の Call Agent 呼び出しでは併用できない", "Structured output は Action calling の前提である", "両者は常に同時に有効化される"],
            answerIndex: 1,
            explanation: "Action calling と Structured output は同一の Call Agent 呼び出しでは併用できない。用途に応じて使い分ける。",
            source: "AIエージェントのアクション／Structured output（ODC）"
        ),
        DrillQuestion(
            id: "odc-20",
            domain: 1,
            kind: "定義",
            prompt: "RAGがLLMに提供する、回答を外部情報で根拠づける働きを何と呼ぶか。",
            options: ["ファインチューニング", "グラウンディング", "トークン化", "オーケストレーション"],
            answerIndex: 1,
            explanation: "RAGはドメイン固有のグラウンディング（根拠づけ）を提供し、回答を外部の検索結果で裏付ける。",
            source: "ODCのAIモデルと検索サービス"
        ),
        DrillQuestion(
            id: "odc-21",
            domain: 1,
            kind: "定義",
            prompt: "単一セッション内のみ有効で、モデルの有限なコンテキストウィンドウに依存するメモリはどれか。",
            options: ["短期メモリ", "作業メモリ", "長期メモリ", "ドメイン知識"],
            answerIndex: 0,
            explanation: "短期メモリは単一セッション内のみ有効で、モデルのコンテキストウィンドウに依存する。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-22",
            domain: 1,
            kind: "設定",
            prompt: "アイデア出しのように、多様で創造的な出力が欲しいとき temperature はどうするか。",
            options: ["高くする", "低くする", "0にする", "変更しない"],
            answerIndex: 0,
            explanation: "temperature を高くすると出力の多様性・ランダム性が増す。安定・再現性が欲しいときは低くする。",
            source: "ODCのAIモデルと検索サービス"
        ),
        DrillQuestion(
            id: "odc-23",
            domain: 1,
            kind: "定義",
            prompt: "製品マニュアルなど、LLMが本来持たない専門知識を検索で回答に反映させる仕組み（ドメイン知識の実装）はどれか。",
            options: ["RAG", "短期メモリ", "Temperature 調整", "Stop シーケンス"],
            answerIndex: 0,
            explanation: "ドメイン知識はRAGで実装し、LLMが持たない専門・最新情報を検索で補う。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-24",
            domain: 1,
            kind: "手順",
            prompt: "RAGのコンテンツ準備で推奨される、1チャンクあたりのサイズの目安はどれか。",
            options: ["1文ごと", "2〜3ページ", "1ドキュメント丸ごと", "50ページ以上"],
            answerIndex: 1,
            explanation: "チャンクは2〜3ページが目安。トークン制限を超えるとRAGが失敗するため、小さいファイル・高密度コンテキストが推奨される。",
            source: "検索サービスを追加する（ODC）"
        ),
        DrillQuestion(
            id: "odc-25",
            domain: 2,
            kind: "比較",
            prompt: "自律エージェント（Autonomous agent）と直接モデル利用（Direct model use）の違いとして正しいものはどれか。",
            options: ["自律エージェントは決定論的、直接利用は動的", "自律エージェントはReActで動的に判断、直接利用は要約・分類など決定論的", "両者に違いはない", "直接利用のみがツールを使える"],
            answerIndex: 1,
            explanation: "自律エージェントはReActループで動的に判断して複雑な多段タスクを処理する。直接利用は要約・分類など決定論的な使い方。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-26",
            domain: 2,
            kind: "パターン",
            prompt: "専門エージェントのチームが共通ワークスペースで投稿と改良を、終了条件を満たすまで繰り返すパターンはどれか。",
            options: ["シーケンシャル", "ループ", "ルーター", "ネットワーク"],
            answerIndex: 1,
            explanation: "ループパターンは共通タスクで協働し、投稿→確認/批評/追加→終了条件まで反復する（例：信頼性90%まで改良するレビューアー）。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-27",
            domain: 2,
            kind: "パターン",
            prompt: "計画→委任→監視→取りまとめと、タスクのライフサイクル全体に関与する一元的オーケストレータはどれか。",
            options: ["ルーター", "スーパーバイザー", "アグリゲータ", "共有メモリ"],
            answerIndex: 1,
            explanation: "スーパーバイザーは一元的オーケストレータとして計画・委任・監視・取りまとめを行い、ライフサイクル全体に関与する。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-28",
            domain: 2,
            kind: "パターン",
            prompt: "『ブラックボード』と呼ばれる共通リポジトリを介し、エージェントが共有状態の変更で暗黙的にやりとりするパターンはどれか。",
            options: ["共有メモリ", "ネットワーク", "階層", "並行"],
            answerIndex: 0,
            explanation: "共有メモリパターンはブラックボード（共通データリポジトリ）に集約し、全エージェントが読み書き権限を持ち暗黙的にやりとりする。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-29",
            domain: 2,
            kind: "パターン",
            prompt: "信頼スコアが低い／高リスクな分岐で意図的にAI処理を一時停止し、人間にApprove/Rejectを求めるパターンはどれか。",
            options: ["ルーター", "スーパーバイザー", "ヒューマン・イン・ザ・ループ", "アグリゲータ"],
            answerIndex: 2,
            explanation: "HITLは自動処理→トリガーポイント（低信頼/高リスク）→人間の介入、という流れ。例：ベンダー承認で人間がApprove/Reject。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-30",
            domain: 3,
            kind: "挙動",
            prompt: "AgentFlow が実行する4アクションの正しい順序はどれか。",
            options: ["BuildMessages → GetGroundingData → Call<Model> → StoreMemory", "GetGroundingData → BuildMessages → Call<Model> → StoreMemory", "GetGroundingData → Call<Model> → BuildMessages → StoreMemory", "StoreMemory → GetGroundingData → BuildMessages → Call<Model>"],
            answerIndex: 1,
            explanation: "順序は GetGroundingData（根拠取得）→ BuildMessages（メッセージ組立）→ Call<Model>（モデル呼出）→ StoreMemory（状態保存）。",
            source: "ODC Studioでエージェント作成（ODC）"
        ),
        DrillQuestion(
            id: "odc-31",
            domain: 3,
            kind: "挙動",
            prompt: "コンシューマー側で新しい会話セッションを開始するとき、SessionId はどう用意するか。",
            options: ["固定の文字列を使う", "空なら GenerateGuid で新規生成して代入する", "エージェントが自動採番する", "ユーザーIDをそのまま使う"],
            answerIndex: 1,
            explanation: "SessionId が空のとき GenerateGuid で新規生成し代入する。以降は同じ SessionId でセッションを継続する。",
            source: "アプリでAIエージェントを利用する（ODC）"
        ),
        DrillQuestion(
            id: "odc-32",
            domain: 3,
            kind: "挙動",
            prompt: "エージェントの会話状態を永続化する AgentFlow のアクションはどれか。",
            options: ["GetGroundingData", "BuildMessages", "StoreMemory", "Call<Model>"],
            answerIndex: 2,
            explanation: "StoreMemory が会話状態を保存する。根拠取得は GetGroundingData。",
            source: "ODC Studioでエージェント作成（ODC）"
        ),
        DrillQuestion(
            id: "odc-33",
            domain: 3,
            kind: "設定",
            prompt: "AIエージェント呼び出しのタイムアウトに対する第一の対策はどれか。",
            options: ["Temperature を下げる", "Server Request Timeout を60秒にする", "Max Tokens を増やす", "モデルを変更する"],
            answerIndex: 1,
            explanation: "まずアプリのプロパティ（または各 Call Agent アクション）で Server Request Timeout を60秒に設定する。60秒超が必要なら非同期化する。",
            source: "AIエージェント呼び出しのタイムアウトを処理する（ODC）"
        ),
        DrillQuestion(
            id: "odc-34",
            domain: 3,
            kind: "挙動",
            prompt: "60秒を超える処理を扱う非同期管理の構成要素として正しい組み合わせはどれか。",
            options: ["Temperature と Max Tokens", "Queueエンティティ・ポーリング・Timer", "Structured output と Call condition", "Static entity と Theme"],
            answerIndex: 1,
            explanation: "非同期管理は Queue/Request エンティティ＋イベントトリガー＋ポーリング用クライアントアクション＋完了項目を消す Timer で構成する。",
            source: "AIエージェント呼び出しのタイムアウトを処理する（ODC）"
        ),
        DrillQuestion(
            id: "odc-35",
            domain: 3,
            kind: "挙動",
            prompt: "ワークフローとエージェントの連携を主に担い、人間の介入なしに実行されるフロー要素はどれか。",
            options: ["Human Activity", "Automatic Activity", "Decision", "Start"],
            answerIndex: 1,
            explanation: "Automatic Activity が、対応するサービスアクション（Call<...>Agent）を呼び出してエージェントと連携する。",
            source: "エージェント型ワークフローを作成する（ODC）"
        ),
        DrillQuestion(
            id: "odc-36",
            domain: 3,
            kind: "挙動",
            prompt: "ループワークフローで Decision が False（品質基準を満たさない）と評価されたとき、フローはどこへ接続するか。",
            options: ["End へ進む", "前のステップ（エージェント呼び出し前）へ戻して再実行", "Human Activity へ進む", "Start へ戻る"],
            answerIndex: 1,
            explanation: "False ブランチは前のステップ（エージェント呼び出し前）へ戻し、フィードバックを反映して再実行する（Go to Previous step）。",
            source: "エージェント型ワークフローを作成する（ODC）"
        ),
        DrillQuestion(
            id: "odc-37",
            domain: 3,
            kind: "挙動",
            prompt: "ヒューマン・イン・ザ・ループのワークフローを実装する要素はどれか。",
            options: ["Automatic Activity", "Decision", "Human Activity ブロック", "Parallel"],
            answerIndex: 2,
            explanation: "Human Activity ブロックがワークフローを一時停止し、人間が確認・Approve/Reject するまで待機する。",
            source: "エージェント型ワークフローを作成する（ODC）"
        ),
        DrillQuestion(
            id: "odc-38",
            domain: 3,
            kind: "比較",
            prompt: "依存タイプについて正しい組み合わせはどれか。",
            options: ["ワークフロー→アプリは強い依存", "ライブラリ↔アプリは弱い依存", "ワークフロー→アプリは弱い依存、ライブラリ↔アプリは強い依存", "すべて強い依存"],
            answerIndex: 2,
            explanation: "独立デプロイされる関係（アプリ↔アプリ、ワークフロー→アプリ）は弱い依存。独立デプロイされないライブラリ・コネクションは強い依存。",
            source: "Reuse elements across apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-39",
            domain: 3,
            kind: "挙動",
            prompt: "アプリのデプロイ時、同名のアプリがターゲットステージに存在する場合に発生し、デプロイを止めるものはどれか。",
            options: ["警告（続行可能）", "ブロック要因（デプロイ不可）", "Finished with errors", "リビジョン番号の自動増加"],
            answerIndex: 1,
            explanation: "アプリ名の競合はブロック要因で、デプロイできない。warning は producer/consumer 関連で続行可能。",
            source: "アセットのデプロイ（ODC）"
        ),
        DrillQuestion(
            id: "odc-40",
            domain: 1,
            kind: "設定",
            prompt: "生成中に指定した文字列が現れた時点でLLMの出力を停止させるパラメータはどれか。",
            options: ["Temperature", "Max Tokens", "Stop", "ExtraBody"],
            answerIndex: 2,
            explanation: "Stop は指定文字列が現れたら生成を停止する。Temperature はランダム性、Max Tokens は出力長、ExtraBody はモデル固有の追加パラメータ。",
            source: "AIモデルと検索サービスを連携する（ODC）"
        ),
        DrillQuestion(
            id: "odc-41",
            domain: 1,
            kind: "定義",
            prompt: "AIモデル（LLM）に対して「AIエージェント」を最も正確に説明したものはどれか。",
            options: ["より大きなパラメータ数を持つLLM", "モデルにツール・データ・コンテキストを与え、知覚・判断・行動できるようにしたもの", "画像も扱えるLLM", "会話履歴を保持するLLM"],
            answerIndex: 1,
            explanation: "エージェント＝モデル＋ツール・データ・コンテキスト。知覚し、判断し、行動できる点がモデル単体との違い。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-42",
            domain: 1,
            kind: "比較",
            prompt: "Direct model use（直接モデル利用）が適しているタスクはどれか。",
            options: ["複数ツールを使い分ける調査タスク", "要約・分類など入力に対して定型的に応答するタスク", "長期にわたる対話の記憶", "外部システムの操作"],
            answerIndex: 1,
            explanation: "直接利用は要約・分類など決定論的なタスク向き。動的な判断が必要な多段タスクは自律エージェント（ReAct）の領域。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-43",
            domain: 1,
            kind: "挙動",
            prompt: "AI検索サービスの検索結果に含まれる要素の組み合わせとして正しいものはどれか。",
            options: ["スニペット・メタデータ・関連性スコア", "画像・音声・動画", "SQL・実行計画・統計", "トークン数・温度・停止語"],
            answerIndex: 0,
            explanation: "検索結果はスニペット・メタデータ・関連性スコアで構成され、これをコンテキストとしてプロンプトに組み込む。",
            source: "AIモデルと検索サービスを連携する（ODC）"
        ),
        DrillQuestion(
            id: "odc-44",
            domain: 1,
            kind: "設定",
            prompt: "RAG用コンテンツの対応形式として正しいものはどれか。",
            options: ["Markdown／プレーンテキスト／PDF（画像はOCR処理）", "Excel／PowerPointのみ", "動画ファイルを含む全形式", "ZIPアーカイブのみ"],
            answerIndex: 0,
            explanation: "対応形式は Markdown／プレーンテキスト／PDF。PDF内の画像はOCRで取り込まれる。",
            source: "検索サービスを追加する（ODC）"
        ),
        DrillQuestion(
            id: "odc-45",
            domain: 1,
            kind: "挙動",
            prompt: "RAGでコンテキストがトークン制限を超過した場合の挙動はどれか。",
            options: ["自動で要約される", "RAGが失敗する", "古い情報から削除される", "温度が自動調整される"],
            answerIndex: 1,
            explanation: "トークン制限を超えるとRAGは失敗する。小さいファイル・高密度なコンテキスト（チャンク2〜3ページ）で準備するのが対策。",
            source: "検索サービスを追加する（ODC）"
        ),
        DrillQuestion(
            id: "odc-46",
            domain: 1,
            kind: "設定",
            prompt: "モデル固有の追加パラメータをリクエストに渡すための拡張枠はどれか。",
            options: ["Stop", "ExtraBody", "SessionId", "UserInput"],
            answerIndex: 1,
            explanation: "ExtraBody はモデル固有の追加パラメータを渡す拡張枠。標準パラメータ（Temperature/MaxTokens/Stop）で足りない設定に使う。",
            source: "AIモデルと検索サービスを連携する（ODC）"
        ),
        DrillQuestion(
            id: "odc-47",
            domain: 2,
            kind: "パターン",
            prompt: "タスクを小さなステップに分割し、専用エージェントが順番に処理して前段の出力を次段の入力とするパターンはどれか。",
            options: ["並行", "シーケンシャル", "ネットワーク", "共有メモリ"],
            answerIndex: 1,
            explanation: "シーケンシャルパターン。前段の出力が次段の入力になる直列構成で、モジュール性が高い（例：収集→法務→財務のレビュー）。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-48",
            domain: 2,
            kind: "パターン",
            prompt: "複数ソースから情報を収集し、マージ・ランク付け・フィルタして単一の出力にまとめる役割はどれか。",
            options: ["ディスパッチャ", "アグリゲータ", "ルーター", "スーパーバイザー"],
            answerIndex: 1,
            explanation: "アグリゲータは複数ソースから収集して合成する。タスクを分配するディスパッチャとは逆向きの役割。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-49",
            domain: 2,
            kind: "パターン",
            prompt: "スーパーバイザーをマルチレベルに拡張し、上位→中間マネージャー→ワーカーへ再帰的に委任する構成はどれか。",
            options: ["階層パターン", "ループパターン", "共有メモリパターン", "並行パターン"],
            answerIndex: 0,
            explanation: "階層パターンはスーパーバイザーの多段構成。大規模ソフトウェア開発のように大きな組織的タスクに適する。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-50",
            domain: 2,
            kind: "挙動",
            prompt: "ヒューマン・イン・ザ・ループで人間の介入を発動させる「トリガーポイント」の例として適切なものはどれか。",
            options: ["処理が高速に完了したとき", "信頼スコアが低い・高リスクな金融取引のとき", "トークン消費が少ないとき", "画像が添付されたとき"],
            answerIndex: 1,
            explanation: "HITLは低信頼・高リスクの分岐で意図的に停止し人間の判断を仰ぐ。自動処理→トリガーポイント→人間の介入、の流れ。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-51",
            domain: 2,
            kind: "挙動",
            prompt: "ループパターンで反復が終了するのはどんなときか。",
            options: ["1回実行したら必ず終了", "事前に定義した終了条件（例：信頼性90%超）を満たしたとき", "人間が毎回停止したとき", "トークンが尽きたときのみ"],
            answerIndex: 1,
            explanation: "ループは終了条件を満たすまで投稿と改良を繰り返す（例：レポートの信頼性が90%を超えるまで）。",
            source: "エージェントのパターン（ODC）"
        ),
        DrillQuestion(
            id: "odc-52",
            domain: 2,
            kind: "定義",
            prompt: "AIエージェントを構成する「基礎3要素」の組み合わせとして正しいものはどれか。",
            options: ["画面・データベース・API", "グラウンディング・システムプロンプト・状態の永続性", "温度・トークン・停止語", "入力・出力・ログ"],
            answerIndex: 1,
            explanation: "基礎3要素はグラウンディング（GetGroundingData）／システムプロンプト（BuildMessages）／状態の永続性（StoreMemory）。",
            source: "ODCのエージェント型アプリ"
        ),
        DrillQuestion(
            id: "odc-53",
            domain: 2,
            kind: "挙動",
            prompt: "エージェントに外部ツールを接続する方法として正しい組み合わせはどれか。",
            options: ["カスタムMCPサーバー、またはビルド済みコネクタ（SerpAPI等）", "FTPアップロードのみ", "メール添付", "画面スクレイピングのみ"],
            answerIndex: 0,
            explanation: "外部ツールはオープン標準のカスタムMCPサーバー、またはビルド済みコネクタとして接続する。",
            source: "ODCのエージェント型アプリ"
        ),
        DrillQuestion(
            id: "odc-54",
            domain: 2,
            kind: "挙動",
            prompt: "自律エージェントが ReAct ループを繰り返すのはいつまでか。",
            options: ["必ず3回まで", "タスクが完了するか終了条件を満たすまで", "ユーザーが停止するまでのみ", "モデルが変更されるまで"],
            answerIndex: 1,
            explanation: "ReAct（Thought→Action→Observation）はタスク完了または終了条件まで繰り返される。",
            source: "Build AI-powered apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-55",
            domain: 3,
            kind: "手順",
            prompt: "外部AIモデルをODCに接続する3ステップの正しい順序はどれか。",
            options: ["ODC Studioで追加→Portal統合→Provider設定", "Cloud Provider側で設定→ODC Portalで統合を構成→ODC Studioでアプリに追加", "Portal統合→Provider設定→Studio追加", "Studio追加のみで完結"],
            answerIndex: 1,
            explanation: "①Cloud Provider側で設定（Bedrock/OpenAI等）②ODC Portalで統合を構成 ③ODC Studioでアプリにpublic要素として追加。",
            source: "AI models and search services in ODC"
        ),
        DrillQuestion(
            id: "odc-56",
            domain: 3,
            kind: "設定",
            prompt: "AIモデルのトライアル枠として正しい組み合わせはどれか。",
            options: ["Azure OpenAI 1000コール／Bedrock 100コール", "Azure OpenAI 100コール／Bedrock 1000コール", "両方とも無制限", "トライアルは存在しない"],
            answerIndex: 1,
            explanation: "トライアルは Azure OpenAI 100コール／Bedrock 1000コール。Developmentステージで利用できる。数値の入れ替えに注意。",
            source: "AI models and search services in ODC"
        ),
        DrillQuestion(
            id: "odc-57",
            domain: 3,
            kind: "挙動",
            prompt: "Call<AIモデル名> の Response で、Messages[0] の Role はどれか。",
            options: ["user", "assistant", "system", "tool"],
            answerIndex: 1,
            explanation: "リクエストでは Role=user で送り、レスポンスの Messages[0] は Role=assistant として返る。",
            source: "AIモデルと検索サービスを連携する（ODC）"
        ),
        DrillQuestion(
            id: "odc-58",
            domain: 3,
            kind: "挙動",
            prompt: "レスポンスの ModelUsage に含まれる情報の組み合わせとして正しいものはどれか。",
            options: ["InputTokens／ResponseTokens／TotalTokens", "Temperature／Stop／ExtraBody", "SessionId／UserId／AppId", "CPU使用率／メモリ使用率"],
            answerIndex: 0,
            explanation: "ModelUsage は InputTokens・ResponseTokens・TotalTokens を保持し、消費量の監視やコスト管理に使う。",
            source: "AIモデルと検索サービスを連携する（ODC）"
        ),
        DrillQuestion(
            id: "odc-59",
            domain: 3,
            kind: "手順",
            prompt: "ODC Studio で新しいエージェントを追加する場所はどれか。",
            options: ["Interface > Screens", "Automations > Agents を右クリック > Add Agent", "Data > Entities", "Logic > Server Actions"],
            answerIndex: 1,
            explanation: "エージェントは Automations > Agents を右クリック > Add Agent で追加する。AIモデルは public 要素としてアプリに追加しておく。",
            source: "Creating an agent in ODC Studio"
        ),
        DrillQuestion(
            id: "odc-60",
            domain: 3,
            kind: "設定",
            prompt: "AIモデルへの画像入力で対応している形式の組み合わせはどれか。",
            options: ["PNG／JPEG／WebP／GIF（アニメーションなし）", "BMP／TIFFのみ", "SVG／EPS", "RAWのみ"],
            answerIndex: 0,
            explanation: "対応形式は PNG/JPEG/WebP/GIF（アニメーション不可）。最大20MB/画像、NSFW不可。",
            source: "AIモデルでの画像入力（ODC）"
        ),
        DrillQuestion(
            id: "odc-61",
            domain: 3,
            kind: "挙動",
            prompt: "画像をAIモデルに渡す2つの方法の組み合わせとして正しいものはどれか。",
            options: ["ContentUrl（公開URL）／ContentBinaryData（Base64）", "FTP／SFTP", "画面キャプチャ／印刷", "メール添付／チャット添付"],
            answerIndex: 0,
            explanation: "渡し方は ContentUrl（公開URL）と ContentBinaryData（Base64）の2通り。UserMessage.Content 内にコンテンツアイテムとして追加する。",
            source: "AIモデルでの画像入力（ODC）"
        ),
        DrillQuestion(
            id: "odc-62",
            domain: 3,
            kind: "挙動",
            prompt: "テキスト専用のAIモデルに画像を入力した場合の挙動はどれか。",
            options: ["自動でOCRされる", "非対応エラーになる", "画像が無視されて成功する", "低解像度に変換される"],
            answerIndex: 1,
            explanation: "画像入力にはマルチモーダルモデルが必要。テキスト専用モデルでは非対応エラーになる。",
            source: "AIモデルでの画像入力（ODC）"
        ),
        DrillQuestion(
            id: "odc-63",
            domain: 3,
            kind: "手順",
            prompt: "Structured output を設定する最初の操作はどれか。",
            options: ["Portal で契約を変更する", "Call Agent をダブルクリックし Structured output タブを開く", "Entities を削除する", "Timer を追加する"],
            answerIndex: 1,
            explanation: "Call Agent をダブルクリック → Structured output タブ → Add structure で構造を割り当てる。各フィールドに Description を付ける。",
            source: "Structured output（ODC）"
        ),
        DrillQuestion(
            id: "odc-64",
            domain: 3,
            kind: "挙動",
            prompt: "Structured output を使う際、Response パラメータはどうするか。",
            options: ["Text型のまま使う", "事前定義した構造型（例：Book）に変更する", "Integer型に変更する", "削除する"],
            answerIndex: 1,
            explanation: "Response パラメータを構造型に変更することで、事前定義した構造どおりに出力を受け取れる。",
            source: "Structured output（ODC）"
        ),
        DrillQuestion(
            id: "odc-65",
            domain: 3,
            kind: "挙動",
            prompt: "Call Agent の Test タブで確認できる項目の組み合わせとして正しいものはどれか。",
            options: ["応答・タイムスタンプ・AIモデル情報・入出力トークン数", "CPU・メモリ・ディスク・ネットワーク", "画面・テーマ・フォント・色", "ユーザー数・セッション数"],
            answerIndex: 0,
            explanation: "メッセージテストで確認できるのは、応答／タイムスタンプ／AIモデル情報／入出力トークン数の4項目。",
            source: "メッセージをテストする（ODC）"
        ),
        DrillQuestion(
            id: "odc-66",
            domain: 3,
            kind: "設定",
            prompt: "Server Request Timeout（60秒）を設定できる場所として正しいものはどれか。",
            options: ["アプリのプロパティ（Call Agent アクション側でも個別設定可）", "ODC Portal の請求画面", "端末のOS設定", "データベース接続文字列"],
            answerIndex: 0,
            explanation: "ODC Studioでアプリのプロパティから設定する。Call Agentアクション側でも個別に60秒を設定できる。",
            source: "AIエージェント呼び出しのタイムアウトを処理する（ODC）"
        ),
        DrillQuestion(
            id: "odc-67",
            domain: 3,
            kind: "挙動",
            prompt: "ライブラリの公開要素を他アプリで消費するための前提条件はどれか。",
            options: ["ライブラリがリリース済みであること", "ライブラリを削除すること", "Portalで課金設定すること", "End-Userレイヤーに置くこと"],
            answerIndex: 0,
            explanation: "ライブラリの公開要素を消費するには、そのライブラリがリリース済みである必要がある。Add public elements ウィンドウから追加する。",
            source: "Reuse elements across apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-68",
            domain: 3,
            kind: "挙動",
            prompt: "弱い依存（アプリ↔アプリ等）のリビジョン解決ルールはどれか。",
            options: ["常に最古のリビジョンを使う", "消費側アプリが動作する同一ステージに現在デプロイされているリビジョンを使う", "乱数で選ばれる", "開発者が毎回手動選択する"],
            answerIndex: 1,
            explanation: "弱い依存は、同一ステージに現在デプロイされているリビジョンを使用する。強い依存は直接参照するリビジョンを使う。",
            source: "Reuse elements across apps（ODC）"
        ),
        DrillQuestion(
            id: "odc-69",
            domain: 3,
            kind: "設定",
            prompt: "Production への初回デプロイ時に提案されるセマンティックバージョンはどれか。",
            options: ["1.0.0", "0.0.1", "0.1.0", "9.9.9"],
            answerIndex: 2,
            explanation: "初期提案は 0.1.0。メジャー.マイナー.パッチ形式で、以前と同じか以上のバージョンに変更できる。",
            source: "アセットのデプロイ（ODC）"
        ),
    ]

    static let o11Questions: [DrillQuestion] = [
        DrillQuestion(
            id: "o11-0",
            domain: 1,
            kind: "定義",
            prompt: "Architecture Canvas の3つのレイヤーを上から順に並べたものはどれか。",
            options: ["Core → End-User → Foundation", "End-User → Core → Foundation", "Foundation → Core → End-User", "End-User → Foundation → Core"],
            answerIndex: 1,
            explanation: "上から End-User（UI層）→ Core（コアビジネス層）→ Foundation(基盤層)。OS11で Orchestration レイヤーは非推奨となり3層構成。",
            source: "Architecture Canvas の基礎（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-1",
            domain: 1,
            kind: "挙動",
            prompt: "OutSystems 11 で非推奨（削除）となったレイヤーはどれか。",
            options: ["Core", "Foundation", "Orchestration", "End-User"],
            answerIndex: 2,
            explanation: "OS11では画面参照が弱い依存となったため、複数UIを統合する Orchestration レイヤーは不要となり非推奨に。",
            source: "Architecture Canvas の基礎（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-2",
            domain: 1,
            kind: "定義",
            prompt: "End-User レイヤーの重要ルールとして正しいものはどれか。",
            options: ["他モジュールへ積極的にサービスを提供する", "他のモジュールにサービスを提供してはならない", "外部システム接続をここに置く", "汎用ライブラリを配置する"],
            answerIndex: 1,
            explanation: "End-Userモジュールが他から参照されるとライフサイクルの独立性が損なわれる。サービス提供はCore/Foundationの役割。",
            source: "Architecture Canvas の基礎（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-3",
            domain: 1,
            kind: "設定",
            prompt: "顧客エンティティとその登録・更新ロジックをカプセル化するモジュールに最適なサフィックスはどれか。",
            options: ["_is", "_CS", "_th", "_lib"],
            answerIndex: 1,
            explanation: "_CS（Core Service）はビジネスエンティティと操作アクションをカプセル化する。_is は外部接続、_th はテーマ、_lib は汎用ライブラリ。",
            source: "命名規約（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-4",
            domain: 1,
            kind: "設定",
            prompt: "外部SAPシステムとの接続をラップし、データ構造を正規化するモジュールのレイヤーとサフィックスの組み合わせはどれか。",
            options: ["Core／_BL", "Foundation／_is", "End-User／_pat", "Core／_sync"],
            answerIndex: 1,
            explanation: "外部システム連携は Foundation レイヤーの _is（Integration Service）。ビジネスロジックを持たない純粋な接続層として設計する。",
            source: "命名規約（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-5",
            domain: 1,
            kind: "挙動",
            prompt: "Coreレイヤーで公開するエンティティのベストプラクティスはどれか。",
            options: ["Read Only = Yes とし、操作はカプセル化したアクション経由にする", "Public = No にする", "直接 CRUD を許可する", "End-User に移動する"],
            answerIndex: 0,
            explanation: "公開エンティティは Read Only = Yes とし、データ操作は必ずアクション経由にすることで整合性と監査を強制できる。",
            source: "Coreレイヤー（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-6",
            domain: 2,
            kind: "定義",
            prompt: "アーキテクチャ設計プロセスの3ステップの正しい順序はどれか。",
            options: ["Organize → Disclose → Assemble", "Disclose → Organize → Assemble", "Assemble → Organize → Disclose", "Disclose → Assemble → Organize"],
            answerIndex: 1,
            explanation: "Disclose（把握）→ Organize（整理）→ Assemble（組み立て）。ビジネス要件をモジュール構造へ変換する反復プロセス。",
            source: "設計プロセス（連載第2回）"
        ),
        DrillQuestion(
            id: "o11-7",
            domain: 2,
            kind: "目的",
            prompt: "外部システムのデータを OutSystems 側にレプリカとして保持し、バッチで定期同期するECSパターンはどれか。",
            options: ["Direct Integration", "Batch Sync", "Lazy Load", "Transparency Service"],
            answerIndex: 1,
            explanation: "Batch Sync は外部データのローカルレプリカをタイマー等で定期同期する。外部システムの負荷や可用性の影響を抑えられる。",
            source: "ECSパターン（連載第3回）"
        ),
        DrillQuestion(
            id: "o11-8",
            domain: 2,
            kind: "目的",
            prompt: "初回アクセス時にオンデマンドで外部データを取得し、以後キャッシュを利用するECSパターンはどれか。",
            options: ["Cold Cache", "Hot Cache", "Lazy Load", "Real-time Sync"],
            answerIndex: 2,
            explanation: "Lazy Load は必要になった時点で取得してキャッシュする。全件を事前同期しないためデータ量が多い場合に有効。",
            source: "ECSパターン（連載第3回）"
        ),
        DrillQuestion(
            id: "o11-9",
            domain: 2,
            kind: "挙動",
            prompt: "ローカルのレプリカ更新と同時に外部システムへも書き込む方針を何と呼ぶか。",
            options: ["Write-through", "Read-only", "Fire-and-forget", "Eventual copy"],
            answerIndex: 0,
            explanation: "Write-through はローカルと外部の両方へ同期的に書き込み、整合性を保つポリシー。ECSの書き込み設計で頻出。",
            source: "ECSパターン（連載第3回）"
        ),
        DrillQuestion(
            id: "o11-10",
            domain: 2,
            kind: "比較",
            prompt: "ライフサイクルが異なる2つのビジネス概念を同一モジュールに置くべきでない主な理由はどれか。",
            options: ["ライセンス消費が増える", "デプロイと進化の独立性が失われる", "命名規約に違反する", "CSSが競合する"],
            answerIndex: 1,
            explanation: "ライフサイクルの異なる概念を分離することで、互いに影響なく独立して変更・デプロイできる（設計プロセスの分割基準）。",
            source: "設計プロセス（連載第2回）"
        ),
        DrillQuestion(
            id: "o11-11",
            domain: 2,
            kind: "目的",
            prompt: "複数のコアサービスを組み合わせて複雑なビジネスルールを実現するモジュールのサフィックスはどれか。",
            options: ["_CS", "_BL", "_is", "_pat"],
            answerIndex: 1,
            explanation: "_BL（Business Logic）は複数の _CS をオーケストレーションする層。単一エンティティのカプセル化（_CS）と区別する。",
            source: "命名規約（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-12",
            domain: 3,
            kind: "定義",
            prompt: "モジュール依存関係の3つの検証ルールに含まれないものはどれか。",
            options: ["上方参照の禁止", "End-User間サイド参照の禁止", "循環参照の禁止", "画面遷移の禁止"],
            answerIndex: 3,
            explanation: "3ルールは①上方参照禁止 ②End-User間サイド参照禁止（画面遷移=弱い参照は除く）③循環参照禁止。画面遷移自体は禁止されない。",
            source: "アーキテクチャ検証（連載第4回）"
        ),
        DrillQuestion(
            id: "o11-13",
            domain: 3,
            kind: "挙動",
            prompt: "下位レイヤーが上位レイヤーを参照すると発生する典型的な問題はどれか。",
            options: ["デプロイ時に不要モジュールを芋づる式に引き連れる巨大クラスター", "CSSの上書き", "ライセンス違反", "タイマーの停止"],
            answerIndex: 0,
            explanation: "上方参照はデプロイ単位を巨大化させる。再利用したい要素は下位（Core）へ昇格させて解決する。",
            source: "アーキテクチャ検証（連載第4回）"
        ),
        DrillQuestion(
            id: "o11-14",
            domain: 3,
            kind: "目的",
            prompt: "循環参照が発生している場合、設計上の何に問題があることを示唆するか。",
            options: ["ライセンスの消費過多", "コンセプトの抽象化が正しく行われていない", "モジュール名が長すぎる", "CSSの適用ミス"],
            answerIndex: 1,
            explanation: "循環参照は概念の分離が不適切であるサイン。共通概念を下位レイヤーへ切り出して解消する。",
            source: "アーキテクチャ検証（連載第4回）"
        ),
        DrillQuestion(
            id: "o11-15",
            domain: 3,
            kind: "比較",
            prompt: "End-Userモジュール間で共有したいUIブロックがある場合の正しい対処はどれか。",
            options: ["End-User同士で直接参照する", "Coreレイヤーへ昇格させて共有する", "Foundationのテーマに埋め込む", "コピーして複製する"],
            answerIndex: 1,
            explanation: "End-User間のサイド参照は禁止。再利用したい要素はCoreレイヤー（Core Widgets等）へ昇格させるのが正解。",
            source: "アーキテクチャ検証（連載第4回）"
        ),
        DrillQuestion(
            id: "o11-16",
            domain: 3,
            kind: "定義",
            prompt: "アプリケーション構成の4ルールに含まれるものはどれか。",
            options: ["所有者の混合禁止", "画面数の上限", "タイマーの禁止", "単一言語の強制"],
            answerIndex: 0,
            explanation: "4ルールは モジュールのレイヤー化／アプリのレイヤー化／所有者の混合禁止／スポンサーの混合禁止。デプロイ独立性を守るための規律。",
            source: "アプリ構成の4ルール（連載第6回）"
        ),
        DrillQuestion(
            id: "o11-17",
            domain: 3,
            kind: "挙動",
            prompt: "リファクタリングでエンティティを別モジュールへ移動する際に特に注意すべき点はどれか。",
            options: ["色の設定", "データとURL・DBリンクを壊さない移行手順", "フォントの統一", "タイマー名"],
            answerIndex: 1,
            explanation: "エンティティ移動はデータ移行・参照切替を伴う。URLやDBリンクを壊さずサービスを抽出する手順（7ステップ）に従う。",
            source: "リファクタリング実践（連載第5回）"
        ),
        DrillQuestion(
            id: "o11-18",
            domain: 1,
            kind: "定義",
            prompt: "Foundation レイヤーの役割として最も適切なものはどれか。",
            options: ["エンドユーザー向けの画面を提供する", "ビジネスロジックを持たない再利用可能なサービス（外部連携・テーマ・ライブラリ等）を提供する", "業務エンティティを直接公開する", "ワークフローを実行する"],
            answerIndex: 1,
            explanation: "Foundationは非ビジネスの基盤層。外部システム連携（_is）、テーマ（_th）、汎用ライブラリ（_lib）などを配置する。",
            source: "Architecture Canvas の基礎（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-19",
            domain: 1,
            kind: "定義",
            prompt: "Core レイヤーの役割として最も適切なものはどれか。",
            options: ["画面とUIパターンの提供", "ビジネスエンティティ・ビジネスルールなどコアビジネス概念のカプセル化", "外部システムとの低レベル接続", "アプリのアイコン管理"],
            answerIndex: 1,
            explanation: "Coreはビジネス概念（エンティティ・ルール・サービス）をカプセル化する層。UIはEnd-User、非ビジネス基盤はFoundation。",
            source: "Architecture Canvas の基礎（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-20",
            domain: 1,
            kind: "設定",
            prompt: "アプリ共通のルック&フィール（スタイル・レイアウト）を提供するモジュールのサフィックスはどれか。",
            options: ["_CS", "_BL", "_th", "_is"],
            answerIndex: 2,
            explanation: "_th（Theme）はFoundationレイヤーでスタイルやレイアウトを提供する。_CSはコアサービス、_BLはビジネスロジック、_isは外部連携。",
            source: "命名規約（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-21",
            domain: 1,
            kind: "設定",
            prompt: "特定ビジネスに依存しない汎用ユーティリティ（例：文字列処理・日付計算）を集約するモジュールのサフィックスはどれか。",
            options: ["_lib", "_CS", "_Eng", "_sync"],
            answerIndex: 0,
            explanation: "_lib（Library）はFoundationレイヤーの汎用ライブラリ。ビジネス概念を含めない点がポイント。",
            source: "命名規約（連載第1回）"
        ),
        DrillQuestion(
            id: "o11-22",
            domain: 2,
            kind: "定義",
            prompt: "設計プロセスの「Disclose」ステップで行うことはどれか。",
            options: ["モジュールを実装する", "ビジネスコンセプト（概念）と統合ニーズを洗い出して把握する", "本番デプロイする", "画面デザインを確定する"],
            answerIndex: 1,
            explanation: "Discloseでは要件からビジネスコンセプトと統合ニーズを洗い出す。その後 Organize（整理）→ Assemble（組み立て）と進む。",
            source: "設計プロセス（連載第2回）"
        ),
        DrillQuestion(
            id: "o11-23",
            domain: 2,
            kind: "定義",
            prompt: "設計プロセスの「Organize」ステップで行うことはどれか。",
            options: ["洗い出したコンセプトを Architecture Canvas のレイヤーに配置・整理する", "コードレビューを行う", "ライセンスを購入する", "バックアップを取得する"],
            answerIndex: 0,
            explanation: "Organizeでは、Discloseで得たコンセプトをCanvasの3レイヤーへ配置して整理する。",
            source: "設計プロセス（連載第2回）"
        ),
        DrillQuestion(
            id: "o11-24",
            domain: 2,
            kind: "定義",
            prompt: "設計プロセスの「Assemble」ステップで行うことはどれか。",
            options: ["要件ヒアリング", "整理したコンセプトを推奨パターンに従いモジュール・アプリへ組み立てる", "障害対応", "監視設定"],
            answerIndex: 1,
            explanation: "Assembleでは、整理済みのコンセプトをモジュール構造・アプリ構成として組み立てる。3ステップは反復的に回す。",
            source: "設計プロセス（連載第2回）"
        ),
        DrillQuestion(
            id: "o11-25",
            domain: 2,
            kind: "目的",
            prompt: "ECSパターンで外部データのローカルレプリカを持つ主な目的はどれか。",
            options: ["外部システムの負荷・可用性・応答性能からOutSystems側を分離する", "データを二重に課金するため", "外部システムを廃止するため", "画面を減らすため"],
            answerIndex: 0,
            explanation: "レプリカにより、外部システムの負荷や停止の影響を受けにくくし、応答性能も安定させられる（Batch Sync等）。",
            source: "ECSパターン（連載第3回）"
        ),
        DrillQuestion(
            id: "o11-26",
            domain: 3,
            kind: "目的",
            prompt: "3つの検証ルール（上方参照禁止・End-User間サイド参照禁止・循環参照禁止）を守る目的として最も適切なものはどれか。",
            options: ["画面数を減らすため", "モジュールの独立したライフサイクルと影響範囲の小さいデプロイを維持するため", "ライセンス費用を下げるため", "命名を短くするため"],
            answerIndex: 1,
            explanation: "3ルールは、変更・デプロイの独立性を守り、巨大な依存クラスターの形成を防ぐための規律。",
            source: "アーキテクチャ検証（連載第4回）"
        ),
        DrillQuestion(
            id: "o11-27",
            domain: 3,
            kind: "定義",
            prompt: "アプリケーション構成4ルールの「アプリのレイヤー化」が意味するものはどれか。",
            options: ["1アプリに全レイヤーのモジュールを詰め込む", "異なるレイヤーのモジュールを同一アプリに混在させない", "アプリを1つに統合する", "レイヤーを廃止する"],
            answerIndex: 1,
            explanation: "モジュールだけでなくアプリ自体もレイヤー分けし、End-UserアプリとCore/Foundationアプリを混在させないことでデプロイ独立性を守る。",
            source: "アプリ構成の4ルール（連載第6回）"
        ),
        DrillQuestion(
            id: "o11-28",
            domain: 3,
            kind: "目的",
            prompt: "4ルールの「所有者（オーナー）の混合禁止」の主な目的はどれか。",
            options: ["チームごとの責任分界と独立したリリースサイクルを守るため", "サーバー台数を減らすため", "色使いを統一するため", "通信量を減らすため"],
            answerIndex: 0,
            explanation: "1アプリに複数チームのモジュールが混在すると、リリース調整が常に必要になる。所有者を分けることで独立して進化できる。",
            source: "アプリ構成の4ルール（連載第6回）"
        ),
        DrillQuestion(
            id: "o11-29",
            domain: 3,
            kind: "目的",
            prompt: "リファクタリングでサーバーアクションをサービスとして抽出する主な狙いはどれか。",
            options: ["強い依存を弱い依存に変え、疎結合にする", "コード行数を増やす", "画面遷移を速くする", "テーマを変更する"],
            answerIndex: 0,
            explanation: "サービス抽出により参照が疎結合（弱い依存）になり、モジュール間の独立デプロイが可能になる。",
            source: "リファクタリング実践（連載第5回）"
        ),
    ]

    static let exams: [ExamDefinition] = [
        ExamDefinition(
            id: "odc",
            name: "Agentic AI Specialization",
            shortName: "ODC",
            description: "エージェントAI開発の専門資格。20問・60分・合格70%。",
            colorHex: "#D9482B",
            passRate: 70,
            mockQuestionCount: 20,
            mockMinutes: 60,
            domains: [
                DomainDefinition(id: 1, name: "① 生成AIの基礎", shortName: "生成AI基礎"),
                DomainDefinition(id: 2, name: "② エージェント設計", shortName: "設計"),
                DomainDefinition(id: 3, name: "③ OutSystems実装", shortName: "OS実装"),
            ],
            mockMix: [1: 5, 2: 5, 3: 10],
            questions: odcQuestions
        ),
        ExamDefinition(
            id: "o11",
            name: "Architecture Specialist",
            shortName: "O11",
            description: "アーキテクチャ設計の専門資格。Canvas・ECS・検証ルールを攻略。",
            colorHex: "#1D6FA5",
            passRate: 70,
            mockQuestionCount: 15,
            mockMinutes: 45,
            domains: [
                DomainDefinition(id: 1, name: "① Canvas基礎・命名", shortName: "Canvas"),
                DomainDefinition(id: 2, name: "② 設計プロセス・ECS", shortName: "設計/ECS"),
                DomainDefinition(id: 3, name: "③ 検証・リファクタリング", shortName: "検証"),
            ],
            mockMix: [1: 5, 2: 5, 3: 5],
            questions: o11Questions
        ),
    ]

    static let upcomingExams: [UpcomingExam] = [
        UpcomingExam(name: "Associate Developer", shortName: "ODC", description: "基礎資格。問題準備中"),
        UpcomingExam(name: "Associate Reactive Developer", shortName: "O11", description: "問題準備中"),
    ]
}
