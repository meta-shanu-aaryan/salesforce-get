public with sharing class StudentSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList(){

        return new List<Schema.SObjectField>{
            Student__c.Id,
            Student__c.Name,
            Student__c.Sex__c,
            Student__c.ClassName__c
        };
        
    }

    public Schema.SObjectType getSObjectType(){
        return Student__c.SObjectType;
    }


    public Map<Id, Integer> getFemaleStudentCountInClass(List<Class__c> classList){

        List<Id> classIdList = new List<Id>();

        for(Class__c cl : classList){
            classIdList.add(cl.Id);
        }

        String query = 'SELECT ClassName__c, COUNT(Id) FROM Student__c WHERE Sex__c = \'Female\' GROUP BY ClassName__c HAVING ClassName__c IN (\'' + String.join(classIdList, ',') + '\')';

        List<AggregateResult> result = (List<AggregateResult>) Database.query(query);

        Map<Id, Integer> studentCount = new Map<Id, Integer>();

        for(AggregateResult cls: result){
            Id classId = (Id)cls.get('ClassName__c');
            Integer femaleCount = (Integer)cls.get('expr0');
            studentCount.put( classId, femaleCount );
        }

        return studentCount;
    }

    public void deleteStudentsByClassId(List<Id> classIdList){
        String query = 'SELECT Id FROM Student__c WHERE ClassName__c IN (\'' + String.join(classIdList, ',') + '\')';
        List<Student__c> result = (List<Student__c>) Database.query(query);
        delete result;
    }
}