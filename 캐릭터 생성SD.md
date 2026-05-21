```mermaid
sequenceDiagram
    autonumber
    actor 플레이어 as 플레이어 (Actor)
    participant UI as <<boundary>><br/>Create_Character_UI
    participant 컨트롤러 as 캐릭터생성_컨트롤러
    participant 플_매니저 as 플레이어_매니저 (DB)
    participant 팩토리 as 캐릭터_팩토리
    participant 캐 as 캐릭터_인스턴스<br/>(전사/마법사 등)
    participant AI as 전투_AI_엔진

    플레이어->>UI: 캐릭터 생성 요청 (플레이어id, 캐릭터명, 레벨, 직업)
    activate UI
    UI->>컨트롤러: 캐릭터 생성 및 검증 요청 (플레이어id, 캐릭터명, 레벨, 직업)
    activate 컨트롤러
    
    %% 1. 인증 및 검증 위임
    컨트롤러->>+플_매니저: 플레이어체크(플레이어id)
    Note over 플_매니저: DB 조회 및 권한("hero") 검증
    플_매니저-->>-컨트롤러: 검증 결과 반환 (Boolean)
    
    alt 검증 실패 (존재하지 않거나 권한 없음)
        컨트롤러-->>UI: 검증 실패 (권한 없음)
        UI-->>플레이어: "올바른 플레이어가 아닙니다."
    else 검증 성공 (플레이어id 인증 완료)
        
        %% 2. 팩토리 패턴을 통한 객체 생성 캡슐화
        컨트롤러->>+팩토리: 생성요청(직업, 캐릭터명, 레벨)
        Note over 팩토리: 직업(전사/마법사)에 맞는<br/>스탯 계산 및 인스턴스화
        팩토리->>+캐: 새 객체 생성
        캐-->>-팩토리: 생성된 객체
        팩토리-->>-컨트롤러: 캐릭터 객체 반환
        
        %% 3. AI 엔진에 플레이어 분석 프로필 초기화 등록
        컨트롤러->>+AI: AI_플레이어프로필_초기화(플레이어id, 직업, 레벨, 스탯)
        Note over AI: 유저의 직업 특성에 맞는<br/>의사결정트리 가중치 설정
        AI-->>-컨트롤러: 프로필 등록 완료
        
        컨트롤러-->>UI: 캐릭터 생성 및 AI 등록 완료 통보
        deactivate 컨트롤러
        UI-->>플레이어: 캐릭터 생성 성공 메시지 출력
        deactivate UI
    end
