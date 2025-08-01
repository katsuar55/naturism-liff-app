# Naturism LIFF Lottery – Scaffold (CP-0.5)

このリポジトリは、Naturism公式LINE（LIFF）抽選アプリの**最小スキャフォールド**です。
- 目的：8/27–8/31 抽選（AM/PM 各20枠）→ 200席配布、9/7当日チェックイン
- 構成予定：Next.js 14 (App Router) + Supabase (Postgres + Edge Functions)
- このスキャフォールドには **DBスキーマ** と **仕様ドキュメント** が含まれます。

## デプロイの全体像（簡易）
1. **Supabase プロジェクト作成** → `SQL Editor` で `db/migrations/001_init.sql` を実行
2. **Vercel プロジェクト作成** → 環境変数（.env.sample を参照）を設定 → デプロイ
3. LINE Developers（Login）：LIFFに `Endpoint URL` と `Callback URL` を設定済みであることを確認

## 環境変数（Vercel / Supabase）
- `NEXT_PUBLIC_LIFF_ID`：例 `1657470072-XyNBR9Ny`
- `LINE_LOGIN_CHANNEL_ID`
- `LINE_LOGIN_CHANNEL_SECRET`
- `LINE_MESSAGING_CHANNEL_ACCESS_TOKEN`（PUSH用）
- `SHOPIFY_WEBHOOK_SECRET`（Shopify側Signing secret）
- `HMAC_SECRET`（claim_token生成用秘密鍵）
- `JWT_SECRET`（QR署名用）
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- （Edge Functions）`SUPABASE_SERVICE_ROLE_KEY`（必要時）

## 次の追加物（CP-1で提供予定）
- `/api/ingest`（Shopify Webhook JSON/HMAC）
- `/api/draw`（AM/PM袋・原子的pop）
- `/api/checkin`（QR検証）
- LIFF UI シェル（Login/抽選/結果/QR）
