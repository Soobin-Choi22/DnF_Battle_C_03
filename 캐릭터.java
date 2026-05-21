package mall;

public abstract class 캐릭터 {

    protected String 플레이어ID;
    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected int 공격력;

    public 캐릭터(String 플레이어ID, String 캐릭터명, int 레벨) {
        this.플레이어ID = 플레이어ID;
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
    }

    public String get플레이어ID() {
        return 플레이어ID;
    }

    public String get캐릭터명() {
        return 캐릭터명;
    }

    public int get레벨() {
        return 레벨;
    }

    public int getHP() {
        return HP;
    }

    public int get공격력() {
        return 공격력;
    }

    public abstract String 스킬발동();

    public abstract int 데미지계산();

    public String 등급부여(int 데미지) {

        if (데미지 >= 200) {
            return "S급 공격";
        }

        if (데미지 >= 100) {
            return "A급 공격";
        }

        return "B급 공격";
    }
}