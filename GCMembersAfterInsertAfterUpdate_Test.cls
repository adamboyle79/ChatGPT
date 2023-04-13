@isTest
private class GCMembersAfterInsertAfterUpdate_Test {

    @testSetup static void setup() {
        TestClassDataFactoryBSPHN.createTestCommitteeMember();
    }

    @isTest
    static void testIntegrationCallAfterInsert() {
        TriggerHelper.executeCampaignRulesCalled = false;

        String uniqueId = String.valueOf(DateTime.now().getTime());
        Account testAccount = TestClassDataFactoryBSPHN.createTestAccountBSPHN(uniqueId);
        Contact testContact = TestClassDataFactoryBSPHN.createTestContact(testAccount);
        
        Test.startTest();
        Group_Committee_Members__c committeeMember = new Group_Committee_Members__c(
            Contact__c = testContact.Id,
            Account__c = testAccount.Id
        );
        insert committeeMember;
        Test.stopTest();

        System.assertEquals(true, TriggerHelper.executeCampaignRulesCalled, 'executeCampaignRules should be called');
    }

    @isTest
    static void testIntegrationCallAfterUpdate() {
        TriggerHelper.executeCampaignRulesCalled = false;

        // Prepare test data
        String uniqueId = String.valueOf(DateTime.now().getTime());
        Account testAccount = TestClassDataFactoryBSPHN.createTestAccountBSPHN(uniqueId);
        Contact oldContact = TestClassDataFactoryBSPHN.createTestContact(testAccount);
        Contact newContact = TestClassDataFactoryBSPHN.createTestContact(testAccount);

        Group_Committee_Members__c committeeMember = new Group_Committee_Members__c(
            Contact__c = oldContact.Id,
            Account__c = testAccount.Id
        );
        insert committeeMember;

        Test.startTest();
        committeeMember.Contact__c = newContact.Id;
        update committeeMember;
        Test.stopTest();

        System.assertEquals(true, TriggerHelper.executeCampaignRulesCalled, 'executeCampaignRules should be called');
        List<Group_Committee_Members__c> committeeMembers = [SELECT Id FROM Group_Committee_Members__c];
        System.assertEquals(2, committeeMembers.size());
    }

}