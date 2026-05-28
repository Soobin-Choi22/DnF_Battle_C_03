package mall;

public class 캐릭터 {
    private String 플레이어ID;
    private String 캐릭터명;
    private String 직업;
    private int 레벨;
    protected int HP;
    protected int 공격력;
    
    // 캐릭터 생성 시 빈 인벤토리가 자동으로 함께 생성된다 [Composition]
    private 인벤토리 캐릭터인벤토리;

    public 캐릭터(String 플레이어ID, String 캐릭터명, String 직업, int 레벨) {
        this.플레이어ID = 플레이어ID;
        this.캐릭터명 = 캐릭터명;
        this.직업 = 직업;
        this.레벨 = 레벨;
        this.캐릭터인벤토리 = new 인벤토리(); // 컴포지션 자동 관계 주입

        if ("전사".equals(직업)) {
            this.HP = 레벨 * 100;
            this.공격력 = 레벨 * 15;
        } else {
            this.HP = 레벨 * 60;
            this.공격력 = 레벨 * 25;
        }
    }

    public String get플레이어ID() { return 플레이어ID; }
    public String get캐릭터명() { return 캐릭터명; }
    public String get직업() { return 직업; }
    public int get레벨() { return 레벨; }
    public int getHP() { return HP; }
    public int get공격력() { return 공격력; }
    public 인벤토리 get캐릭터인벤토리() { return 캐릭터인벤토리; }

    public String 스킬발동() {
        return null;
    }
}