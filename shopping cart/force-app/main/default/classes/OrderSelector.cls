public with sharing class OrderSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            PurchaseOrder__c.Id,
            PurchaseOrder__c.Name,
            PurchaseOrder__c.OrderDate__c,
            PurchaseOrder__c.Status__c,
            PurchaseOrder__c.TotalAmount__c};
    }
    public Schema.SObjectType getSObjectType() {
        return PurchaseOrder__c.sObjectType;
    }

    public List<PurchaseOrder__c> getLastOrders(){
        List<PurchaseOrder__c> purchaseOrderList = [SELECT Id, Name, Customer__r.Name, OrderDate__c, Status__c, TotalAmount__c FROM PurchaseOrder__c ORDER BY NAME DESC LIMIT 10];
        return purchaseOrderList;
    }
}