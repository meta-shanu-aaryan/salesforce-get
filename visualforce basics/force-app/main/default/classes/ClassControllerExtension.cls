public class ClassControllerExtension {
	private final Class__c record;
    public ClassControllerExtension(ApexPages.standardController stdController){
        this.record = (Class__c) stdController.getRecord();
    }
    
    public PageReference updateRecord() {
        try {
            update record;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Record updated successfully.'));
            return null; // Stay on the same page
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null; // Stay on the same page (or redirect to an error page)
        }
    }
    
    public Class__c getRecord(){
        return record;
    }
}