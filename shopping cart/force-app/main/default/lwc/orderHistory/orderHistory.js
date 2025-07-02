import { LightningElement } from 'lwc';
import getRecentOrders from '@salesforce/apex/OrderController.getRecentOrders';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Order Number', fieldName: 'Name', type: 'Text' },
    { label: 'Order Date', fieldName: 'OrderDate__c' },
    { label: 'Status', fieldName: 'Status__c', type: 'text' },
    { label: 'Total Amount', fieldName: 'TotalAmount__c', type: 'currency' },
]

export default class OrderHistory extends LightningElement {

    orderHistory = [];

    orderHistoryLength = this.orderHistory.length > 0;

    connectedCallback(){
        this.orderHistory = getRecentOrders();
    }
}