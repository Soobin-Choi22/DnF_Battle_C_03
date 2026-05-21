## Use Case Diagram

```mermaid
usecaseDiagram
    actor "플레이어" as Player

    package "전투 시스템" {
        usecase "캐릭터 생성" as UC_Create
        usecase "몬스터 공격" as UC_Attack
        usecase "플레이어 검증" as UC_Check
    }

    Player --> UC_Create
    Player --> UC_Attack

    UC_Create ..> UC_Check : <<include>>
    UC_Attack ..> UC_Check : <<include>>
```

---