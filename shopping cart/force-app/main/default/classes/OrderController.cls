public with sharing class OrderController extends fflib_SObjectDomain {
    
    public OrderController(List<PurchaseOrder__c> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new OrderController(sObjectList);
        }
    }

    @AuraEnabled (cacheable = true)
    public static List<PurchaseOrder__c> getRecentOrders(){
        try {
            return OrderSelector.getLastOrders();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static Boolean OrderItems(List<PurchaseOrderLineItem__c> orderItems){
    try {
        if (orderItems.size() == 0) {
            return false;
        }

        PurchaseOrder__c order = new PurchaseOrder__c();
        Decimal totalAmount = 0;

        Set<Id> productIds = new Set<Id>();

        for(PurchaseOrderLineItem__c pi : orderItems){
            productIds.add(pi.Product__c);
        }

        Map<Id, Integer> orderItemsMap = ProductSelector.getProductAvailabilityMap(productIds);

        for (PurchaseOrderLineItem__c orderItemObj : orderItems) {
            if(orderItemsMap.get(orderItemObj.Product__c) < orderItemObj.Quantity__c){
                throw new Exception('One or Multiple Product does not have the required quantity');
            }
            totalAmount += orderItemObj.Quantity__c * orderItemObj.PricePerUnit__c;
        }

        order.TotalAmount__c = totalAmount;
        insert order;

        Map<Id, Integer> productQuantityMap = new Map<Id, Integer>();
        for (PurchaseOrderLineItem__c orderItemObj : orderItems) {
            orderItemObj.PurchaseOrder__c = order.Id;
            productQuantityMap.put(orderItemObj.Product__c, orderItemObj.Quantity__c);
        }

        Database.SaveResult[] saveResultList = Database.insert(orderItems, true);
        
        for (Database.SaveResult saveResult : saveResultList) {
            if (!saveResult.isSuccess()) {
                return false;
            }
        }

        CartController.clearCart();
        return true;
        
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}

}