global class DailyMailUpdate implements Database.Batchable<SObject>, Schedulable {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date thresholdDate = Date.today().addDays(-30);
        return Database.getQueryLocator([
            SELECT Id, Name, LastModifiedDate, Owner.Email 
            FROM Opportunity 
            WHERE LastModifiedDate <= :thresholdDate
        ]);
    }

    global void execute(Database.BatchableContext BC, List<Opportunity> scope) {
        for(Opportunity opp : scope) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {opp.Owner.Email});
            email.setSubject('Opportunity Not Modified in Last 30 Days');
            email.setPlainTextBody('Opportunity "' + opp.Name + '" has not been modified in the last 30 days.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
    }

    global void finish(Database.BatchableContext BC) {}

    global void execute(SchedulableContext sc) {
        DailyMailUpdate batch = new DailyMailUpdate();
        Database.executeBatch(batch, 50);
    }
}