trigger accountTestTrigger on Account (before insert, before update) {
    // for(Account a: Trigger.new) {
    //     List<Contact> contacts = [select id, salutation, firstname, lastname, email from Contact where accountId = :a.Id];
    //     for(Contact c: contacts) {
    //         System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '],
    //         LastName[' + c.lastname +']');
    //         c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
    //         update c;
    //     }
    // }

    //updated and optimized

    List<Account> triggeredAccounts = Trigger.new;

    List<Id> accountIds = new List<Id>();
    for(Account a : triggeredAccounts){
        accountIds.add(a.Id);
    }
    List<Contact> accountContacts = [SELECT Id, salutation, firstname, lastname, email FROM Contact WHERE accountId in :accountIds];

    List<Contact> contactToUpdate = new List<Contact>();

    for(Contact c: accountContacts) {
        System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '], LastName[' + c.lastname +']');
        c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
        contactToUpdate.add(c);
    }

    update contactToUpdate;
}