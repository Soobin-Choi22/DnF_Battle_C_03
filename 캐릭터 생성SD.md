```mermaid
sequenceDiagram
    autonumber

    actor 플레이어
    participant 생성UI as Create_Character_UI
    participant 전투 as 전투
    participant 플레이어관리 as 플레이어
    participant 세션 as HttpServletSession

    플레이어->>생성UI: 정보 입력 (ID, 캐릭터명, 직업, 레벨)
    activate 생성UI
    
    %% UI가 전투 클래스를 직접 호출 (시스템 바운더리 일치)
    생성UI->>전투: 캐릭터생성(id, 이름, 직업, 레벨) 요청
    activate 전투
    
    전투->>플레이어관리: 플레이어체크(id)
    activate 플레이어관리
    플레이어관리-->>전투: 검증 결과 반환 (boolean)
    deactivate 플레이어관리

    alt 플레이어 인증 성공 ("hero")
        
        alt 직업 == "전사"
            전투->>전투: 전사 객체 생성
            Note over 전투: HP = 레벨 * 100\n공격력 = 레벨 * 15
        else 직업 == "마법사"
            전투->>전투: 마법사 객체 생성
            Note over 전투: HP = 레벨 * 60\n공격력 = 레벨 * 25
        end
        
        전투-->>생성UI: 생성 완료 캐릭터 객체 반환
        deactivate 전투
        
        %% UI 내에서 세션 저장 처리 및 화면 출력
        생성UI->>세션: setAttribute("character", character)
        activate 세션
        세션-->>생성UI: 저장 완료
        deactivate 세션
        
        생성UI-->>플레이어: 캐릭터 생성 완료 화면 출력
        deactivate 생성UI

    else 플레이어 인증 실패
        전투-->>생성UI: null (인증 실패) 반환
        activate 생성UI
        생성UI-->>플레이어: "플레이어 인증 실패" 출력
        deactivate 생성UI
    end
