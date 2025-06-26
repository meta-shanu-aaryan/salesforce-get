import { api, LightningElement } from 'lwc';
import LightningModal from 'lightning/modal';
import deleteContact from '@salesforce/apex/ContactListController.deleteContact';

export default class deleteModal extends LightningModal {

    @api contactIds;

    handleOkay() {
        this.close('Okay');
    }

    async handleContactDelete() {

        await deleteContact({ contactIdList: this.contactIds })
            .then(result => {
                alert("deleted" + result)
                window.location.reload();
                this.close;
            })
            .catch(error => { alert("error" + error) })
    }
}
