@isTest
public with sharing class OrderControllerTest {
    @isTest
    private static void getRecentOrdersTest(){
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        OrderSelector orderSelector = (OrderSelector) mocks.mock(OrderSelector.class);

        List<PurchaseOrder__c> fakeOrderList = new List<PurchaseOrder__c>();
        
        for(Integer i=0; i<10; i++){
            fakeOrderList.add(new PurchaseOrder__c(Id = fflib_IDGenerator.generate(PurchaseOrder__c.getSObjectType()) , OrderDate__c = System.today(), Status__c = 'NEW'));
        }

        mocks.startStubbing();
        mocks.when(OrderSelector.getLastOrders()).thenReturn(fakeOrderList);
        mocks.stopStubbing();

        OrderController.orderSelector = orderSelector;

        Test.startTest();
        List<PurchaseOrder__c> orders = OrderController.getRecentOrders();
        Assert.isTrue(orders.size()==10, 'Expected 10 records.');
    }
}