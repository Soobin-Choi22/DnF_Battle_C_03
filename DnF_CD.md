```mermaid
classDiagram
    %% [Boundary] 시스템 바운더리 영역 (클라이언트 / UI 화면)
    class Create_Character_UI {
        <<boundary>>
        +출력_캐릭터생성완료()
        +출력_인증실패()
    }
    class Attack_Monster_UI {
        <<boundary>>
        +출력_공격결과()
    }

    %% [Controller] 시스템 경계를 넘나들며 제어하는 제어 클래스
    class 캐릭터생성_컨트롤러 {
        <<controller>>
        +doPost(request, response) void
    }
    class 몬스터공격_컨트롤러 {
        <<controller>>
        +doPost(request, response) void
    }

    %% [Business Logic / Model] 시스템 내부 핵심 로직 영역
    class 전투 {
        +캐릭터생성(id: String, 이름: String, 직업: String, 레벨: int) 캐릭터
        +몬스터공격(character: 캐릭터) String
    }

    class 플레이어 {
        +플레이어체크(플레이어id: String) boolean
    }

    class 캐릭터 {
        <<abstract>>
        -플레이어ID: String
        -캐릭터명: String
        -레벨: int
        -HP: int
        -공격력: int
        +스킬발동()* String
        +데미지계산()* int
        +등급부여(데미지: int) String
    }

    %% 🔗 시스템 바운더리와 내부 로직 간의 명확한 관계 선언
    Create_Character_UI ..> 캐릭터생성_컨트롤러 : 1. Form 요청 전송
    캐릭터생성_컨트롤러 ..> 전투 : 2. 비즈니스 로직 호출
    캐릭터생성_컨트롤러 ..> Create_Character_UI : 3. request.setAttribute() 후 Forward (결과 전달)

    Attack_Monster_UI ..> 몬스터공격_컨트롤러 : 1. 공격 요청 전송
    몬스터공격_컨트롤러 ..> 전투 : 2. 로직 호출
    몬스터공격_컨트롤러 ..> Attack_Monster_UI : 3. 결과 Forward 전달

    전투 ..> 플레이어 : 플레이어체크 검증
    전투 ..> 캐릭터 : 객체 다형성 제어
