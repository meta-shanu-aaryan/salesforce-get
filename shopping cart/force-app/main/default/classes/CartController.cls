public with sharing class CartController {

    @TestVisible
    private static CartSelector cartSelector;

    public CartController(CartSelector injectedCartSelector){
        cartSelector = injectedCartSelector;
    }

    public CartController(){
        cartSelector = new CartSelector();
    }
    
    static{
        cartSelector = new CartSelector();
    }
    
    @AuraEnabled
public static Boolean addToCart(List<Id> itemIds){
    try {
        // System.debug(LoggingLevel.DEBUG, 'entered');
        List<CartItem__c> cartItemList = [SELECT Id, Product__c, Quantity__c FROM CartItem__c WHERE Product__c IN :itemIds];

        List<Id> itemToUpdate = new List<Id>();

        for(CartItem__c cartItem : cartItemList){
            cartItem.Quantity__c = cartItem.Quantity__c + 1;
            itemToUpdate.add(cartItem.Product__c);
        }
        if(itemToUpdate.size() > 0){
            Database.UpsertResult[] upsertResultList = Database.upsert(cartItemList, false);
        }

        List<CartItem__c> newCartItemList = new List<CartItem__c>();

        for(Id itemId : itemIds){
            if(!itemToUpdate.contains(itemId)){
                Cartitem__c newCartItem = new CartItem__c(Product__c = itemId, Quantity__c = 1);
                newCartItemList.add(newCartItem);
            }
        }

        System.debug(LoggingLevel.DEBUG, newCartItemList);
        
        if(newCartItemList.size() > 0){
            Database.SaveResult[] saveResultList = Database.insert(newCartItemList, false);
        }

        return true;
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}

    @AuraEnabled
    public static List<CartItem__c> getCartItems(){
        try {
            // List<CartItem__c> cartItemList = [SELECT Product__c, Product__r.Name, Product__r.SellingPrice__c, Quantity__c FROM CartItem__c];

            // return cartItemList;

            return cartSelector.getCartItems();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Boolean clearCart(){
        try {
            List<CartItem__c> cartItemList = [SELECT Id FROM CartItem__c];
            if(cartItemList.size() > 0){
                Database.DeleteResult[] deleteResultList = Database.delete(cartItemList, true);
                for(Database.DeleteResult dr : deleteResultList){
                    if(!dr.isSuccess()){
                        return false;
                    }
                }
                return true;
            }else{
                return false;
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}