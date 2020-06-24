@IsTest
private with sharing class AccountManagerTest {
    @isTest static void  testGetAccountById() {
        Id recordId = createTestRecord();

        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Accounts/'
            + recordId + '/contacts/';

        request.httpMethod = 'GET';
        RestContext.request = request;

        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
        System.assertEquals('Test Contact 1', thisAccount.Contacts.get(0).Name);
        System.debug('testGetAccountById=>'+thisAccount.Contacts.get(0));
    }
    @isTest static void  testGetAccountByEmptyString() {
        RestRequest request = new RestRequest();

        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Accounts//contacts/';

        request.httpMethod = 'GET';
        RestContext.request = request;

        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assertEquals(null, thisAccount);
    }

    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            Name='Test record',
            Type='Prospect'
            );
        insert accountTest;

        Contact newContact = new Contact(
            Lastname = 'Test Contact 1',
            AccountId = accountTest.Id
        );
        insert newContact;

        return accountTest.Id;
    } 
}