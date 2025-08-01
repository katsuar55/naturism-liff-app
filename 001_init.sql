create extension if not exists pgcrypto;

create table if not exists orders (
  order_id text primary key,
  email text,
  sku text,
  quantity int not null check (quantity > 0),
  purchased_at timestamptz,
  source text,
  status text,
  imported_at timestamptz default now(),
  hash text
);

create table if not exists tickets (
  ticket_id uuid primary key default gen_random_uuid(),
  order_id text references orders(order_id) on delete cascade,
  line_index int not null,
  claim_token text unique not null,
  claimed_at timestamptz,
  draw_result text check (draw_result in ('win','lose')),
  draw_day date,
  draw_window text check (draw_window in ('AM','PM')),
  draw_ts timestamptz,
  seat_number int,
  checkin_qr text,
  checked_in_at timestamptz,
  line_user_id text,
  unique(order_id, line_index)
);

create table if not exists draw_counters (
  day date not null,
  slot text not null check (slot in ('AM','PM')),
  win_cap int not null default 20,
  wins_issued int not null default 0,
  last_reset_ts timestamptz,
  primary key(day, slot)
);

create table if not exists seats (
  seat_number int primary key,
  status text not null default 'free',
  allocated_to_ticket uuid,
  allocated_ts timestamptz
);

create table if not exists audit_logs (
  id bigserial primary key,
  ts timestamptz default now(),
  kind text,
  payload jsonb
);

insert into seats(seat_number)
select i from generate_series(1,200) s(i)
on conflict do nothing;
