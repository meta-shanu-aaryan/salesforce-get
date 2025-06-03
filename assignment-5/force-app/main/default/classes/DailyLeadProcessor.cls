public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx){
        List<Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        for(Lead l : Leads){
            l.LeadSource = 'Dreamforce';
        }
        
        update leads;
    }
}