```mermaid
sequenceDiagram
    autonumber

    actor 플레이어
    participant UI as Add_Item_UI
    participant 전투 as 전투
    participant 플레이어관리 as 플레이어
    participant 캐릭터 as 캐릭터
    participant 인벤토리 as 인벤토리
    participant 아이템 as 아이템

    플레이어->>UI: 아이템 정보 입력(ID, 아이템명, 타입, 가치)
    activate UI
    
    UI->>전투: 아이템획득(id, c, 아이템명, 타입, 가치) 요청
    activate 전투
    
    전투->>플레이어관리: 플레이어체크(id)
    activate 플레이어관리
    플레이어관리-->>전투: 검증 결과 반환 (boolean)
    deactivate 플레이어관리

    alt 플레이어 인증 성공 ("hero")
        
        전투->>캐릭터: get캐릭터인벤토리()
        activate 캐릭터
        캐릭터-->>전투: 인벤토리 객체 반환
        deactivate 캐릭터
        
        %% 인벤토리 수량 10개 맥스 검증 단계 표현
        전투->>인벤토리: 현재 아이템 리스트 크기 확인
        activate 인벤토리
        인벤토리-->>전투: 크기 반환 (int)
        
        alt 인벤토리 크기 < 10
            
            전투->>아이템: new 아이템(아이템명, 타입, 가치) 생성
            activate 아이템
            Note over 아이템: 가치 평가 분기<br/>1000 이상: 전설(Legendary)<br/>500 이상: 희귀(Rare)<br/>500 미만: 일반(Common)
            아이템-->>전투: 등급 부여된 아이템 객체 반환
            deactivate 아이템
            
            전투->>인벤토리: 아이템추가(new아이템)
            인벤토리-->>전투: true (추가 성공)
            deactivate 인벤토리
            
            전투-->>UI: "아이템 획득 완료" 문자열 반환
            UI-->>플레이어: 등급 및 획득 성공 메시지 출력
            
        else 인벤토리 가득 참 (10개)
            activate 인벤토리
            인벤토리-->>전투: 추가 실패 (false)
            deactivate 인벤토리
            전투-->>UI: "인벤토리 공간 부족" 반환
            UI-->>플레이어: 경고 출력
        end

    else 플레이어 인증 실패
        전투-->>UI: 인증 오류 메시지 반환
        deactivate 전투
        UI-->>플레이어: "플레이어 인증 실패" 출력
        deactivate UI
    end
