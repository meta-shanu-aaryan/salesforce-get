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

    public List<Product2> getAllProducts(){
        List<Product2> products = [SELECT Id, Name, MRP__c, Discount__c, SellingPrice__c, Available_Units__c FROM Product2 WHERE Available_Units__c > 0];
        return products;
    }

    public List<Product2> searchProduct(String searchTerm){
        searchTerm = '%'+searchTerm+'%';
        List<Product2> productList = [SELECT Id, Name, MRP__c, Discount__c, SellingPrice__c, Available_Units__c FROM Product2 WHERE Available_Units__c > 0 AND Name LIKE :searchTerm];
        return productList;
    }
}