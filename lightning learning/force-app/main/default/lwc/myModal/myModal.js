import { api, LightningElement } from 'lwc';
import LightningModal from 'lightning/modal';
import createContact from '@salesforce/apex/ContactListController.createContact';

export default class MyModal extends LightningModal {
    contactData = {
        lastName: '',
        firstName: '',
        phone: '',
        email: ''
    };

    get contactData() {
        return this.contactData;
    }

    set contactData(value) {
        this.contactData = value;
    }

    handleChange = (event) => {
        this.contactData[event.target.name] = event.target.value;
    }

    handleOkay() {
        this.close('okay');
    }

    handleContactCreate() {
        //console.log("here-->" + this.contactData.firstName + this.contactData.lastName + this.contactData.phone + this.contactData.email);
        
        createContact({
            lastName: this.contactData.lastName,
            firstName: this.contactData.firstName,
            phone: this.contactData.phone,
            email: this.contactData.email
        }).then(result => {

            alert('Contact added with ID', result);
            this.close();

        })
    }
}
