trigger accountTrigger on Account (before delete, before insert, before update) {

    List<Opportunity> opptys = [select id, name, closedate, stagename from Opportunity where accountId IN :Trigger.newMap.keySet() and StageName IN ('Closed - Lost','Closed - Won')];
    
    for(Account a : Trigger.new){
        for(Opportunity o : opptys){
            if(o.StageName == 'Closed - Lost'){
                System.debug('Do more logic here...');
            }else if(o.StageName == 'Closed - Won'){
                System.debug('Do more logic here...');
            }
        }
    }
}