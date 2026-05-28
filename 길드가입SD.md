sequenceDiagram
    autonumber
    actor 플레이어
    participant UI as Join_Guild_UI
    participant 세션 as HttpServletSession
    participant 전투 as 전투
    participant 플레이어관리 as 플레이어
    participant 길드관리 as 길드

    플레이어->>UI: 길드 가입 요청 (ID, 길드명)
    activate UI
    
    UI->>세션: getAttribute("character")
    activate 세션
    text-->>UI: 캐릭터 객체 반환
    deactivate 세션

    %% 외부 세션/메모리에서 공용 길드 객체를 가져오는 상황
    UI->>세션: getAttribute("guild")
    activate 세션
    세션-->>UI: 외부 생성된 길드 객체 반환
    deactivate 세션

    UI->>전투: 길드가입(id, character, guild)
    activate 전투
    
    전투->>플레이어관리: 플레이어체크(id)
    activate 플레이어관리
    플레이어관리-->>전투: 검증 결과 (boolean)
    deactivate 플레이어관리

    alt 플레이어 인증 성공
        전투->>길드관리: 캐릭터가입(character)
        activate 길드관리
        Note over 길드관리: 캐릭터리스트 크기 체크 (max 5)
        길드관리-->>전투: 가입 결과 (boolean)
        deactivate 길드관리
        
        alt 가입 성공 (정원 여유 있음)
            전투-->>UI: "길드 가입 성공" 반환
        else 가입 실패 (정원 가득 참)
            전투-->>UI: "길드 정원이 가득 차서 가입할 수 없습니다." 반환
        end
    else 플레이어 인증 실패
        전투-->>UI: "플레이어 인증 실패" 반환
    end
    
    deactivate 전투
    UI-->>플레이어: 결과 화면 출력
    deactivate UI