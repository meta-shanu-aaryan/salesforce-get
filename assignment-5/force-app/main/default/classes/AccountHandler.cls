public class AccountHandler {
    public static Account insertNewAccount(String accountName){
        Account act = new Account(Name=accountName);
        try{
            insert act;
        	System.debug(act);
        	return act;
        }catch(DmlException e){
            System.debug(e.getMessage());
            return null;
        }
    }
}