public class OpportunityHelper {
    public static void populateManagerFromContact(List<Opportunity> oppList) {
        Set<Id> contactIds = new Set<Id>();
        
        for(Opportunity opp : oppList) {
            if (opp.BillToContact__c != null && opp.Manager__c == null) {
                contactIds.add(opp.BillToContact__c);
            }
        }

        if (contactIds.isEmpty()) return;

        Map<Id, Contact> contactMap = new Map<Id, Contact>(
            [SELECT Id, AccountId FROM Contact WHERE Id IN :contactIds]
        );

        for(Opportunity opp : oppList) {
            if (opp.BillToContact__c != null && opp.Manager__c == null) {
                Contact c = contactMap.get(opp.BillToContact__c);
                if (c != null && c.AccountId != null) {
                    opp.Manager__c = c.AccountId;
                }
            }
        }

        update oppList;
    }
}