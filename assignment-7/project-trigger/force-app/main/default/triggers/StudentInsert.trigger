trigger StudentInsert on Student__c (before insert, before update, after insert, after delete, after update, after undelete) {
    fflib_SObjectDomain.triggerHandler(Students.class);
}