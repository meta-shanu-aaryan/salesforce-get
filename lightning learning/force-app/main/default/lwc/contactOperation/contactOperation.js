import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactListController.getContacts';
import MyModal from 'c/myModal';
import editContact from 'c/editContact';
import deleteModal from 'c/deleteModal';

const COLUMNS = [
    { label: 'Id', fieldName: 'Id', type: 'text' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
];

const selectedRow = new Set();
let editModalOpen = false;
let createModalOpen = true;

export default class ContactOperation extends LightningElement {

    columns = COLUMNS;

    @wire(getContacts)
    contacts;


    getSelectedId(event) {
        selectedRow.clear();
        const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++) {
            selectedRow.add(selectedRows[i].Id);
        }
    }

    showSelectedIds() {
        alert([...selectedRow].join(', '));
    }

    async openModal() {
        await MyModal.open({
            size: 'large',
            heading: 'Navigate to Record Page',
            description: 'Navigate to a record page by clicking the row button',
        })
    }

    async openEditModal(){
        if(selectedRow.size!=1){
            alert("no or more than one row selected")
        }else{
            const contId = [...selectedRow][0];
            await editContact.open({
                size: 'large',
                contactId: contId,
                heading: 'Navigate to Record Page',
                description: 'Navigate to a record page by clicking the row button',
            });
        }
    }

    async openDeleteModal(){
        if(selectedRow.length<1){
            alert("no row is seleted");
        }else{
            await deleteModal.open({
                size: 'large',
                contactIds: [...selectedRow],
                heading: 'Navigate to Record Page',
                description: 'heya'
            });
        }
    }
}