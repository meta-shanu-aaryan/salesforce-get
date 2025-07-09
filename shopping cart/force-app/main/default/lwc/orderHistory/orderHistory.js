import { LightningElement, wire } from 'lwc';
import getRecentOrders from '@salesforce/apex/OrderController.getRecentOrders';


const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Order Number', fieldName: 'Name', type: 'Text' },
    { label: 'Order Date', fieldName: 'OrderDate__c' },
    { label: 'Status', fieldName: "Status__c", type: 'text', editable: true},
    { label: 'Total Amount', fieldName: 'TotalAmount__c', type: 'currency' },
]

export default class OrderHistory extends LightningElement {
    @wire(getRecentOrders)
    recentOrders(response){
        if(response.data){
            this.orderHistory = response.data;
        }else{
            console.log(response.error);
        }
    }

    orderHistory = [];
    columns = columns;

    orderHistoryLength =  ()=>{
        return this.orderHistory.length > 0;
    }
}