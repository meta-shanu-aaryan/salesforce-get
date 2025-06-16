public with sharing class Students extends fflib_SObjectDomain {

    public Students(List<Student__c> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Students(sObjectList);
        }
    }

    public override void onBeforeInsert(){
        System.debug(LoggingLevel.DEBUG, 'Inside on before insert');
        List<Student__c> studentList = (List<Student__c>) Records;
        handleStudentInsert(studentList);
    }

    public override void onAfterInsert(){
        Set<Id> classList = new Set<Id>();
        for(Student__c stud : (List<Student__c>) Records){
            classList.add(stud.ClassName__c);
        }

        new ClassSelector().incrementMyCount(classList, true);
    }

    public override void onAfterDelete(){
        Set<Id> classList = new Set<Id>();
        for(Student__c stud : (List<Student__c>) Records){
            classList.add(stud.ClassName__c);
        }

        new ClassSelector().incrementMyCount(classList, false);
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){

        Set<Id> classBeforeList = new Set<Id>();
        for(Student__c stud: (List<Student__c>)existingRecords.values()){
            classBeforeList.add(stud.ClassName__c);
        }

        new ClassSelector().incrementMyCount(classBeforeList, false);

        Set<Id> classAfterList = new Set<Id>();
        for(Student__c stud: (List<Student__c>)Records){
            classAfterList.add(stud.ClassName__c);
        }

        new ClassSelector().incrementMyCount(classAfterList, true);
    }

    public void handleStudentInsert(List<Student__c> sObjectList){
        System.debug(LoggingLevel.DEBUG, 'sObjectList -> '+sObjectList);
        for(Student__c st : sObjectList){
            List<Student__c> std = [SELECT Id, ClassName__r.Max_Size__c FROM Student__c WHERE ClassName__c =:st.ClassName__c];
            System.debug(LoggingLevel.DEBUG, 'std -> '+std);
            Integer studentInClass = std.size();
            Integer maxSize = (Integer) [SELECT Max_Size__c FROM Class__c WHERE Id =:st.ClassName__c LIMIT 1][0].Max_Size__c;
            System.debug(LoggingLevel.DEBUG, 'maxSize -> '+maxSize);
            if(studentInClass >= maxSize){
                st.addError('The class has already reached its limit');
            }
        }
    }
}