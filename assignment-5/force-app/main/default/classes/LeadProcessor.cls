public class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([SELECT Id, Name FROM Lead]);
    }
    
    public void execute(Database.BatchableContext sbc, List<Lead> leads){
        for(Lead l:leads){
            l.LeadSource = 'Dreamforce';
        }
        update leads;
    }
    
    public void finish(Database.BatchableContext dbc){
        System.debug('Done');
    }
}