public with sharing class temp {
    public temp() {
        DailyMailUpdate batch = new DailyMailUpdate();
        Database.executeBatch(batch, 200);
    }
}