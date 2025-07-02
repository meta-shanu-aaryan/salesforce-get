import { api, LightningElement } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';


const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
];

export default class ShoppingContactPage extends LightningElement {

    @api getContactList;

    data = getContactList;
    columns = columns;
}