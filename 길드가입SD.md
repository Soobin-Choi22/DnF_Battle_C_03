```mermaid
sequenceDiagram
    autonumber

    actor 플레이어
    participant UI as Join_Guild_UI
    participant 전투 as 전투
    participant 플레이어관리 as 플레이어
    participant 길드 as 길드

    플레이어->>UI: 길드 가입 신청(플레이어ID, 길드명)
    activate UI
    
    UI->>전투: 길드가입(id, c, g) 호출
    activate 전투
    
    전투->>플레이어관리: 플레이어체크(id)
    activate 플레이어관리
    플레이어관리-->>전투: 검증 결과 반환 (boolean)
    deactivate 플레이어관리

    alt 플레이어 인증 성공 ("hero")
        
        %% 길드 최대 정원 5명 검증 메커니즘 묘사
        전투->>길드: 캐릭터가입(c) 요청
        activate 길드
        Note over 길드: 현재 가입된 캐릭터 리스트<br/>카운트 검증 (최대 5명 제한)
        
        alt 길드원 수 < 5
            길드->>길드: 리스트에 캐릭터 참조 주입 (Aggregation)
            길드-->>전투: true (가입 완료)
            전투-->>UI: "길드 가입 성공" 메시지 반환
            UI-->>플레이어: 가입 완료 화면 표시
        else 길드 정원 초과 (5명)
            길드-->>전투: false (정원 초과)
            deactivate 길드
            전투-->>UI: "길드 정원이 가득 찼습니다" 반환
            UI-->>플레이어: 오류 메시지 출력
        end

    else 플레이어 인증 실패
        전투-->>UI: 인증 실패 반환
        deactivate 전투
        UI-->>플레이어: "플레이어 인증 실패" 출력
        deactivate UI
    end
