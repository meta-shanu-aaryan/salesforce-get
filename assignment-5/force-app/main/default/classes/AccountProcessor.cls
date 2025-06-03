public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        // Validate input
        if (accountIds == null || accountIds.isEmpty()) return;

        // Map to hold accountId to contact count
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();

        // Aggregate contacts grouped by accountId
        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) total
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            contactCountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('total'));
        }

        // Prepare list of accounts to update
        List<Account> accountsToUpdate = new List<Account>();

        for (Id accId : accountIds) {
            Integer count = contactCountMap.containsKey(accId) ? contactCountMap.get(accId) : 0;
            accountsToUpdate.add(new Account(
                Id = accId,
                Number_Of_Contacts__c = count
            ));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}