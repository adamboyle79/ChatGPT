@isTest
public class TestClassDataFactoryBSPHN {

    public static Account createTestAccount(String uniqueId) {
        return new Account(
            Name = 'Test Account ' + uniqueId,
            BillingCity = 'Sydney',
            BillingStreet = 'Test Street',
            BillingCountry = 'Australia',
            BillingState = 'New South Wales',
            BillingPostalCode = '2000'
        );
    }

    public static Contact createTestContact(Account account) {
        return new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            AccountId = account.Id
        );
    }

    public static Account createTestAccountBSPHN(String uniqueId) {
        Account testAccount = createTestAccount(uniqueId);
        insert testAccount;
        return testAccount;
    }

    public static Contact createTestContact() {
        String uniqueId = String.valueOf(DateTime.now().getTime());
        Account testAccount = createTestAccount(uniqueId);
        insert testAccount;

        Contact testContact = createTestContact(testAccount);
        insert testContact;
        return testContact;
    }

    public static Group_Committee_Members__c createTestCommitteeMember() {
        String uniqueId = String.valueOf(DateTime.now().getTime());
        Account testAccount = createTestAccount(uniqueId);
        insert testAccount;

        Contact testContact = createTestContact(testAccount);
        insert testContact;

        Group_Committee_Members__c testCommitteeMember = new Group_Committee_Members__c(
            Contact__c = testContact.Id,
            Account__c = testAccount.Id
        );
        insert testCommitteeMember;
        return testCommitteeMember;
    }
}
