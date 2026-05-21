package mall;

public class 전투 {

    public 캐릭터 캐릭터생성(String id, String 이름, String 직업, int 레벨) {

        플레이어 player = new 플레이어();

        if (!player.플레이어체크(id)) {
            return null;
        }

        if ("전사".equals(직업)) {
            return new 전사(id, 이름, 레벨);
        }

        return new 마법사(id, 이름, 레벨);
    }

    public String 몬스터공격(캐릭터 character) {

        int 데미지 = character.데미지계산();

        String 등급 = character.등급부여(데미지);

        return character.스킬발동()
                + " / 데미지 : "
                + 데미지
                + " / "
                + 등급;
    }
}