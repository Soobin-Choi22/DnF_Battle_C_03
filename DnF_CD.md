```mermaid
classDiagram
    %% Boundary Classes (UI 화면)
    class Create_Character_UI {
        <<boundary>>
    }
    class Attack_Monster_UI {
        <<boundary>>
    }

    %% Controller / Process Classes
    class 전투 {
        +캐릭터생성(플레이어id: String, 캐릭터명: String, 레벨: int, 직업: String) void
        +몬스터공격(플레이어id: String) void
    }

    class 플레이어 {
        +플레이어체크(플레이어id: String) boolean
    }

    %% Core Entities (실제 객체 및 자식 클래스)
    class 캐릭터 {
        <<abstract>>
        -캐릭터명: String
        -레벨: int
        -HP: int
        -공격력: int
        +스킬발동()* void
    }

    %% 관계선 추가 (GitHub에서 구조가 한눈에 보이도록 연결)
    Create_Character_UI ..> 전투 : 요청 전달
    Attack_Monster_UI ..> 전투 : 요청 전달
    전투 ..> 플레이어 : 검증 요청
    전투 ..> 캐릭터 : 전투/생성 제어
