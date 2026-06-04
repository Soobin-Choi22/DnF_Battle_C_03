package Mall;

public class 전투 {

    public 캐릭터 캐릭터생성(String id, String 이름, String 직업, int 레벨) {
        if (!플레이어검증(id)) {
            return null;
        }
        if ("전사".equals(직업)) {
            return new 전사(id, 이름, 레벨, 직업);
        } else if ("마법사".equals(직업)) {
            return new 마법사(id, 이름, 레벨, 직업);
        }
        return null;
    }

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
        return c.스킬발동();
    }

    public String 등급부여(int 데미지) {
        if (데미지 >= 200) return "S급 공격";
        if (데미지 >= 100) return "A급 공격";
        return "B급 공격";
    }

    // 💡 [Add_Item_UI.jsp 연동 스펙] 아이템 획득 및 인벤토리 주입 로직
    public String 아이템획득(String id, 캐릭터 c, String 아이템명, String 타입, int 가치) {
        if (!플레이어검증(id)) {
            return "플레이어 인증 실패 (유효한 ID를 입력하세요)";
        }
        if (c == null) {
            return "캐릭터 정보가 존재하지 않습니다.";
        }

        // 아이템 가치에 따른 요구사항 등급 반영
        String 등급;
        if (가치 >= 1000) {
            등급 = "전설(Legendary)";
        } else if (가치 >= 500) {
            등급 = "희귀(Rare)";
        } else {
            등급 = "일반(Common)";
        }

        // 새로운 아이템 생성 [Composition 1:N]
        아이템 새아이템 = new 아이템(아이템명, 타입, 가치);
        새아이템.set등급(등급);

        boolean 결과 = c.get캐릭터인벤토리().아이템추가(새아이템);
        if (결과) {
            return "[" + 등급 + "] " + 아이템명 + " 획득 성공 및 인벤토리 주입 완료!";
        } else {
            return "인벤토리가 가득 차서(10개) 아이템을 획득할 수 없습니다.";
        }
    }

    // 💡 [Join_Guild_UI.jsp 연동 스펙] 길드 가입 신청 로직
    public String 길드가입(String id, 캐릭터 c, 길드 g) {
        if (!플레이어검증(id)) {
            return "플레이어 인증 실패";
        }
        if (c == null) {
            return "캐릭터 정보가 유실되었습니다.";
        }
        if (g == null) {
            return "길드 객체가 활성화되지 않았습니다.";
        }

        boolean 결과 = g.캐릭터가입(c);
        if (결과) {
            return "축하합니다! [" + g.get길드명() + "] 길드 가입이 완료되었습니다.";
        } else {
            return "길드 정원(5명)이 가득 차서 가입할 수 없습니다.";
        }
    }
}