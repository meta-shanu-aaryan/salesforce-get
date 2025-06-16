public with sharing class ClassSelector extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.sObjectField>{
            Class__c.Id,
            Class__c.Name,
            Class__c.Max_Size__c,
            Class__c.My_Count__c
        };
    }

    public Schema.SObjectType getSObjectType(){
        return Class__c.SObjectType;
    }

    public void incrementMyCount(Set<Id> classId, Boolean increment){
        List<Class__c> classList = (List<Class__c>) selectSObjectsById(classId);
        for(Class__c cls:classList){
            if(increment){
                if(cls.My_Count__c == null){
                    cls.My_Count__c = 1;
                }
                else{
                cls.My_Count__c = cls.My_Count__c+1;
                }
            }else{
                cls.My_Count__c = cls.My_Count__c-1;
            }
        }

        update classList;
    }
}