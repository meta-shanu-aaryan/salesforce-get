public with sharing class ProductController {

    @TestVisible
    private static ProductSelector productSelector;

    public ProductController(ProductSelector injectedProductSelector){
        productSelector = injectedProductSelector;
    }

    public ProductController(){
        productSelector = new ProductSelector();
    }
    
    static{
        productSelector = new ProductSelector();
    }

    @AuraEnabled (cacheable = true)
    public static List<Product2> getAllProduct(){
        try {
            List<Product2> productList = productSelector.getAllProducts();
            return productList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled
    public static List<Product2> searchProduct(String searchTerm){
        try {
            List<Product2> productList = productSelector.searchProduct(searchTerm);
            return productList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

//     @AuraEnabled
//     public static Boolean productQuantityController(Map<Id, Integer> productQuantityMap, Boolean increment){
//     if(productQuantityMap.size() > 0 ){
//         List<Product2> productList = [SELECT Id, Available_Units__c FROM Product2 WHERE Id IN :productQuantityMap.keySet()];

//         for(Product2 product : productList){
//             if(increment){
//                 product.Available_Units__c += productQuantityMap.get(product.Id);
//             }else{
//                 product.Available_Units__c -= productQuantityMap.get(product.Id);
//             }
//         }
//         Database.UpsertResult[] updt = Database.upsert(productList, true);

//         for(Database.UpsertResult db : updt){
//             if(!db.isSuccess()){
//                 return false;
//             }
//         }

//         return true;
//     }else{
//         return false;
//     }
// }

}