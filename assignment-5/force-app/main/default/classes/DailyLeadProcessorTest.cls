@isTest
public class DailyLeadProcessorTest {
    private static String CRON_EXP = '0 0 0 ? * * *';
    
	@isTest
    private static void testSchedulableClass(){
        
        List<Lead> leads = new List<Lead>();
        
        for(Integer i=0; i<500; i++){
            if(i<250){
                leads.add(new Lead(LastName='Connock', Company='Salesforce'));
            }else{
                leads.add(new Lead(LastName='Connock', Company='Salesforce', LeadSource='Other'));
            }
        }
        insert leads;
        
        Test.startTest();
        String jobId = System.schedule('Process Leads', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'ERROR: At least 1 record not updates correctly');
        
        List<CronTrigger> cts = [SELECT Id, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        System.debug('Next Fire Time '+cts[0].NextFireTime);
    }
}