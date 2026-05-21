package dto; 

public class GameCharacter {
    private String playerId; 
    private String charName; 
    private String job;      
    private int level;
    private int hp;
    private int attackPower;

    public GameCharacter(String playerId, String charName, String job, int level) {
        this.playerId = playerId;
        this.charName = charName;
        this.job = job;
        this.level = level;
        
        if ("전사".equals(job)) {
            this.hp = level * 100;
            this.attackPower = level * 15;
        } else {
            this.hp = level * 60;
            this.attackPower = level * 25;
        }
    }

    public String getPlayerId() { return playerId; }
    public String getCharName() { return charName; }
    public String getJob() { return job; }
    public int getLevel() { return level; }
    public int getHp() { return hp; }
    public int getAttackPower() { return attackPower; }
    
    public String getSkillName() {
        return "전사".equals(job) ? "검 휘두르기!" : "파이어볼!";
    }

    public int calculateDamage() {
        double multiplier = "전사".equals(job) ? 1.5 : 2.0;
        return (int) (this.attackPower * multiplier);
    }

    public String getGrade(int damage) {
        if (damage >= 200) return "S급 공격";
        if (damage >= 100) return "A급 공격";
        return "B급 공격";
    }
}
