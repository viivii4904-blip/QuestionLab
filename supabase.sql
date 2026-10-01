-- 🧐 우리 반 질문제작소
-- Supabase SQL Editor에 전체를 붙여넣고 실행하세요.
-- 먼저 Supabase 프로젝트를 만든 뒤 실행합니다.

create extension if not exists pgcrypto;

create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  text text not null,
  src text default '',
  type text not null check (type in ('fact','heart','why','exp')),
  author text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.answers (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.questions(id) on delete cascade,
  text text not null,
  author text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.pending_questions (
  id uuid primary key default gen_random_uuid(),
  text text not null,
  src text default '',
  type text not null check (type in ('fact','heart','why','exp')),
  author text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.pending_answers (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.questions(id) on delete cascade,
  text text not null,
  author text not null,
  created_at timestamptz not null default now()
);

alter table public.questions enable row level security;
alter table public.answers enable row level security;
alter table public.pending_questions enable row level security;
alter table public.pending_answers enable row level security;

-- 학생: 공개된 질문/답변은 누구나 읽을 수 있음
create policy "public read questions" on public.questions
for select to anon, authenticated using (true);

create policy "public read answers" on public.answers
for select to anon, authenticated using (true);

-- 학생: 질문/답변은 승인 대기함에만 작성
create policy "anyone submit pending questions" on public.pending_questions
for insert to anon, authenticated with check (true);

create policy "anyone submit pending answers" on public.pending_answers
for insert to anon, authenticated with check (true);

-- 교사: 로그인한 사용자만 승인/삭제 가능
create policy "teacher manage questions" on public.questions
for all to authenticated using (true) with check (true);

create policy "teacher manage answers" on public.answers
for all to authenticated using (true) with check (true);

create policy "teacher read pending questions" on public.pending_questions
for select to authenticated using (true);

create policy "teacher delete pending questions" on public.pending_questions
for delete to authenticated using (true);

create policy "teacher read pending answers" on public.pending_answers
for select to authenticated using (true);

create policy "teacher delete pending answers" on public.pending_answers
for delete to authenticated using (true);

-- Realtime 활성화
alter publication supabase_realtime add table public.questions;
alter publication supabase_realtime add table public.answers;
