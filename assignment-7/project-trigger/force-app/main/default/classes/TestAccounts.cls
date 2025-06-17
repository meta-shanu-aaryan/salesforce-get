@isTest
private class TestAccounts {
    @isTest
    static void agricultureIndustryOpportunityCreatorWhenAccountCreatedTest(){
        Account account = new Account(
            Name = 'Agriculture',
            Industry = 'Agriculture'
        );

        insert account;

        Opportunity opp = [SELECT Id, Name FROM Opportunity WHERE AccountId = :account.Id];

        Assert.areEqual('Agriculture Industry Opp from '+account.Id, opp.Name, 'Opportunity is not created or name does not match');
        
    }

    @isTest
    static void agricultureIndustryOpportunityCreatorWhenAccountUpdatedTest(){
        Account account = new Account(
            Name = 'Dummy test',
            Industry = 'Apparel'
        );

        insert account;
        Test.startTest();

        Account acc = [SELECT Id, Industry FROM Account WHERE Id = :account.Id];
        acc.Industry = 'Agriculture';
        update acc;
        Test.stopTest();

        Opportunity opp = [SELECT Id, Name FROM Opportunity WHERE AccountId = :account.Id];

        Assert.areEqual('Agriculture Industry Opp from '+acc.Id, opp.Name, 'Opportunity is not created or name does not match');  
    }

    
}