trigger ClassDeleteTrigger on Class__c (before delete, before update, before insert, after insert, after update, after delete, after undelete) {
    
    fflib_SObjectDomain.triggerHandler(Classes.class);

    
}