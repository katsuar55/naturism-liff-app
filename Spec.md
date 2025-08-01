# Spec.md（要件サマリ）

- 期間：2025-08-27 07:00 〜 2025-08-31 23:59 JST
- 当選枠：日40を AM/PM に分割（AM20=07:00リセット、PM20=19:00リセット）
- 対象SKU：`naturism_fes_kit`
- 1注文の quantity = 付与口数
- 抽選方式：袋方式（AM: WIN20/LOSE230、PM: WIN20/LOSE230）
- 当選時：座席 1..200 を一意割当、QR(JWT)発行、PUSH送信
- 当日：2025-09-07 12:30 受付締切、未受付は自動失効
- LINE：Login（LIFF）＋ Messaging API（PUSHのみ）
- 不正対策：HMAC（claim_token）、HMAC検証（Shopify Webhook）、Rate Limit、監査ログ

## 主要フロー
1) Shopify Webhook（orders/paid）→ `/api/ingest` → `orders` UPSERT → `tickets` を quantity 分生成
2) ユーザー：LIFF起動 → 注文照合 → チケット抽選 → 当落
3) WIN：座席割当 → QR発行 → PUSH
4) 係員：当日 `/staff` でQR検証→チェックイン
