```mermaid
sequenceDiagram
    autonumber

    actor 플레이어
    participant 공격UI as Attack_Monster_UI
    participant 세션 as HttpServletSession
    participant 전투 as 전투
    participant 플레이어관리 as 플레이어
    participant 캐릭터 as 캐릭터

    플레이어->>공격UI: 몬스터 공격 버튼 클릭
    activate 공격UI
    
    %% UI 내에서 세션을 통해 캐릭터 객체 확보
    공격UI->>세션: getAttribute("character")
    activate 세션
    세션-->>공격UI: 캐릭터 객체 반환
    deactivate 세션

    alt 캐릭터 객체가 존재함 (유효한 세션 접근)
        
        %% UI가 전투 비즈니스 로직을 직접 호출
        공격UI->>전투: 몬스터공격(character) 호출
        activate 전투
        
        %% 💡 [카톡 요구사항 반영] 공격 SD 내에서도 플레이어 체크를 거쳐 유효성을 검증함
        전투->>플레이어관리: 플레이어체크(character.get플레이어ID())
        activate 플레이어관리
        플레이어관리-->>전투: 검증 완료 (boolean)
        deactivate 플레이어관리

        alt 검증 성공
            
            %% 교수님이 맞다고 하신 기존 데미지 및 직업별 분기 조건 완전 유지
            alt 직업 == "전사"
                전투->>캐릭터: 스킬발동()
                activate 캐릭터
                Note over 캐릭터: "검 휘두르기!"\n데미지 = 공격력 * 1.5
                캐릭터-->>전투: 결과 반환
                deactivate 캐릭터
            else 직업 == "마법사"
                전투->>캐릭터: 스킬발동()
                activate 캐릭터
                Note over 캐릭터: "파이어볼!"\n데미지 = 공격력 * 2.0
                캐릭터-->>전투: 결과 반환
                deactivate 캐릭터
            end

            alt 데미지 >= 200
                Note over 전투: S급 공격 판정
            else 데미지 >= 100
                Note over 전투: A급 공격 판정
            else 데미지 < 100
                Note over 전투: B급 공격 판정
            end

            전투-->>공격UI: 최종 공격 결과 문자열 반환
            deactivate 전투
            
            공격UI-->>플레이어: 최종 데미지 및 등급 화면 출력
            deactivate 공격UI
            
        else 검증 실패
            전투-->>공격UI: 실패 신호 반환
            activate 공격UI
            공격UI-->>플레이어: "플레이어 인증 실패" 출력
            deactivate 공격UI
        end

    end
