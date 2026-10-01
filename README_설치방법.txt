# 🧐 우리 반 질문제작소 — GitHub Pages 버전

이 버전은 Claude 전용 DB 대신 **GitHub Pages + Supabase**를 사용합니다.

## 1. Supabase 만들기

1. https://supabase.com/ 에서 계정을 만들고 새 프로젝트를 만듭니다.
2. Supabase의 **SQL Editor**를 엽니다.
3. 이 폴더의 `supabase.sql` 전체를 붙여넣고 실행합니다.
4. Authentication → Users에서 선생님 계정을 하나 만듭니다.
   - 학생은 회원가입하지 않습니다.
   - 선생님만 이메일/비밀번호로 로그인합니다.

## 2. index.html 설정

`index.html`에서 아래 두 줄을 찾습니다.

const SUPABASE_URL = "여기에_프로젝트_URL";
const SUPABASE_KEY = "여기에_Publishable_또는_anon_Key";

Supabase → Project Settings → API에서 값을 복사해서 넣습니다.

## 3. GitHub에 올리기

저장소에 `index.html`과 `supabase.sql`을 올립니다.

GitHub → Settings → Pages → Build and deployment → Deploy from a branch
→ main / root 선택 → Save

잠시 후

https://내아이디.github.io/저장소이름/

형태의 주소가 생깁니다.

## 4. 학생에게 공유

생긴 주소를 QR코드로 만들어 교실에 붙이면 됩니다.

학생:
- 이름 입력
- 책 제목 입력
- 질문 작성
- 질문 올리기
- 선생님 승인 후 전체 공개
- 친구 질문에 답변

선생님:
- 교사 모드 → 이메일/비밀번호 로그인
- 승인 대기 질문을 관리
- 공개된 질문 삭제

## 중요

이 버전의 질문 유형 자동 분류는 Claude AI 호출이 아니라 브라우저에서 작동하는 간단한 규칙 기반 분류입니다.
