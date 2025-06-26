public with sharing class ContactListController {

    @AuraEnabled(cacheable=true)
  public static List<Contact> getContacts() {
    return [SELECT Id, Name, Phone, Email FROM Contact ORDER BY LastCUUpdateDate DESC LIMIT 10];
  }
    
  	@AuraEnabled
    public static String createContact(String lastName, String firstName, String phone, String email){
        Contact con = new Contact(LastName=lastName, FirstName=firstName, Phone=phone, 	Email=email);
        insert con;
        return (String)con.Id;
    }
    
    @AuraEnabled
    public static Boolean editContactList(String contactid, String lastName, String firstName, String phone, String email){
        System.debug(contactId+' '+lastName+' '+firstName+' '+phone+' '+email+' ');
        Contact con = [SELECT LastName, FirstName, Phone, Email FROM Contact WHERE Id=:contactid];
        System.debug(con);
        con.LastName = lastName;
        con.FirstName = firstName;
        con.Phone = phone;
        con.Email = email;
        try{
        	update con; 
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    @AuraEnabled
    public static Contact getContact(String contactId){
        Contact con = [SELECT Id, LastName, FirstName, Phone, Email FROM Contact WHERE Id = :contactId];
        
        return con;
    }
    
    
    @AuraEnabled
    public static boolean deleteContact(List<String> contactIdList){
        List<Id> contactList = (List<Id>) contactIdList;
        
        List<Contact> selectedContact = [SELECT Id FROM Contact WHERE Id in :contactList];
        
        Database.DeleteResult[] drList = Database.delete(selectedContact, true);
        
        for(Database.DeleteResult dr : drList){
            if(!dr.isSuccess()){
                return false;
            }
        }
        
        return true;
    }
}