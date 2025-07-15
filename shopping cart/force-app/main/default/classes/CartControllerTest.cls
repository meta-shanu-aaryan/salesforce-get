@isTest
public with sharing class CartControllerTest {
    @isTest
    public static void getCartItemsTest(){
        List<CartItem__c> cartItems = new List<CartItem__c>();

        for(Integer i=0; i<8; i++){
            cartItems.add(new CartItem__c(
                Id = fflib_IDGenerator.generate(CartItem__c.sObjectType),
                Product__c = fflib_IDGenerator.generate(Product2.sObjectType),
                Quantity__c = i+1
            ));
        }


        fflib_ApexMocks mocks = new fflib_ApexMocks();
        CartSelector cartSelector = (CartSelector) mocks.mock(CartSelector.class);

        mocks.startStubbing();
        mocks.when(cartSelector.getCartItems()).thenReturn(cartItems);
        mocks.stopStubbing();

        CartController.cartSelector = cartSelector;

        Test.startTest();
        List<CartItem__c> returnedCartItems = CartController.getCartItems();
        Assert.isTrue(returnedCartItems.size()==8, 'expected 8 Items but got '+returnedCartItems.size());
        Test.stopTest();
    }
}