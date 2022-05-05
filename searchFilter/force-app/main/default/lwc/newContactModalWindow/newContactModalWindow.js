import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import MOBILE_PHONE_FIELD from '@salesforce/schema/Contact.MobilePhone';

export default class NewContactModalWindow extends LightningElement {
    @track modalShow = false;
    @track objectApiName = 'Contact';   
    @track fields = [FIRST_NAME_FIELD, LAST_NAME_FIELD, ACCOUNT_FIELD, EMAIL_FIELD, MOBILE_PHONE_FIELD];

    handleSuccess(e) {
        const event = new ShowToastEvent({
            title: "Account created",
            message: "Record ID: " + e.detail.id,
            variant: "success"
        });
        this.dispatchEvent(event);
        this.modalShow = false;       
        this.dispatchEvent(new CustomEvent('refresh'));        
    }
    
    handleError() {  
        const event = new ShowToastEvent({
            title: 'Error',
            variant: 'error',
            message: error.body.message,
        });
        this.dispatchEvent(event);
    }

    modalWindowShow(){
        this.modalShow = true;        
    }

    closeModalWindow(){
        this.modalShow = false;
    }    

}