public with sharing class contactsController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String searchKey) { 
        if (String.isBlank(searchKey)) {  
            return [
                SELECT FirstName, LastName, Email, Account.Name, AccountId, MobilePhone, CreatedDate 
                FROM Contact
                ORDER BY CreatedDate DESC
                LIMIT 10          
            ];
        } else {                     
            String searchName = '%' + searchKey + '%';
            return [
                SELECT FirstName, LastName, Email, Account.Name, AccountId, MobilePhone, CreatedDate 
                FROM Contact 
                WHERE FirstName
                LIKE :searchName
                ORDER BY CreatedDate DESC         
            ];         
        }
    }

    @AuraEnabled
    public static void deleteContact(List<Id> idContactsDelete) {
        List<Contact> listContactDelete = new List<Contact>();
        for (Id idContact : idContactsDelete) {
            Contact listSendContacts = [
                SELECT Id 
                FROM Contact
                WHERE Id =: idContact
                LIMIT 1
            ];
            listContactDelete.add(listSendContacts);
        }
        try {
            delete listContactDelete;
        } catch (Exception e) {
        }       
    }

   
}
