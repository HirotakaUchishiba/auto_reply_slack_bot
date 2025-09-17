# Slack AI Reply Assistant Bot

## 1\. 概要

[cite\_start]このプロジェクトは、Slack上で動作するAI返信アシスタントBotです。ユーザーが受信したメッセージに対し、OpenAIの大規模言語モデル（LLM）を活用して、文脈に応じた返信文の草案を迅速に生成・提案します [cite: 4]。

[cite\_start]本システムはAWSのサーバーレス技術（API Gateway, Lambda, DynamoDB）を全面的に採用しており [cite: 5]、スケーラビリティ、コスト効率、そして高い運用性を実現しています。

## 2\. コア設計原則

[cite\_start]このアプリケーションは、単に機能するだけでなく、堅牢で保守性が高く、セキュアであることを保証するために、以下の4つのコア設計原則を憲法として開発されています [cite: 16]。

  * [cite\_start]**セキュリティ・バイ・デザイン (Security-by-Design)**: 設計の初期段階からセキュリティを組み込み、特にPII（個人識別情報）データの厳格な保護を最優先します [cite: 18]。
  * [cite\_start]**オブザーバビリティによる運用エクセレンス (Operational Excellence through Observability)**: 構造化ロギングやメトリクス監視を徹底し、問題発生時に迅速な原因特定と解決を可能にします [cite: 19]。
  * [cite\_start]**回復力とスケーラビリティ (Resilience & Scalability)**: 体系的なエラーハンドリングとリトライ戦略により、障害発生時でも可能な限り正常に機能し続けるシステムを構築します [cite: 21]。
  * [cite\_start]**API・アズ・コントラクト (API-as-Contract)**: システム内外の全てのインターフェース（UIコンポーネントを含む）を厳格な契約として扱い、統合不全のリスクを根本的に排除します [cite: 23]。

## 3\. 主な機能

  * [cite\_start]**AIによる返信文案生成**: ユーザーの指示に基づき、文脈に応じた自然な返信文案を生成します [cite: 4]。
  * [cite\_start]**プロンプトエンジニアリングフレームワーク**: ペルソナ定義やテンプレート化により、高品質で一貫性のあるAIの応答を実現します [cite: 28, 30, 33]。
  * [cite\_start]**PII（個人識別情報）リダクション**: OpenAI APIにデータを送信する前に、テキストに含まれる個人情報（メールアドレスなど）を自動的に検出しマスキングします。AIからの応答後、マスキングされた情報を復元することで、セキュリティと利便性を両立します [cite: 112, 118]。
  * [cite\_start]**Slack UI Kitによる直感的な操作**: Slackのモーダル画面を利用し、シームレスなユーザー体験を提供します [cite: 167]。

## 4\. 技術スタック

  * **バックエンド**: AWS Lambda (Python 3.11)
  * **API**: Amazon API Gateway
  * [cite\_start]**データベース**: Amazon DynamoDB (シングルテーブルデザイン) [cite: 372]
  * [cite\_start]**AI**: OpenAI API (gpt-4o) [cite: 67]
  * **IaC**: Terraform
  * **CI/CD**: GitHub Actions

## 5\. ディレクトリ構成

[cite\_start]リポジトリは関心の分離の原則に基づき、明確に構成されています [cite: 628]。

```
slack-ai-bot/
[cite_start]├── .github/      # CI/CDワークフロー定義 [cite: 644]
[cite_start]├── docs/         # プロジェクトドキュメント [cite: 645]
[cite_start]├── src/          # Pythonアプリケーションソースコード [cite: 647]
[cite_start]├── terraform/    # TerraformによるIaCコード [cite: 648]
[cite_start]├── tests/        # ユニットテスト、結合テスト [cite: 649]
[cite_start]├── Makefile      # 開発タスク自動化コマンド [cite: 650]
└── README.md     # このファイル
```

## 6\. セットアップとデプロイ

### 前提条件

  * Python 3.11+
  * Terraform v1.5+
  * AWS CLI
  * 設定済みのAWS認証情報

### 手順

1.  **リポジトリをクローン**

    ```bash
    git clone https://github.com/your-org/slack-ai-bot.git
    cd slack-ai-bot
    ```

2.  **依存関係のインストール**

    ```bash
    pip install -r requirements.txt
    ```

3.  **機密情報の設定**
    [cite\_start]OpenAIのAPIキーをAWS Secrets Managerに登録します [cite: 532][cite\_start]。Terraformコードは `SlackAIBot/OpenAl/ApiKey` という名前のシークレットを参照します [cite: 541]。

4.  **Terraformの初期化とデプロイ**
    `staging` 環境にデプロイする場合：

    ```bash
    cd terraform/environments/staging
    terraform init
    terraform plan
    terraform apply
    ```

## 7\. テストの実行

リポジトリのルートディレクトリで以下のコマンドを実行します。

  * [cite\_start]**ユニットテストの実行** (`moto` を使用してAWSサービスをモックします [cite: 493])
    ```bash
    make test-unit
    ```
  * **コードの静的解析**
    ```bash
    make lint
    ```