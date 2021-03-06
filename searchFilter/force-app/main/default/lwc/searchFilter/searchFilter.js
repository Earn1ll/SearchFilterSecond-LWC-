import getContacts from '@salesforce/apex/contactsController.getContacts';
import { LightningElement, track } from 'lwc';

export default class SearchFilter extends LightningElement {
    @track records = [];
    searchValue = '';

    searchId(event) {
        this.searchValue = event.target.value;        
    }

    searchContact(){       
        getContacts({
            searchKey:this.searchValue
        })
        .then(result=>{
            this.records = result;            
            this.dispatchEvent(new CustomEvent('filter', {detail: this.records}))                  
        })            
        .catch(error => {                
            const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: error.body.message,
            });
            this.dispatchEvent(event);
                
            this.records = [];
        });       
    }
}