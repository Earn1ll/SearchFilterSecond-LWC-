@IsTest
public with sharing class ContactsControllerTest {
    @TestSetup
    static void addContacts() {
        List<Contact> con = new List<Contact>();
        for (Integer i = 0; i < 10; i++) {
            Contact newContact = new Contact(
                LastName = 'Test' + i,
                FirstName = 'Contact' + i
            );
            con.add(newContact);
        }
        insert con;
    }

    @IsTest
    static void getContacts_returnContacts_contactsWasReceived() {
        List<Contact> contacts = [
            SELECT Id, LastName, FirstName, CreatedDate FROM Contact
        ];
        Test.startTest();
        List<Contact> contacts1 = ContactsController.getContacts('');
        Test.stopTest();
        System.assertEquals(contacts, contacts1, 'Contacts were not received');
    }

    @IsTest
    static void getContacts_returnContacts_contactsNotReceived() {
        List<Contact> oneContact = [
            SELECT Id, LastName, FirstName, CreatedDate FROM Contact
            WHERE FirstName = 'FirstNameContact'
        ];
        Test.startTest();
        List<Contact> oneContact1 = ContactsController.getContacts('FirstNameContact');
        Test.stopTest();
        System.assertEquals(oneContact, oneContact1, 'Contacts were received');
    }


    @IsTest
    static void deleteContact_contactWasDeleted() {
        List<Contact> con = new List<Contact>();
        for (Integer i = 0; i < 1; i++) {
            Contact newContact = new Contact(
                LastName = 'Test',
                FirstName = 'Contact'
            );
            con.add(newContact);
        }
        con.add(new Contact(
            FirstName = 'Contact1',
            LastName = 'Number One'     
        ));
        insert con;
        Contact testContact = [
            SELECT Id FROM Contact WHERE LastName = 'Number One' LIMIT 1
        ];
        List<Id> idTestContact = New List<Id>();
        idTestContact.add(testContact.Id);
        Test.startTest();
        contactsController.deleteContact(idTestContact);
        Test.stopTest();
        List<Contact> nullContact = [
            SELECT Id FROM Contact WHERE LastName = 'Number One'            
        ];
        System.assertEquals(0, nullContact.size(), 'Contact was deleted');
    }

    @IsTest
    static void deleteContact_contactNotDeleted() {
        Contact newContact = new Contact(
            FirstName = 'Contact',
            LastName = 'Test'
        );
        insert newContact;
        Contact newContact1 = new Contact(
            FirstName = 'Contact1',
            LastName = 'Test1'
        );
        insert newContact1;
        Contact testContact = [
            SELECT Id FROM Contact WHERE LastName = 'Test' LIMIT 1
        ];
        List<Id> idTestContact = New List<Id>();
        idTestContact.add(testContact.Id);
        Test.startTest();
        contactsController.deleteContact(idTestContact);
        Test.stopTest();
        List<Contact> nullContact = [
            SELECT Id FROM Contact WHERE LastName = 'Test1'            
        ];
        System.assertEquals(2, nullContact.size(), 'Contact not deleted');
    }
    }

