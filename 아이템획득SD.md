sequenceDiagram
    autonumber
    actor 플레이어
    participant UI as Add_Item_UI
    participant 세션 as HttpServletSession
    participant 전투 as 전투
    participant 플레이어관리 as 플레이어
    participant 캐릭터 as 캐릭터
    participant 인벤토리 as 인벤토리

    플레이어->>UI: 아이템 정보 입력 (ID, 아이템명, 타입, 가치)
    activate UI
    
    UI->>세션: getAttribute("character")
    activate 세션
    세션-->>UI: 캐릭터 객체 반환
    deactivate 세션

    UI->>전투: 아이템획득(id, character, 아이템명, 타입, 가치)
    activate 전투
    
    전투->>플레이어관리: 플레이어체크(id)
    activate 플레이어관리
    플레이어관리-->>전투: 검증 결과 (boolean)
    deactivate 플레이어관리

    alt 플레이어 인증 성공
        alt 가치 >= 1000
            Note over 전투: 등급 = "전설(Legendary)"
        else 가치 >= 500
            Note over 전투: 등급 = "희귀(Rare)"
        else 가치 < 500
            Note over 전투: 등급 = "일반(Common)"
        end
        
        %% Composition에 의한 아이템 생성
        create participant 아이템
        전투->>아이템: new 아이템(아이템명, 타입, 가치)
        전투->>아이템: set등급(등급)
        
        전투->>캐릭터: get캐릭터인벤토리()
        activate 캐릭터
        캐릭터-->>전투: 인벤토리 객체 반환
        deactivate 캐릭터
        
        전투->>인벤토리: 아이템추가(아이템)
        activate 인벤토리
        Note over 인벤토리: 아이템리스트 크기 체크 (max 10)
        인벤토리-->>전투: 추가 결과 (boolean)
        deactivate 인벤토리
        
        alt 추가 성공 (인벤토리 여유 있음)
            전투-->>UI: "아이템 획득 성공 [등급]" 반환
        else 추가 실패 (인벤토리 가득 참)
            전투-->>UI: "인벤토리가 가득 차서 획득할 수 없습니다." 반환
        end
        
    else 플레이어 인증 실패
        전투-->>UI: "플레이어 인증 실패" 반환
    end
    
    deactivate 전투
    UI-->>플레이어: 결과 화면 출력
    deactivate UI