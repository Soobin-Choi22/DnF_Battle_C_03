package dto;

import java.util.ArrayList;
import java.util.List;

public class GameCharacter {
    private String playerId; 
    private String charName; 
    private String job;      
    private int level;
    private int hp;
    private int attackPower;

    
    private List<Item> inventory; 
    private String guildName;    

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

        
        this.inventory = new ArrayList<>();
    }

  
    public boolean addItem(String itemId, String itemName, String itemType, int itemValue) {
        if (this.inventory.size() >= 30) {
            return false; 
        }
        this.inventory.add(new Item(itemId, itemName, itemType, itemValue));
        return true;
    }

    
    public void joinGuild(String guildName) {
        this.guildName = guildName;
    }


    public String getPlayerId() { return playerId; }
    public String getCharName() { return charName; }
    public String getJob() { return job; }
    public int getLevel() { return level; }
    public int getHp() { return hp; }
    public int getAttackPower() { return attackPower; }
    public List<Item> getInventory() { return inventory; }
    public String getGuildName() { return guildName; }
    
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

    
    public static class Item {
        private String itemId;
        private String itemName;
        private String itemType;
        private int itemValue;
        private String grade;

        public Item(String itemId, String itemName, String itemType, int itemValue) {
            this.itemId = itemId;
            this.itemName = itemName;
            this.itemType = itemType;
            this.itemValue = itemValue;
            this.grade = calculateGrade(itemValue);
        }

        private String calculateGrade(int value) {
            if (value >= 1000) return "전설(Legendary)";
            if (value >= 500) return "희귀(Rare)";
            return "일반(Common)";
        }

        public String getItemId() { return itemId; }
        public String getItemName() { return itemName; }
        public String getItemType() { return itemType; }
        public int getItemValue() { return itemValue; }
        public String getGrade() { return grade; }
    }
}
