import { api, LightningElement, track } from 'lwc';
import Toast from 'lightning/toast';
import getCartItems from '@salesforce/apex/CartController.getCartItems';
import OrderItems from '@salesforce/apex/OrderController.OrderItems';
import clearCart from '@salesforce/apex/CartController.clearCart';

const columns = [
    { label: 'ProductId', fieldName: 'productId' },
    { label: 'ProductName', fieldName: 'ProductName' },
    { label: 'Quantity', fieldName: 'quantity', editable: true},
    { label: 'Price Per Unit', fieldName: 'Price' },
    { label: 'Total Amount', fieldName: 'TotalAmount' },
]
export default class CartSection extends LightningElement {

    @track itemList = [];
    columns = columns;
    itemListLengthCheck = () => {
        return this.itemList.length > 0;
    }
    async connectedCallback() {
        this.refreshCartItem();
    }

    refreshCartItem = async () => {
        await getCartItems().then(result => {
            this.itemList = result.map((item) => {
                return {
                    quantity: item.Quantity__c,
                    productId: item.Product__c,
                    ProductName: item.Product__r.Name,
                    Price: item.Product__r.SellingPrice__c,
                    TotalAmount: item.Quantity__c * item.Product__r.SellingPrice__c,

                }
            })
        }).catch(e => {
            console.log('Error in cart: ' + e)
        });
    }

    async handleClearCart() {
        await clearCart().then(result => {
            console.log("cleared cart");
        })
        this.refreshCartItem();
    }

    async checkOutCart() {
        const freshdata = this.itemList.map((item) => {
            return {
                Product__c: item.productId,
                Quantity__c: item.quantity,
                PricePerUnit__c: item.Price
            }
        })
        const added = await OrderItems({ orderItems: freshdata });
        if (added) {
            Toast.show({
                label: 'Checked Out your order Successfully!!',
                mode: 'dismissible',
                variant: 'success'
            }, this);
            this.refreshCartItem();
        } else {
            Toast.show({
                label: 'Some error occurred!',
                mode: 'dismissible',
                variant: 'error'
            }, this);
        }
    }
}