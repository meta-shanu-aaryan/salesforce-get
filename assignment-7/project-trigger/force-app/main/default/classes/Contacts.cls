public with sharing class Contacts extends fflib_SObjectDomain {

    public Contacts(List<Contact> sObjectList){
        super(sObjectList);
    }


    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Contacts(sObjectList);
        }
    }

    public override void onBeforeInsert(){
        for(Contact con : (List<Contact>) Records){
            if(con.subject__c!=null && con.subject__c.contains('Hindi')){
                con.addError('Cannot add teacher with Hindi subject'); 
            }
        }
    }


    public void handleTeacherInsert(List<Contact> contactList){
        
        for(Contact con : contactList){
            if(con.subject__c.contains('Hindi')){
                con.addError('Cannot add teacher with Hindi subject'); 
            }
        }
    }
}