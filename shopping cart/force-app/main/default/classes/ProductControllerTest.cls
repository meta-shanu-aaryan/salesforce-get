@isTest
public with sharing class ProductControllerTest {
    @isTest
    private static void getAllproductTest(){
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        ProductSelector productSelector = (ProductSelector) mocks.mock(ProductSelector.class);

        List<Product2> fakeProductList = new List<Product2>();
        //create 10 fake products
        for(Integer i = 0; i < 10; i++){
            fakeProductList.add(new Product2(Id = fflib_IDGenerator.generate(Product2.getSObjectType()) ,Name = 'FakeProd' + i, Available_Units__c = i+1, MRP__c = 2000, Discount__c = 10));
        }
        
        mocks.startStubbing();
        mocks.when(productSelector.getSObjectType()).thenReturn(Product2.SObjectType);
        mocks.when(productSelector.getAllProducts()).thenReturn(fakeProductList);
        mocks.stopStubbing();

        ProductController.productSelector = productSelector;
        
        Test.startTest();
        List<Product2> productList = ProductController.getAllProduct();
        Assert.isTrue(productList.size() == 10, 'Expected 10 products');
        Test.stopTest();

    }

    @isTest
    private static void getSearchProductTest(){
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        ProductSelector productSelector = (ProductSelector) mocks.mock(ProductSelector.class);

        List<Product2> fakeProductList = new List<Product2>();
        //create 10 fake products
        for(Integer i = 0; i < 10; i++){
            fakeProductList.add(new Product2(Id = fflib_IDGenerator.generate(Product2.getSObjectType()) ,Name = 'FakeProd' + i, Available_Units__c = i+1, MRP__c = 2000, Discount__c = 10));
        }
        
        mocks.startStubbing();
        mocks.when(productSelector.getSObjectType()).thenReturn(Product2.SObjectType);
        mocks.when(productSelector.searchProduct('Fake')).thenReturn(fakeProductList);
        mocks.stopStubbing();

        ProductController.productSelector = productSelector;
        
        Test.startTest();
        List<Product2> productList = ProductController.searchProduct('Fake');
        Assert.isTrue(productList.size() == 10, 'Expected 10 products');
        Test.stopTest();

    }
}