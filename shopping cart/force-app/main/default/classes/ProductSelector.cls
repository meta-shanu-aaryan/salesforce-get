public with sharing class ProductSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Product2.Id,
            Product2.Name,
            Product2.MRP__c,
            Product2.Discount__c,
            Product2.SellingPrice__c,
            Product2.Available_Units__c};
    }
    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }

    public static Map<Id, Integer> getProductAvailabilityMap(Set<Id> productIds){
        List<Product2> products = (List<Product2>) selectSObjectsById(productIds);
        Map<Id, Integer> productAvailabilityMap = new Map<Id, Integer>();
        for(Product2 p : products){
            productAvailabilityMap.put(p.Id, (Integer)p.Available_Units__c);
        }

        return productAvailabilityMap;
    }

    public static Boolean productQuantityIncrement(Map<Id, Integer> productIdMap){

        List<Product2> products = (List<Product2>) selectSObjectsById(productIdMap.keySet());

        for(Product2 p: products){
            p.Available_Units__c = p.Available_Units__c - productIdMap.get(p.Id);
        }

        update products;
        return true;
    }
}