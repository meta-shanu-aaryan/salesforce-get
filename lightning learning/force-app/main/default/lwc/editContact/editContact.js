import { api, LightningElement } from 'lwc';
import LightningModal from 'lightning/modal';
import createContact from '@salesforce/apex/ContactListController.createContact';
import getContact from '@salesforce/apex/ContactListController.getContact';
import editContactList from '@salesforce/apex/ContactListController.editContactList';

export default class editContact extends LightningModal {
    contactData = {
        Id:'',
        LastName: '',
        FirstName: '',
        Phone: '',
        Email: ''
    };

    @api contactId;

    connectedCallback(){
        if(this.contactId){
            this.loadContactData();
            console.log("called loadContact");
        }
    }

    async loadContactData(){
        try{
            console.log("inside loadContactData");
            
            const result = await getContact({contactId: this.contactId});
            console.log(result);
            
            this.contactData = result;
        }catch(error){
            console.log(error);
            
        }
    }
    
    handleChange = (event) => {
        this.contactData[event.target.name] = event.target.value;
    }

    handleOkay() {
        this.close('okay');
    }

    handleContactEdit() {
        console.log("here-->" + this.contactData.Id + this.contactData.FirstName + this.contactData.LastName + this.contactData.Phone + this.contactData.Email);
        
        editContactList({
            contactid: this.contactData.Id,
            lastName: this.contactData.LastName,
            firstName: this.contactData.FirstName,
            phone: this.contactData.Phone,
            email: this.contactData.Email
        }).then(result => {
            alert("edit : " + result);
            this.close("Okay");
            window.location.reload();
        })
    }
}
