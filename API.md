# API.md（計画）

## POST /api/ingest
- 認証：HMAC（`X-Shopify-Hmac-Sha256`）
- Body（例）:
{
  "order_id": "KENKO-20250827-000123",
  "email": "user@example.com",
  "line_items": [{"sku":"naturism_fes_kit","quantity":2}],
  "purchased_at": "2025-08-27T07:05:12+09:00",
  "status": "paid",
  "source": "shopify"
}
- 処理：orders UPSERT、tickets を quantity 分生成（(order_id, line_index) Unique）

## POST /api/draw
- Body: { "claim_token": "HMAC(order_id:line_index)" }
- 処理：AM/PM の lootbag から原子的 pop、WIN なら seats を 1 つ確保
- Resp（WIN）: { outcome: "win", seat_number, qrcode_svg }
- Resp（LOSE）: { outcome: "lose" }

## POST /api/checkin（staff）
- Body: { "qr": "<JWS>" }
- 処理：JWS 検証 → tickets 更新（checked_in_at） → seats を checked_in
