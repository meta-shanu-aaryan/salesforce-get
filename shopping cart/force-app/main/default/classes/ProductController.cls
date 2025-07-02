public with sharing class ProductController {
    
    @AuraEnabled (cacheable = true)
    public static List<Product2> getAllProduct(){
        try {
            List<Product2> productList = [SELECT Id, Name, MRP__c, Discount__c, SellingPrice__c, Available_Units__c FROM Product2 WHERE Available_Units__c > 0];
            return productList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled
    public static List<Product2> searchProduct(String searchTerm){
        try {
            searchTerm = '%'+searchTerm+'%';
            List<Product2> productList = [SELECT Id, Name, MRP__c, Discount__c, SellingPrice__c, Available_Units__c FROM Product2 WHERE Available_Units__c > 0 AND Name LIKE :searchTerm];
            return productList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Boolean productQuantityController(Map<Id, Integer> productQuantityMap, Boolean increment){
    if(productQuantityMap.size() > 0 ){
        List<Product2> productList = [SELECT Id, Available_Units__c FROM Product2 WHERE Id IN :productQuantityMap.keySet()];

        for(Product2 product : productList){
            if(increment){
                product.Available_Units__c += productQuantityMap.get(product.Id);
            }else{
                product.Available_Units__c -= productQuantityMap.get(product.Id);
            }
        }
        Database.UpsertResult[] updt = Database.upsert(productList, true);

        for(Database.UpsertResult db : updt){
            if(!db.isSuccess()){
                return false;
            }
        }

        return true;
    }else{
        return false;
    }
}



}