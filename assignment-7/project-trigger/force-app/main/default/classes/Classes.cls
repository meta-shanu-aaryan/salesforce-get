public with sharing class Classes extends fflib_SObjectDomain {

    public Classes(List<Class__c> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Classes(sObjectList);
        }
    }


    public override void onBeforeDelete(){
        deletionCheck((List<Class__c>) Records);
    }

    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
        List<Id> classIdList = new List<Id>();

        for(Class__c cls : (List<Class__c>) Records){
            if(cls.CustomStatus__c == 'Reset'){
                classIdList.add(cls.Id);
            }
        }


        new StudentSelector().deleteStudentsByClassId(classIdList);
    }

    public void deletionCheck(List<Class__c> classList){
        Map<Id, Integer> femaleStudentCountInClass = new StudentSelector().getFemaleStudentCountInClass(classList);

        for(Class__c cls:classList){
            if(femaleStudentCountInClass.get(cls.Id) > 1){
                cls.addError('Class cannot be deleted. More than one female students are attending this class. Delete all the female students from this class.');
            }
        }
    }
}