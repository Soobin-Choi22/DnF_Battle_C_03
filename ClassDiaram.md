```mermaid
classDiagram
    %% [Boundary] 시스템 바운더리 클래스정의
    class Create_Character_UI {
        <<boundary>>
        +입력정보전달() void
    }
    class Attack_Monster_UI {
        <<boundary>>
        +공격명령전달() void
    }
    class Add_Item_UI {
        <<boundary>>
        +아이템획득요청() void
    }
    class Join_Guild_UI {
        <<boundary>>
        +길드가입요청() void
    }

    %% [Controller/Domain] 시스템 비즈니스 제어 로직
    class 전투 {
        +플레이어검증(id : String) boolean
        +캐릭터생성(id : String, 이름 : String, 직업 : String, 레벨 : int) 캐릭터
        +데미지계산(c : 캐릭터) int
        +스킬발동(c : 캐릭터) String
        +등급부여(데미지 : int) String
        +아이템획득(id : String, c : 캐릭터, 아이템명 : String, 타입 : String, 가치 : int) String
        +길드가입(id : String, c : 캐릭터, g : 길드) String
    }

    class 플레이어 {
        +플레이어ID : String
        +플레이어체크(id : String) boolean
    }

    class 캐릭터 {
        <<abstract>>
        +플레이어ID : String
        +캐릭터명 : String
        +레벨 : int
        #HP : int
        #공격력 : int
        -캐릭터인벤토리 : 인벤토리
        +get플레이어ID() String
        +get캐릭터인벤토리() 인벤토리
        +스킬발동() double*
    }

    class 전사 {
        +스킬발동() double
    }

    class 마법사 {
        +스킬발동() double
    }

    class 인벤토리 {
        -아이템리스트 : List~아이템~
        -최대용량 : int
        +인벤토리()
        +아이템추가(new아이템 : 아이템) boolean
    }

    class 아이템 {
        -String 아이템명
        -String 타입
        -int 가치
        -String 등급
        +아이템(아이템명 : String, 타입 : String, 가치 : int)
    }

    class 길드 {
        -String 길드명
        -List~캐릭터~ 캐릭터리스트
        -int 최대인원
        +길드(길드명 : String)
        +캐릭터가입(c : 캐릭터) boolean
    }

    %% ⚙️ 객체지향 관계선 정의
    캐릭터 <|-- 전사
    캐릭터 <|-- 마법사

    %% 복합객체(Complex Object) 핵심 가이드라인 반영
    캐릭터 "1" *-- "1" 인벤토리 : 소유 (Composition)
    인벤토리 "1" *-- "*" 아이템 : 포함 (Composition)
    길드 "1" o-- "*" 캐릭터 : 소속 (Aggregation)

    %% 바운더리 의존성 선언
    Create_Character_UI ..> 전투 : 호출
    Attack_Monster_UI ..> 전투 : 호출
    Add_Item_UI ..> 전투 : 호출
    Join_Guild_UI ..> 전투 : 호출

    전투 --> 플레이어 : 검증
    전투 --> 캐릭터 : 생성 및 관리
