public class ContactAndLeadSearch {
    public static List<List< sObject>> searchContactsAndLeads(String sde){
        List<List< sObject>> results = [FIND :sde IN Name Fields RETURNING Contact(Id, FirstName, LastName), Lead(Id, FirstName, LastName)];
        System.debug(results);
        return results;
    }
}