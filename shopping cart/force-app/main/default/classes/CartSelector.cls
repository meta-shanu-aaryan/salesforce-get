public with sharing class CartSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            CartItem__c.Product__c,
            CartItem__c.Product__r.Name,
            CartItem__c.Quantity__c
        };
    }
    public Schema.SObjectType getSObjectType() {
        return CartItem__c.sObjectType;
    }

    public List<CartItem__c>  getCartItems(){
        List<CartItem__c> cartItemList = [SELECT Product__c, Product__r.Name, Product__r.SellingPrice__c, Quantity__c FROM CartItem__c];
        return cartItemList;
    }
}