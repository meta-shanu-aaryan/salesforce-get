trigger AccountUpdateCount on Account (before update) {


    for(Account acc : Trigger.new){
        if(acc.Update_Counts__c == null){
            acc.Update_Counts__c = 1;
        }else{

            acc.Update_Counts__c = acc.Update_Counts__c + 1;
        }
    }
}