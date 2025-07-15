public inherited sharing class Application{
    private static fflib_Application2.SelectorFactory s_Selector;

    public static fflib_Application2.SelectorFactory Selector(){
        if(s_Selector == null){
            s_Selector = new Map<SObjectType, String>{
                Product2.SObjectType => 'ProductSelector',
                CartItem__c.SObjectType => 'CartSelector',
                PurchaseOrder__c.SObjectType => 'OrderSelector'
            };
        }
        return s_Selector;
    }
}