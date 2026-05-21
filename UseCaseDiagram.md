graph LR
    %% 액터 설정
    플레이어((플레이어))
    AI_System(((전투 AI 엔진)))

    %% 유스케이스 설정
    UC_Create["캐릭터 생성<br/>(직업별 스탯 산출)"]
    UC_Attack["몬스터 공격<br/>(데미지 계산 & 랭크 부여)"]
    UC_Check["플레이어 검증<br/>(id=='hero')"]
    UC_Analyze["플레이어 패턴 분석<br/>및 반격 패턴 결정"]

    %% 관계 선언
    플레이어 --> UC_Create
    플레이어 --> UC_Attack

    UC_Create -.->|<<include>>| UC_Check
    UC_Attack -.->|<<include>>| UC_Check
    
    %% AI 연동 표현 (공격 액션이 일어나면 AI가 이를 인지하고 분석함)
    UC_Attack -.->|<<secondary>>| AI_System
    AI_System --> UC_Analyze