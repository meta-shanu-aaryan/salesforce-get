public with sharing class OpportunitySelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList(){

        return new List<Schema.SObjectField>{
            Opportunity.Id,
            Opportunity.Name,
            Opportunity.Amount,
            Opportunity.StageName,
            Opportunity.CloseDate,
            Opportunity.AccountId,
            Opportunity.Bill_To_Contact__c,
            Opportunity.Manager__c
        };
        
    }

    public Schema.SObjectType getSObjectType(){
        return Opportunity.SObjectType;
    }
    
    public void createOpportunityWithAccount(List<Id> accountIdList){
        List<Opportunity> newOppList = new List<Opportunity>();
        
        for(Id accId : accountIdList){
            Opportunity newOpp = new Opportunity(Name='Agriculture Industry Opp from '+(String)accID, CloseDate=System.today()+30, StageName='Prospecting', AccountId=accId);
            newOppList.add(newOpp);
        }
        
        insert newOppList;
    }

    public void checkAndUpdateManager(List<Opportunity> opportunityList){
        System.debug(LoggingLevel.DEBUG, opportunityList[0].Manager__c);

        List<Id> contactIdList = new List<Id>();

        for(Opportunity opp:opportunityList){
            if(opp.Bill_To_Contact__c != null){
                contactIdList.add(opp.Bill_To_Contact__c);
            }
        }

        Map<Id,Id> contactIdToAccountIdMap = new ContactSelector().getContactToAccoutMap(contactIdList);


        for(Opportunity opp : opportunityList){
            if(opp.Bill_To_Contact__c != null && opp.Manager__c == null){
                System.debug(LoggingLevel.DEBUG, 'Inside if condition');
                System.debug(LoggingLevel.DEBUG, 'value to put -> '+contactIdToAccountIdMap.get(opp.Bill_To_Contact__c));
                
                opp.Manager__c = contactIdToAccountIdMap.get(opp.Bill_To_Contact__c);
            }
        }
    }
}