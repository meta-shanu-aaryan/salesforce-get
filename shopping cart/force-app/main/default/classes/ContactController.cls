public with sharing class ContactController {
    @AuraEnabled (cacheable = true)
    public static List<Contact> getContactList(){
        List<Contact> conList = [SELECT Id, Name, Phone, Email FROM Contact LIMIT 50];
        return conList;
    }
}