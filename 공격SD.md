```mermaid
sequenceDiagram
    autonumber
    actor 플_Actor as 플레이어 (Actor)
    participant 전 as 전투_컨트롤러
    participant 플_매니저 as 플레이어_매니저
    participant 캐 as 캐릭터_인스턴스<br/>(전사 또는 마법사)
    participant 몬 as 몬스터
    participant AI as 전투_AI_엔진

    플_Actor->>+전: 몬스터공격 요청 (플레이어id, 대상몬스터id)
    전->>+플_매니저: 플레이어체크(플레이어id)
    플_매니저-->>-전: 체크 결과 (boolean)

    alt 체크 결과가 true인 경우 (인증 성공)
        %% 1. 다형성을 이용한 스킬 발동
        전->>+캐: 스킬발동() 호출
        Note over 캐: 객체 내부에서 직업에 맞는<br/>스킬 수행 및 데미지 계산
        캐-->>-전: 스킬 결과 반환 (스킬명, 최종데미지)

        %% 2. 데미지 등급 판정
        alt 최종데미지 200 이상
            Note over 전: 등급 = "S급 공격"
        else 최종데미지 100 이상
            Note over 전: 등급 = "A급 공격"
        else 최종데미지 100 미만
            Note over 전: 등급 = "B급 공격"
        end

        %% 3. 몬스터 피격 반영
        전->>+몬: 피해적용(최종데미지)
        몬-->>-전: 현재 남은 HP 반환

        %% 4. AI 엔진의 전황 분석 및 몬스터 다음 행동 예약
        전->>+AI: 플레이어행동로그 기록(등급, 사용스킬, 몬스터HP)
        Note over AI: PatternAnalyzer가<br/>플레이어 숙련도/성향 분석
        AI-->>-전: 분석 완료 (다음 턴 AI 행동 트리 갱신)

        전-->>플_Actor: 최종 스킬 결과, 등급, 몬스터 상태 출력
        
    else 체크 결과가 false인 경우 (인증 실패)
        전-->>-플_Actor: "플레이어 인증 실패" 메시지 출력
    end
