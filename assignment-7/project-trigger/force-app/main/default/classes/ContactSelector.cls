public with sharing class ContactSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList(){

        return new List<Schema.SObjectField>{
            Contact.Id,
            Contact.Name,
            Contact.AccountId,
            Contact.Email,
            Contact.Phone,
            Contact.Department,
            Contact.Description,
            Contact.MailingCity,
            Contact.MailingCountry,
            Contact.MailingState,
            Contact.MailingStreet
        };
        
    }

    public Schema.SObjectType getSObjectType(){
        return Opportunity.SObjectType;
    }


    public void updateMailingCity(Map<Id, String> contactIdToMailingCityMap){

        List<Id> ContactIds = new List<Id>();

        for(Id i : contactIdToMailingCityMap.keySet()){
            ContactIds.add(i);
        }

        String query = 'SELECT Id, MailingCity, AccountId FROM Contact WHERE AccountId IN (\'' + String.join(ContactIds, ',') + '\')';

        List<Contact> contactList = (List<Contact>) Database.query(query);

        for(Contact con : contactList){
            con.MailingCity = contactIdToMailingCityMap.get(con.AccountId);
            System.debug(LoggingLevel.DEBUG, con.MailingCity + contactIdToMailingCityMap.get(con.AccountId));
        }

        update contactList;
    }

    public Map<Id,Id> getContactToAccoutMap(List<Id> contactIds){
        
        String query = 'SELECT Id, AccountId FROM Contact WHERE Id IN (\'' + String.join(contactIds, ',') + '\')';
        List<Contact> contactList = (List<Contact>) Database.query(query);

        Map<Id,Id> contactIdToAccountIdMap = new Map<Id,Id>();

        for(Contact con : contactList){
            contactIdToAccountIdMap.put(con.Id, con.AccountId);
        }

        return contactIdToAccountIdMap;
    }
}