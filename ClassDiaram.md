# Class Diagram

```mermaid
classDiagram

    class Create_Character_UI {
        <<boundary>>
        +입력정보전달()
    }

    class Attack_Monster_UI {
        <<boundary>>
        +공격명령전달()
    }

    class Add_Item_UI {
        <<boundary>>
        +아이템획득요청() void
    }

    class Join_Guild_UI {
        <<boundary>>
        +길드가입요청() void
    }

    class 플레이어 {
        +String 플레이어ID
        +플레이어체크(id : String) boolean
    }

    class 캐릭터 {
    <<abstract>>
    +String 플레이어ID
    +String 캐릭터명
    +String 직업
    +int 레벨
    #int HP
    #int 공격력
    -인벤토리 캐릭터인벤토리
    +get플레이어ID() String
    +get캐릭터인벤토리() 인벤토리
    +스킬발동() double
    }

    class 전사 {
        +스킬발동() double
    }

    class 마법사 {
        +스킬발동() double
    }

    class 아이템 {
        -String 아이템명
        -String 타입
        -int 가치
        -String 등급
        +아이템(아이템명 : String, 타입 : String, 가치 : int)
    }

    class 인벤토리 {
        -List~아이템~ 아이템리스트
        -int 최대용량
        +인벤토리()
        +아이템추가(new아이템 : 아이템) boolean
    }

     class 길드 {
        -String 길드명
        -List~캐릭터~ 캐릭터리스트
        -int 최대인원
        +길드(길드명 : String)
        +캐릭터가입(c : 캐릭터) boolean
    }

    class 전투 {
        +플레이어검증(id : String) boolean
        +캐릭터생성(id : String, 이름 : String, 직업 : String, 레벨 : int) 캐릭터
        +데미지계산(c : 캐릭터) int
        +스킬발동(c : 캐릭터) String
        +등급부여(데미지 : int) String
        +아이템획득(id : String, c : 캐릭터, 아이템명 : String, 타입 : String, 가치 : int) String
        +길드가입(id : String, c : 캐릭터, g : 길드) String
    }

    %% 상속 관계
    캐릭터 <|-- 전사
    캐릭터 <|-- 마법사

    %% 복합객체 및 연관 관계 (요청 명시 관계)
    캐릭터 "1" *-- "1" 인벤토리 : 캐릭터 인벤토리 (Composition)
    인벤토리 "1" *-- "*" 아이템 : 인벤토리 아이템 (Composition 1:N)
    길드 "1" o-- "*" 캐릭터 : 길드 캐릭터 (Aggregation 1:N)

    %% 연관 관계
    Create_Character_UI ..> 전투 : 호출
    Attack_Monster_UI ..> 전투 : 호출
    Add_Item_UI ..> 전투 : 호출
    Join_Guild_UI ..> 전투 : 호출

    전투 --> 플레이어 : 검증
    전투 --> 캐릭터 : 생성/관리
```