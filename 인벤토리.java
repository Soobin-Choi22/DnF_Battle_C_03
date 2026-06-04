package Mall;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {

    private List<아이템> 아이템리스트;
    private int 최대용량;

    public 인벤토리() {
        this.최대용량 = 10;
        this.아이템리스트 = new ArrayList<>();
    }

    public boolean 아이템추가(아이템 new아이템) {
        if (아이템리스트.size() >= 최대용량) {
            return false;
        }

        아이템리스트.add(new아이템);
        return true;
    }
}