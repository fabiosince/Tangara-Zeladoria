-- Tangará Zeladoria V53.1
-- PostgreSQL/Supabase — estrutura central inicial

create extension if not exists pgcrypto;

create table if not exists public.condominiums (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  condominium_id uuid not null references public.condominiums(id) on delete cascade,
  username text unique,
  full_name text not null,
  role text not null check (role in ('Síndico','Colaborador','Morador')),
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.occurrences (
  id uuid primary key default gen_random_uuid(),
  condominium_id uuid not null references public.condominiums(id) on delete cascade,
  created_by uuid references auth.users(id) on delete set null,
  area text not null,
  title text not null,
  priority text not null default 'Média' check (priority in ('Baixa','Média','Alta','Urgente')),
  description text,
  status text not null default 'Aberta' check (status in ('Aberta','Resolvida')),
  photo_path text,
  resolved_at timestamptz,
  resolved_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.occurrence_materials (
  id uuid primary key default gen_random_uuid(),
  occurrence_id uuid not null references public.occurrences(id) on delete cascade,
  name text not null,
  quantity numeric(12,2) not null default 1,
  unit text not null default 'un',
  created_at timestamptz not null default now()
);

create table if not exists public.inspections (
  id uuid primary key default gen_random_uuid(),
  condominium_id uuid not null references public.condominiums(id) on delete cascade,
  created_by uuid references auth.users(id) on delete set null,
  area text not null,
  total integer not null default 0,
  ok integer not null default 0,
  attention integer not null default 0,
  bad integer not null default 0,
  observation text,
  items jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.purchase_items (
  id uuid primary key default gen_random_uuid(),
  condominium_id uuid not null references public.condominiums(id) on delete cascade,
  material text not null,
  unit text not null default 'un',
  status text not null default 'Pendente' check (status in ('Pendente','Comprado')),
  purchased_at date,
  note text,
  updated_by uuid references auth.users(id) on delete set null,
  updated_at timestamptz not null default now(),
  unique(condominium_id, material, unit)
);

create index if not exists occurrences_condominium_created_idx on public.occurrences(condominium_id, created_at desc);
create index if not exists occurrences_status_idx on public.occurrences(condominium_id, status);
create index if not exists inspections_condominium_created_idx on public.inspections(condominium_id, created_at desc);

-- Storage: crie um bucket privado chamado "occurrence-photos" no painel do Supabase.
-- O aplicativo deverá guardar apenas o caminho do arquivo em occurrences.photo_path.

-- RLS: ativar antes do primeiro uso em produção.
alter table public.condominiums enable row level security;
alter table public.profiles enable row level security;
alter table public.occurrences enable row level security;
alter table public.occurrence_materials enable row level security;
alter table public.inspections enable row level security;
alter table public.purchase_items enable row level security;

create or replace function public.current_condominium_id()
returns uuid language sql stable security definer set search_path = public
as $$
  select condominium_id from public.profiles where id = auth.uid() and active = true limit 1;
$$;

create or replace function public.current_role()
returns text language sql stable security definer set search_path = public
as $$
  select role from public.profiles where id = auth.uid() and active = true limit 1;
$$;

-- Perfis: cada usuário pode ler seu próprio perfil; o Síndico pode ler perfis do condomínio.
create policy profiles_select on public.profiles for select to authenticated
using (id = auth.uid() or (condominium_id = public.current_condominium_id() and public.current_role() = 'Síndico'));

create policy occurrences_select on public.occurrences for select to authenticated
using (condominium_id = public.current_condominium_id());

create policy occurrences_insert on public.occurrences for insert to authenticated
with check (condominium_id = public.current_condominium_id());

create policy occurrences_update on public.occurrences for update to authenticated
using (condominium_id = public.current_condominium_id() and public.current_role() in ('Síndico','Colaborador'))
with check (condominium_id = public.current_condominium_id());

create policy materials_select on public.occurrence_materials for select to authenticated
using (exists (select 1 from public.occurrences o where o.id = occurrence_id and o.condominium_id = public.current_condominium_id()));

create policy materials_write on public.occurrence_materials for all to authenticated
using (public.current_role() in ('Síndico','Colaborador') and exists (select 1 from public.occurrences o where o.id = occurrence_id and o.condominium_id = public.current_condominium_id()))
with check (public.current_role() in ('Síndico','Colaborador') and exists (select 1 from public.occurrences o where o.id = occurrence_id and o.condominium_id = public.current_condominium_id()));

create policy inspections_select on public.inspections for select to authenticated
using (condominium_id = public.current_condominium_id());

create policy inspections_insert on public.inspections for insert to authenticated
with check (condominium_id = public.current_condominium_id() and public.current_role() in ('Síndico','Colaborador'));

create policy purchases_select on public.purchase_items for select to authenticated
using (condominium_id = public.current_condominium_id());

create policy purchases_write on public.purchase_items for all to authenticated
using (public.current_role() = 'Síndico' and condominium_id = public.current_condominium_id())
with check (public.current_role() = 'Síndico' and condominium_id = public.current_condominium_id());
