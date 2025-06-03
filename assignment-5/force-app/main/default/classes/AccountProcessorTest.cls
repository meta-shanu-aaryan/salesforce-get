@isTest
public class AccountProcessorTest {
    @testSetup
    static void setupData() {
        // Create test Accounts
        List<Account> testAccounts = new List<Account>{
            new Account(Name = 'Account One'),
            new Account(Name = 'Account Two')
        };
        insert testAccounts;

        // Create Contacts for the first account only
        List<Contact> testContacts = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccounts[0].Id),
            new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = testAccounts[0].Id)
        };
        insert testContacts;
    }

    @isTest
    static void testCountContacts() {
        // Get inserted Accounts
        List<Account> accounts = [SELECT Id, Name FROM Account];
        List<Id> accountIds = new List<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }

        // Call future method
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest(); // Ensures future method completes

        // Verify updates
        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account ORDER BY Name];

        System.assertEquals(2, updatedAccounts.size());
        System.assertEquals(2, updatedAccounts[0].Number_Of_Contacts__c); // Account One has 2 contacts
        System.assertEquals(0, updatedAccounts[1].Number_Of_Contacts__c); // Account Two has 0 contacts
    }
}