public class ContactSearch {
    public static List<Contact> searchForContacts(String lastname, String postalCode){
        List<Contact> result = [SELECT Id, Name FROM Contact WHERE LastName = :lastname AND MailingPostalCode = :postalCode];
        
        System.debug(result);
        
        return result;
    }
}