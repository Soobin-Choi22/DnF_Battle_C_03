package mall;

public class 전투 {

    public boolean 플레이어검증(String id) {
        플레이어 p = new 플레이어();
        return p.플레이어체크(id);
    }

    public int 데미지계산(캐릭터 c) {

        if ("전사".equals(c.get직업())) {
            return (int)(c.get공격력() * 1.5);
        } else {
            return (int)(c.get공격력() * 2.0);
        }
    }

    public String 스킬발동(캐릭터 c) {

        if ("전사".equals(c.get직업())) {
            return "검 휘두르기!";
        } else {
            return "파이어볼!";
        }
    }

    public String 등급부여(int 데미지) {

        if (데미지 >= 200) return "S급 공격";
        if (데미지 >= 100) return "A급 공격";
        return "B급 공격";
    }
}