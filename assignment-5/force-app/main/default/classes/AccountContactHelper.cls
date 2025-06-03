public class AccountContactHelper {
    public static void updateAccountContactIds(Id contactId) {
        Contact con = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId LIMIT 1];
        
        if (con.AccountId == null) return;

        Account acc = [SELECT Id, ContactIDs__c, 
                       (SELECT Id FROM Contacts) 
                       FROM Account 
                       WHERE Id = :con.AccountId LIMIT 1];

        String contactIdsField = acc.ContactIDs__c;

        if (String.isBlank(contactIdsField)) {
            List<String> ids = new List<String>();
            for (Contact c : acc.Contacts) {
                ids.add(c.Id);
            }
            acc.ContactIDs__c = String.join(ids, ',');
        } else {
            List<String> idList = contactIdsField.split(',');
            if (!idList.contains(contactId)) {
                contactIdsField += ',' + contactId;
                acc.ContactIDs__c = contactIdsField;
            }
        }
        update acc;
    }
}