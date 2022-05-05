@IsTest
public with sharing class contactsControllerTest {

    @TestSetup
    static void addContacts(){
        List<Contact> listAddContacts= new List<Contact>();
        for (Integer i = 0; i < 100; i++) {
            Contact newContact = new Contact(
                LastName = 'Test' + i,
                FirstName = 'Contact' + i
            );
            listAddContacts.add(newContact);
        }
        listAddContacts.add(new Contact(
            FirstName = 'Contact1',
            LastName = 'Number One'
                       
        ));
        insert listAddContacts;
    }

    @IsTest
    static void getContactsTest(){
        Test.startTest();
        List<Contact> getContactsController = contactsController.getContacts('');
        Test.stopTest();

        List<Contact> allContacts = [
            SELECT LastName, FirstName, CreatedDate 
            FROM Contact
        ];
        
        System.assertEquals(allContacts, getContactsController);
        
    }

    @IsTest
    static void getOneContactTest(){
        Test.startTest();
        List<Contact> getOneContactsController = contactsController.getContacts('Contact1');
        Test.stopTest();

        List<Contact> oneContacts = [
            SELECT LastName, FirstName, CreatedDate 
            FROM Contact
            WHERE FirstName = 'Contact1'
        ];
        System.assertEquals(oneContacts, getOneContactsController);
    }

    @IsTest
    static void deleteContactTest() {
        Contact testContact = [
            SELECT Id 
            FROM Contact
            WHERE LastName = 'Number One'
            LIMIT 1
            ];
       
        List<Id> idTestContact = New List<Id>();
        idTestContact.add(testContact.Id);
        
        Test.startTest();
        contactsController.deleteContact(idTestContact);
        Test.stopTest();

        List<Contact> nullContact = [
            SELECT Id 
            FROM Contact
            WHERE LastName = 'Number One'            
            ];
        System.assertEquals(0, nullContact.size());
    }
    
}

