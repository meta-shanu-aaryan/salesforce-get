public with sharing class Opportunities extends fflib_SObjectDomain {

    public Opportunities(List<Opportunity> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
        for(Opportunity opp : (List<Opportunity>) Records){
            if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){
                opp.CloseDate = Date.today();
            }
        }

        new OpportunitySelector().checkAndUpdateManager((List<Opportunity>) Records);
        
    }

    
}