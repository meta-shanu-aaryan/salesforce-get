public with sharing class Accounts extends fflib_SObjectDomain {
    
    public Accounts(List<Account> SObjectList){
        super(SObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }

    public override void onAfterInsert(){
        List<Id> accountIdList = new List<Id>();

        for(Account acc : (List<Account>) Records){
            if(acc.Industry == 'Agriculture'){
                accountIdList.add(acc.Id);
            }
        }

        new OpportunitySelector().createOpportunityWithAccount(accountIdList);
    }

    public override void onAfterUpdate(Map<Id, SObject> existingRecords){
        List<Account> records = (List<Account>) Records;
        agricultureIndustryOpportunityCreator(existingRecords, records);

        checkAndUpdateBillingBillingCity(records, existingRecords);
    }

    public void checkAndUpdateBillingCity(List<Account> records, Map<Id, SObject> existingRecords){
        // key -> account Id, value -> the mailing city value we want to give it 
        Map<Id, String> accountIdToCityMap = new Map<Id, String>();
        
        for(Account acc : records){
            if(acc.BillingCity != null ){
                accountIdToCityMap.put(acc.Id, acc.BillingCity);
            }
        }

        new ContactSelector().updateMailingCity(accountIdToCityMap);
    }

    public void agricultureIndustryOpportunityCreator(Map<Id, SObject> existingRecords, List<Account> records){
        List<Id> accountIdList = new List<Id>();

        for(Account acc : records){
            if((existingRecords.get(acc.Id).get('Industry') != 'Agriculture' || existingRecords.get(acc.Id).get('Industry') == null) && acc.Industry == 'Agriculture'){
                accountIdList.add(acc.Id);
            }
        }

        new OpportunitySelector().createOpportunityWithAccount(accountIdList);
    }
}