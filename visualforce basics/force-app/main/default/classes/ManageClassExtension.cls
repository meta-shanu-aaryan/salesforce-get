public class ManageClassExtension {
    public Class__c selectedClass { get; set; }
    public Boolean showEditForm { get; set; }

    public ApexPages.StandardSetController objController {
        get {
            if (objController == null) {
                List<Class__c> accountList = [SELECT Id, Name, Max_Size__c, Current_Strength__c FROM Class__c];
                objController = new ApexPages.StandardSetController(accountList);
                objController.setPageSize(10);
            }
            return objController;
        }
        set;
    }

    public List<Class__c> getClasses() {
        return (List<Class__c>)objController.getRecords();
    }

    public PageReference editClassById() {
        String idToEdit = ApexPages.currentPage().getParameters().get('editId');
        if (idToEdit != null) {
            selectedClass = [SELECT Id, Name, Max_Size__c, Current_Strength__c FROM Class__c WHERE Id = :idToEdit];
            showEditForm = true;
        }
        return null;
    }

    public void saveFnc() {
        update selectedClass;
        showEditForm = false;
        objController = null;
    }

    public void cancelFnc() {
        selectedClass = null;
        showEditForm = false;
    }
    
    public PageReference deleteClassById(){
        String idToDelete = ApexPages.currentPage().getParameters().get('deleteId');
        if (idToDelete != null) {
            selectedClass = [SELECT Id FROM Class__c WHERE Id = :idToDelete];
            delete selectedClass;
        }
        return null;
    }
}