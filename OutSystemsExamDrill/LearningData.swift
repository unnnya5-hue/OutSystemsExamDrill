import Foundation

enum LearningCatalog {
    static let odcModules: [LearningModule] = [
        LearningModule(
            id: "overview",
            domainLabel: "試験概要",
            title: "試験の全体像と攻略順",
            subtitle: "20問・60分・70%合格。配点50%のOutSystems実装を先に固める。",
            colorHex: "#0F3B57",
            estimatedMinutes: 8,
            highlights: [
                "ODC Associate Developer Certification取得が前提",
                "出題は4択・単一選択。誤答ペナルティはなし",
                "ドメイン③が10問で全体の50%。最優先で反復する"
            ],
            keyFacts: [
                LearningFact(id: "overview-pass", label: "合格基準", value: "70%", note: "20問中14問正解"),
                LearningFact(id: "overview-time", label: "制限時間", value: "60分", note: "1問あたり約3分"),
                LearningFact(id: "overview-domain3", label: "最重要配点", value: "50%", note: "OutSystems実装ドメイン")
            ],
            sections: [
                LearningSection(
                    id: "overview-blueprint",
                    title: "ブループリント",
                    summary: "本試験は、ODCにおけるエージェント型AIアプリケーションの設計・実装能力を測る試験。",
                    bullets: [
                        "ドメイン①: 生成AIの基礎概念。LLM、プロンプト、ベクトルDB、RAGを扱う",
                        "ドメイン②: エージェントAIのコアと設計。ReAct、メモリ、マルチエージェントパターンを扱う",
                        "ドメイン③: OutSystemsにおけるエージェントAI。AgentFlow、Action calling、再利用、ワークフロー、デプロイを扱う"
                    ],
                    source: "試験ブループリント"
                ),
                LearningSection(
                    id: "overview-question-style",
                    title: "出題スタイル",
                    summary: "誤答選択肢は、隣接概念のすり替えが多い。設問中のキーワードで境界を見抜く。",
                    bullets: [
                        "定義系: RAG、長期メモリ、Temperatureなど用語の意味を問う",
                        "比較系: シングル/マルチエージェント、Call condition/Max Tokensなどを対比する",
                        "目的・アーキテクチャ系: 検索サービス、JSONスキーマ化、グラウンディングの役割を問う",
                        "特定設定・挙動系: 16MB、20MB、60秒、デプロイ順序など具体値や挙動を問う"
                    ],
                    source: "公式サンプル試験分析"
                )
            ]
        ),
        LearningModule(
            id: "domain1",
            domainLabel: "ドメイン①",
            title: "生成AIの基礎概念",
            subtitle: "LLM、プロンプト、メモリ、RAGを境界ごと暗記する。",
            colorHex: "#D9482B",
            estimatedMinutes: 12,
            highlights: [
                "AIモデルは推論・生成を担うLLM本体",
                "AIエージェントはモデルにツール・データ・コンテキストを与えたもの",
                "RAGは最新知識と特定ドメイン知識の不足を補い、回答をグラウンディングする"
            ],
            keyFacts: [
                LearningFact(id: "d1-temp", label: "Temperature", value: "低=安定", note: "高=多様でランダム"),
                LearningFact(id: "d1-maxtokens", label: "Max Tokens", value: "切り詰め", note: "上限超過でもエラーなし"),
                LearningFact(id: "d1-rag", label: "RAG", value: "根拠づけ", note: "外部検索で専門・最新知識を補う")
            ],
            sections: [
                LearningSection(
                    id: "d1-model-agent",
                    title: "AIモデルとAIエージェント",
                    summary: "AIモデルそのものの利用と、AIエージェントとしての利用を分けて理解する。",
                    bullets: [
                        "Direct model use: 要約・分類など、入力に対して定型的に応答する決定論的な使い方",
                        "Autonomous agent: ReActループで状況を観察し、次の行動を動的に判断する使い方",
                        "エージェントはLLMにツール、データ、コンテキストを与え、知覚・判断・行動を可能にする"
                    ],
                    source: "Build AI-powered apps"
                ),
                LearningSection(
                    id: "d1-parameters",
                    title: "プロンプトと生成パラメータ",
                    summary: "TemperatureとMax Tokensの混同は典型的なディストラクタ。",
                    bullets: [
                        "Temperatureは出力のランダム性を制御する。再現性が必要なら低くする",
                        "Max Tokensは出力長の上限。超過時は応答が切り詰められる",
                        "Stopは指定文字列が現れたら生成を停止する",
                        "ExtraBodyはモデル固有の追加パラメータを渡す拡張枠"
                    ],
                    source: "AIモデルと検索サービスを連携する"
                ),
                LearningSection(
                    id: "d1-memory",
                    title: "メモリ4種",
                    summary: "スコープと実装方法で区別する。長期メモリと作業メモリのすり替えに注意。",
                    bullets: [
                        "短期メモリ: 単一セッション内。モデルの有限なコンテキストウィンドウに依存",
                        "作業メモリ: 単一タスク内。ReActループ中の中間結果を保持",
                        "長期メモリ: 複数セッションをまたいで永続。Vector DBで実装",
                        "ドメイン知識: 外部知識。RAGで実装し、専門・最新知識を補う"
                    ],
                    source: "Build AI-powered apps"
                ),
                LearningSection(
                    id: "d1-rag",
                    title: "RAGの基本ステップ",
                    summary: "検索結果をコンテキストとしてプロンプトに組み込み、根拠に基づく回答を生成する。",
                    bullets: [
                        "ユーザーのクエリを受け取る",
                        "検索サービスで関連コンテンツ、メタデータ、関連性スコアを取得する",
                        "取得結果をコンテキストとしてプロンプトへ組み込む",
                        "LLMが根拠に基づいた回答を生成し、ユーザーに返す"
                    ],
                    source: "AIモデルと検索サービスを連携する"
                )
            ]
        ),
        LearningModule(
            id: "domain2",
            domainLabel: "ドメイン②",
            title: "エージェント設計とパターン",
            subtitle: "ReAct、メモリ、マルチエージェント10パターンを識別する。",
            colorHex: "#1D6FA5",
            estimatedMinutes: 14,
            highlights: [
                "ReActはThought → Action → Observationを繰り返す",
                "マルチエージェントはモジュール性が高く、独立して開発・テスト・置換できる",
                "ルーターとスーパーバイザーはライフサイクル全体に関与するかで区別する"
            ],
            keyFacts: [
                LearningFact(id: "d2-react", label: "ReAct順序", value: "思考→行動→観察", note: "Thought / Action / Observation"),
                LearningFact(id: "d2-parallel", label: "並行", value: "分割→同時実行→合成", note: "Dispatcher / Worker / Aggregator"),
                LearningFact(id: "d2-blackboard", label: "共有メモリ", value: "Blackboard", note: "共通データリポジトリ")
            ],
            sections: [
                LearningSection(
                    id: "d2-react",
                    title: "Reason-actループ",
                    summary: "固定手順ではなく、観察結果を次の推論に戻しながらタスクを進める。",
                    bullets: [
                        "Thought: 現状を踏まえて次に何をすべきか推論する",
                        "Action: ツール呼び出しやアクション実行など具体的な行動をとる",
                        "Observation: 行動結果を観察し、次のThoughtの材料にする",
                        "タスク完了または終了条件を満たすまで反復する"
                    ],
                    source: "Build AI-powered apps"
                ),
                LearningSection(
                    id: "d2-single-multi",
                    title: "シングル vs マルチエージェント",
                    summary: "マルチエージェントは各エージェントがスコープ限定の個別サービスになる。",
                    bullets: [
                        "独立した開発: エージェントごとに切り分けて作れる",
                        "独立したテスト: 各エージェントを単体で検証できる",
                        "独立した置換: あるエージェントだけを差し替えられる",
                        "常にトークン消費が少ない、という説明は誤り"
                    ],
                    source: "ODCのエージェント型アプリ"
                ),
                LearningSection(
                    id: "d2-pattern-flow",
                    title: "標準・並行パターン",
                    summary: "パターン名だけでなく、役割名とデータの流れをセットで覚える。",
                    bullets: [
                        "シーケンシャル: 前段の出力が次段の入力になる直列パイプライン",
                        "ループ: 投稿と改良を終了条件まで繰り返す",
                        "並行: ディスパッチャが分割し、専門ワーカーが同時実行し、アグリゲータが合成する",
                        "アグリゲータ: 複数ソースから収集し、マージ・ランク付け・フィルタ・結合する"
                    ],
                    source: "エージェントのパターン"
                ),
                LearningSection(
                    id: "d2-pattern-orchestration",
                    title: "ルーティング・コラボレーション系",
                    summary: "一元的に制御するか、共有環境で直接やりとりするかを見分ける。",
                    bullets: [
                        "ルーター: 意図を分析して下流へ振り分ける。以後のライフサイクルには関与しない",
                        "スーパーバイザー: 計画、委任、監視、取りまとめまで全体に関与する",
                        "階層: スーパーバイザーを多段化し、上位から中位、ワーカーへ委任する",
                        "ネットワーク: 一元コントローラなしで、自律エージェントが交渉・連携・競争する",
                        "HITL: 低信頼・高リスク時にAIを一時停止し、人間のApprove/Rejectを求める"
                    ],
                    source: "エージェント型ワークフロー"
                )
            ]
        ),
        LearningModule(
            id: "domain3-core",
            domainLabel: "ドメイン③",
            title: "OutSystems実装の中核",
            subtitle: "AI接続、検索サービス、AgentFlow、Action callingを重点攻略。",
            colorHex: "#2E8B57",
            estimatedMinutes: 18,
            highlights: [
                "AgentFlowの4アクション順序は最重要",
                "Call conditionはTrueで停止＋エラー。Max Tokensは切り詰めのみ",
                "Action callingとStructured outputは同一Call Agent呼び出しで併用できない"
            ],
            keyFacts: [
                LearningFact(id: "d3-rag-size", label: "RAG文書", value: "16MB", note: "1ドキュメント最大"),
                LearningFact(id: "d3-image-size", label: "画像入力", value: "20MB", note: "1画像最大"),
                LearningFact(id: "d3-timeout", label: "第一対策", value: "60秒", note: "Server Request Timeout")
            ],
            sections: [
                LearningSection(
                    id: "d3-connect",
                    title: "AIモデルと検索サービスの接続",
                    summary: "Cloud Provider、ODC Portal、ODC Studioの3段で接続する。",
                    bullets: [
                        "Cloud Provider側でBedrock、OpenAIなどを設定する",
                        "ODC Portalで統合を構成する",
                        "ODC Studioでアプリに追加し、public要素として利用する",
                        "接続ごとに複数エンドポイントと日次使用上限を構成できる"
                    ],
                    source: "AI models and search services in ODC"
                ),
                LearningSection(
                    id: "d3-search",
                    title: "検索サービスとRAGコンテンツ",
                    summary: "Azure AI Search、AWS Kendra、カスタム検索を追加し、RAGの土台にする。",
                    bullets: [
                        "対応形式はMarkdown、プレーンテキスト、PDF。画像はOCR処理される",
                        "ドキュメント最大サイズは16MB",
                        "チャンクは2〜3ページが目安",
                        "高密度なコンテキストを用意し、トークン制限超過によるRAG失敗を避ける"
                    ],
                    source: "検索サービスを追加する"
                ),
                LearningSection(
                    id: "d3-agentflow",
                    title: "AgentFlowの4アクション",
                    summary: "順序ごと暗記する。設問の前提知識として何度も使われる。",
                    bullets: [
                        "GetGroundingData: 根拠データを取得する",
                        "BuildMessages: システムメッセージ等を組み立てる",
                        "Call<Model>: AIモデルを呼び出す",
                        "StoreMemory: 会話状態を保存する"
                    ],
                    source: "Creating an agent in ODC Studio"
                ),
                LearningSection(
                    id: "d3-consumer",
                    title: "コンシューマー側での利用",
                    summary: "UIを持つ側は、UserInputとSessionIdを渡してCall<エージェント名>を実行する。",
                    bullets: [
                        "SessionIdが空ならGenerateGuidで新規生成する",
                        "UserInputは現在のクエリをユーザーメッセージとして渡す",
                        "同じSessionIdでセッションを継続する",
                        "エージェント型アプリを先にデプロイし、その後で消費側アプリやワークフローをデプロイする"
                    ],
                    source: "アプリでAIエージェントを利用する"
                ),
                LearningSection(
                    id: "d3-actions",
                    title: "Action calling",
                    summary: "LLMはプロンプト、System Prompt、アクションメタデータを材料に呼び出しを判断する。",
                    bullets: [
                        "サーバーアクションの名前、説明、型はLLM向けの構造化JSONスキーマに変換される",
                        "説明を詳細に書くほど選択精度が上がる",
                        "Call conditionは各アクション後に式を評価し、Trueで停止してエラーをスローする",
                        "式の例はTokenUsage >= 3000、LoopCount >= 50、TotalCallsCount >= 30"
                    ],
                    source: "AI agent actions"
                ),
                LearningSection(
                    id: "d3-structured",
                    title: "画像入力・構造化出力・タイムアウト",
                    summary: "数値と制約が問われやすい領域。RAG文書サイズとの取り違えに注意。",
                    bullets: [
                        "画像入力にはマルチモーダルモデルが必要。最大20MB/画像",
                        "画像はContentUrlまたはContentBinaryDataで渡す。BuildMessagesではコンテンツアイテムを個別追加する",
                        "Structured outputはCall AgentのStructured outputタブで設定し、フィールドにDescriptionを付ける",
                        "60秒超が必要ならQueue、Request、イベントトリガー、ポーリング、Timerで非同期管理する"
                    ],
                    source: "AIモデルでの画像入力 / Structured output / タイムアウト処理"
                )
            ]
        ),
        LearningModule(
            id: "domain3-lifecycle",
            domainLabel: "ドメイン③",
            title: "再利用・Workflow・デプロイ",
            subtitle: "公開可否、依存関係、ワークフロー実装、リビジョン挙動を整理する。",
            colorHex: "#C79A2E",
            estimatedMinutes: 16,
            highlights: [
                "Server actionsはlibrariesではPublic可、web/mobile・agenticでは直接Public不可",
                "ワークフローは複数リビジョン可、アプリは1ステージ1リビジョンのみ",
                "デプロイ順序はエージェント型アプリが先、ワークフローが後"
            ],
            keyFacts: [
                LearningFact(id: "d3-public-server-actions", label: "Server actions", value: "Expose as Service Action", note: "直接Public不可のケースで使用"),
                LearningFact(id: "d3-prod-version", label: "Production初期提案", value: "0.1.0", note: "セマンティックバージョン"),
                LearningFact(id: "d3-status", label: "Deploy status", value: "3種", note: "Running / errors / successfully")
            ],
            sections: [
                LearningSection(
                    id: "life-deps",
                    title: "依存関係と公開要素",
                    summary: "公開要素を再利用するとproducerとconsumerの依存関係が生まれる。",
                    bullets: [
                        "弱い依存: 消費側アプリが動作する同一ステージに現在デプロイされているリビジョンを使用",
                        "強い依存: アセット自身が直接参照するリビジョン、または依存ツリー上で最も近いproducerのリビジョンを使用",
                        "公開にはPublicプロパティをYesにする",
                        "サーバーアクションは右クリックからExpose as Service Actionでサービスアクション化して公開する"
                    ],
                    source: "Reuse elements across apps"
                ),
                LearningSection(
                    id: "life-public-matrix",
                    title: "公開可否マトリクスの見方",
                    summary: "丸暗記より、独立デプロイ単位かどうかで整理する。",
                    bullets: [
                        "Blocks、Client actions、Images、ThemesはlibrariesでPublic可",
                        "Entities、Events、Roles、Static entitiesはweb/mobileとagenticでPublic可",
                        "Service actionsはweb/mobileとagenticでPublic可",
                        "Server actionsはlibrariesではYes、web/mobileとagenticではNo"
                    ],
                    source: "Reuse elements across apps"
                ),
                LearningSection(
                    id: "life-workflow",
                    title: "エージェント型ワークフロー",
                    summary: "エージェントが推論・自律性を、ワークフローが構造・状態管理・人間監視を提供する。",
                    bullets: [
                        "Automatic Activityで対応するサービスアクションを呼び、SessionIdやドキュメントIDなどを渡す",
                        "並行はParallel要素、ブランチ、Automatic Activity、全ブランチ完了待ちで実装する",
                        "ループはDecisionノードで出力を評価し、Falseなら前のステップへ戻す",
                        "HITLはHuman Activityブロックでワークフローを一時停止し、人間がApprove/Rejectする"
                    ],
                    source: "エージェント型ワークフローを作成する"
                ),
                LearningSection(
                    id: "life-deploy",
                    title: "アセットのデプロイ",
                    summary: "ODC Portalでデプロイする。コードリポジトリは1つで、デプロイ時にコンテナ化される。",
                    bullets: [
                        "ワークフローがエージェント型アプリ内イベントをトリガーする場合、エージェント型アプリを先にターゲットステージへデプロイする",
                        "ワークフローは同一ステージに複数リビジョンを設定可能",
                        "実行中ワークフローインスタンスは開始時のリビジョンで完了し、新デプロイの影響を受けない",
                        "アプリは1ステージに1リビジョンのみ。以前のリビジョンは上書きされる",
                        "ブロック要因はデプロイ不可。警告は主にproducer/consumer関連で続行可能"
                    ],
                    source: "アセットのデプロイ"
                )
            ]
        ),
        LearningModule(
            id: "checklist",
            domainLabel: "直前暗記",
            title: "試験直前チェックリスト",
            subtitle: "数値・一問一答・パターン識別・デプロイ挙動を最後に確認。",
            colorHex: "#7A4BA0",
            estimatedMinutes: 10,
            highlights: [
                "数字問題は16MB、20MB、60秒、70%、0.1.0を優先",
                "AgentFlow、Call condition、公開可否、デプロイ順序は即答できるまで反復",
                "ドメイン③で7〜8問取れる状態が合格ラインへの近道"
            ],
            keyFacts: [
                LearningFact(id: "c-pass", label: "合格", value: "14/20", note: "70%"),
                LearningFact(id: "c-rag", label: "RAG文書", value: "16MB", note: "チャンク2〜3ページ"),
                LearningFact(id: "c-image", label: "画像", value: "20MB", note: "最小512x512"),
                LearningFact(id: "c-timeout", label: "Timeout", value: "60秒", note: "第一対策"),
                LearningFact(id: "c-production", label: "Production", value: "0.1.0", note: "初期提案")
            ],
            sections: [
                LearningSection(
                    id: "check-core",
                    title: "一問一答",
                    summary: "この一覧が即答できれば、コア概念はかなり固まっている。",
                    bullets: [
                        "temperatureの役割は出力のランダム性制御",
                        "複数セッションで永続するメモリは長期メモリ",
                        "ドメイン知識を補う技術はRAG",
                        "ReActの3段はThought → Action → Observation",
                        "AgentFlowの4アクションはGetGroundingData → BuildMessages → Call<Model> → StoreMemory",
                        "Action callingとStructured outputは同一callで併用できない"
                    ],
                    source: "付録A 直前暗記チェックリスト"
                ),
                LearningSection(
                    id: "check-patterns",
                    title: "パターン識別",
                    summary: "設問文に出る役割名や流れからパターンを逆引きする。",
                    bullets: [
                        "ディスパッチャ→ワーカー同時実行→アグリゲータ合成は並行",
                        "終了条件まで投稿と改良を反復するのはループ",
                        "意図を分析し下流へ振り分けるだけならルーター",
                        "計画→委任→監視→取りまとめまで関与するならスーパーバイザー",
                        "ブラックボードで暗黙的にやりとりするのは共有メモリ",
                        "一元コントローラなしで自律エージェントが交渉するのはネットワーク"
                    ],
                    source: "付録A 直前暗記チェックリスト"
                ),
                LearningSection(
                    id: "check-workflow-deploy",
                    title: "Workflow・デプロイ",
                    summary: "ドメイン③の運用・実装問題で頻出。",
                    bullets: [
                        "ワークフローとエージェントの連携はAutomatic Activityでサービスアクションを呼ぶ",
                        "並行の完了条件は全ブランチ完了まで待機",
                        "ループのFalseブランチは前のステップへ戻る",
                        "HITLはHuman Activityブロックで実装する",
                        "デプロイ順序はエージェント型アプリが先、ワークフローが後",
                        "ワークフローは複数リビジョン可、アプリは1つのみ"
                    ],
                    source: "付録A 直前暗記チェックリスト"
                )
            ]
        )
    ]

    static let o11Modules: [LearningModule] = [
        LearningModule(
            id: "o11-canvas",
            domainLabel: "O11 ①",
            title: "Architecture Canvasと命名",
            subtitle: "3レイヤー構成、非推奨レイヤー、主要サフィックスを一気に整理。",
            colorHex: "#1D6FA5",
            estimatedMinutes: 12,
            highlights: [
                "O11のArchitecture Canvasは End-User → Core → Foundation の3レイヤー",
                "OrchestrationレイヤーはO11では非推奨",
                "Coreの公開エンティティはRead Only = Yesにし、操作はアクションへ閉じ込める"
            ],
            keyFacts: [
                LearningFact(id: "o11-canvas-layers", label: "Canvas", value: "3層", note: "End-User / Core / Foundation"),
                LearningFact(id: "o11-canvas-removed", label: "非推奨", value: "Orchestration", note: "O11では不要"),
                LearningFact(id: "o11-canvas-cs", label: "_CS", value: "Core Service", note: "業務エンティティをカプセル化")
            ],
            sections: [
                LearningSection(
                    id: "o11-canvas-layers-section",
                    title: "3レイヤーの役割",
                    summary: "どの要素をどのレイヤーに置くかを即答できる状態にする。",
                    bullets: [
                        "End-User: エンドユーザー向け画面を提供する。ほかのモジュールへサービス提供しない",
                        "Core: ビジネスエンティティ、ビジネスルール、業務サービスをカプセル化する",
                        "Foundation: 外部連携、テーマ、汎用ライブラリなど非ビジネスの再利用基盤を置く",
                        "下位から上位へ依存しないように配置する"
                    ],
                    source: "Architecture Canvas の基礎（連載第1回）"
                ),
                LearningSection(
                    id: "o11-canvas-naming",
                    title: "頻出サフィックス",
                    summary: "サフィックス問題は役割とレイヤーをセットで覚える。",
                    bullets: [
                        "_CS: Core Service。業務エンティティと操作アクションをまとめる",
                        "_BL: Business Logic。複数のCore Serviceを組み合わせる",
                        "_is: Integration Service。外部システム接続をFoundationでラップする",
                        "_th: Theme。共通スタイルやレイアウトを提供する",
                        "_lib: Library。ビジネスに依存しない汎用ユーティリティをまとめる"
                    ],
                    source: "命名規約（連載第1回）"
                ),
                LearningSection(
                    id: "o11-canvas-core",
                    title: "Core公開の基本",
                    summary: "データ整合性を守るため、エンティティの直接更新を避ける。",
                    bullets: [
                        "公開エンティティはRead Only = Yesを基本にする",
                        "Create、Update、Deleteなどの操作はCore Serviceのアクション経由にする",
                        "End-User側に業務データ操作を散らさない",
                        "単一ビジネス概念は同じライフサイクルのモジュールに閉じ込める"
                    ],
                    source: "Coreレイヤー（連載第1回）"
                )
            ]
        ),
        LearningModule(
            id: "o11-design-ecs",
            domainLabel: "O11 ②",
            title: "設計プロセスとECS",
            subtitle: "Disclose → Organize → Assembleと、外部データ連携パターンを押さえる。",
            colorHex: "#2E8B57",
            estimatedMinutes: 14,
            highlights: [
                "設計プロセスはDisclose → Organize → Assembleの順番",
                "ライフサイクルが異なるビジネス概念は分離して配置する",
                "ECSは外部システムの負荷、可用性、応答性能の影響をOutSystems側から切り離す"
            ],
            keyFacts: [
                LearningFact(id: "o11-design-process", label: "設計順序", value: "D-O-A", note: "Disclose / Organize / Assemble"),
                LearningFact(id: "o11-ecs-batch", label: "Batch Sync", value: "定期同期", note: "ローカルレプリカを保持"),
                LearningFact(id: "o11-ecs-lazy", label: "Lazy Load", value: "初回取得", note: "必要時に取得してキャッシュ")
            ],
            sections: [
                LearningSection(
                    id: "o11-design-steps",
                    title: "設計プロセス3ステップ",
                    summary: "要件をそのまま実装せず、概念へ分解してCanvasへ配置する。",
                    bullets: [
                        "Disclose: ビジネスコンセプトと統合ニーズを洗い出す",
                        "Organize: 洗い出した概念をArchitecture Canvasのレイヤーへ配置する",
                        "Assemble: 推奨パターンに従ってモジュールとアプリへ組み立てる",
                        "この3ステップは一度きりではなく反復して精度を上げる"
                    ],
                    source: "設計プロセス（連載第2回）"
                ),
                LearningSection(
                    id: "o11-design-lifecycle",
                    title: "分割基準",
                    summary: "変更頻度や責任者が異なるものを同じ場所へ置くと、リリースの独立性が落ちる。",
                    bullets: [
                        "ライフサイクルが異なるビジネス概念は同一モジュールへ置かない",
                        "複数Core Serviceを束ねる複雑な業務ルールは_BLに集約する",
                        "外部連携はFoundationの_isとしてビジネスロジックから分離する",
                        "アプリ構成でもレイヤーや所有者を混在させない"
                    ],
                    source: "設計プロセス（連載第2回）"
                ),
                LearningSection(
                    id: "o11-ecs-patterns",
                    title: "ECSパターン",
                    summary: "外部データをどう読むか、どう書くかの方針を区別する。",
                    bullets: [
                        "Batch Sync: 外部データをOutSystems側へ定期同期し、ローカルレプリカを使う",
                        "Lazy Load: 初回アクセス時に外部データを取得し、以後キャッシュを使う",
                        "Write-through: ローカル更新と同時に外部システムへも同期的に書き込む",
                        "ECSの目的は外部システムの停止、遅延、負荷から利用側を分離すること"
                    ],
                    source: "ECSパターン（連載第3回）"
                )
            ]
        ),
        LearningModule(
            id: "o11-validation",
            domainLabel: "O11 ③",
            title: "検証・リファクタリング",
            subtitle: "依存関係の3ルール、アプリ構成4ルール、サービス抽出を確認。",
            colorHex: "#C79A2E",
            estimatedMinutes: 13,
            highlights: [
                "検証ルールは上方参照禁止、End-User間サイド参照禁止、循環参照禁止",
                "アプリ構成はレイヤー、所有者、スポンサーの混在を避ける",
                "リファクタリングでは強い依存を弱い依存へ変えて疎結合にする"
            ],
            keyFacts: [
                LearningFact(id: "o11-validation-rules", label: "検証", value: "3ルール", note: "上方 / サイド / 循環"),
                LearningFact(id: "o11-app-rules", label: "アプリ構成", value: "4ルール", note: "混在を避ける"),
                LearningFact(id: "o11-refactor", label: "サービス抽出", value: "疎結合", note: "強い依存を弱い依存へ")
            ],
            sections: [
                LearningSection(
                    id: "o11-validation-dependencies",
                    title: "依存関係の3ルール",
                    summary: "ルール違反は独立デプロイを壊し、巨大な依存クラスターを作る。",
                    bullets: [
                        "上方参照禁止: 下位レイヤーが上位レイヤーを参照しない",
                        "End-User間サイド参照禁止: End-User同士を直接依存させない",
                        "循環参照禁止: 概念分離の失敗として共通概念を下位へ切り出す",
                        "画面遷移は弱い参照であり、3ルール上の禁止対象とは区別する"
                    ],
                    source: "アーキテクチャ検証（連載第4回）"
                ),
                LearningSection(
                    id: "o11-validation-app-rules",
                    title: "アプリ構成4ルール",
                    summary: "モジュールだけでなく、アプリ単位でも独立した進化を守る。",
                    bullets: [
                        "モジュールをレイヤー化する",
                        "アプリもレイヤー化し、異なるレイヤーのモジュールを混在させない",
                        "所有者の混合を避け、チームごとの責任分界を守る",
                        "スポンサーの混合を避け、リリース調整の複雑化を防ぐ"
                    ],
                    source: "アプリ構成の4ルール（連載第6回）"
                ),
                LearningSection(
                    id: "o11-validation-refactor",
                    title: "リファクタリングの狙い",
                    summary: "依存を解きほぐし、データや参照を壊さずにサービス境界を作る。",
                    bullets: [
                        "End-User間で共有したいUIブロックはCoreレイヤーへ昇格する",
                        "上方参照で引き連れる要素は下位レイヤーへ切り出す",
                        "エンティティ移動ではデータ、URL、DBリンクを壊さない移行手順を守る",
                        "サーバーアクションをサービスとして抽出し、強い依存を弱い依存へ変える"
                    ],
                    source: "リファクタリング実践（連載第5回）"
                )
            ]
        )
    ]

    static let guides: [LearningExamGuide] = [
        LearningExamGuide(
            id: "odc",
            title: "Agentic AI Specialization",
            shortName: "ODC",
            subtitle: "生成AI、Agentic AI、ODC実装の要点を章別に復習。",
            colorHex: "#D9482B",
            modules: odcModules
        ),
        LearningExamGuide(
            id: "o11",
            title: "Architecture Specialist",
            shortName: "O11",
            subtitle: "Canvas、設計プロセス、ECS、検証ルールを試験別に整理。",
            colorHex: "#1D6FA5",
            modules: o11Modules
        )
    ]

    static var modules: [LearningModule] {
        guides.flatMap(\.modules)
    }
}
