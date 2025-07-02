public with sharing class OrderController {
    
    @AuraEnabled
    public static List<PurchaseOrder__c> getRecentOrders(){
        try {
            List<PurchaseOrder__c> purchaseOrderList = [SELECT Id, Name, Customer__r.Name, OrderDate__c, Status__c, TotalAmount__c FROM PurchaseOrder__c];
            return purchaseOrderList;
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

        for (PurchaseOrderLineItem__c orderItemObj : orderItems) {
            totalAmount += orderItemObj.Quantity__c * orderItemObj.PricePerUnit__c;
        }

        order.TotalAmount__c = totalAmount;
        insert order;


        for (PurchaseOrderLineItem__c orderItemObj : orderItems) {
            orderItemObj.PurchaseOrder__c = order.Id;
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