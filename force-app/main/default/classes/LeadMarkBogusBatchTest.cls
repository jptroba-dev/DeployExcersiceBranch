@IsTest
private class LeadMarkBogusBatchTest {
    @IsTest
    static void testMarksOldUnconvertedLeadsAsBogus() {
        // Prepare data: 2 old unconverted leads, 1 recent unconverted, 1 already converted-like (simulate by setting Status to Bogus already)
        List<Lead> leads = new List<Lead>{
            new Lead(LastName = 'Old One', Company = 'Acme Co', Status = 'Open - Not Contacted'),
            new Lead(LastName = 'Old Two', Company = 'Beta LLC', Status = 'Working - Contacted'),
            new Lead(LastName = 'Recent', Company = 'Gamma Inc', Status = 'Open - Not Contacted'),
            new Lead(LastName = 'AlreadyBogus', Company = 'Delta Ltd', Status = 'Bogus')
        };
        insert leads;

        // Backdate first two to older than 30 days by using an update via Test.setCreatedDate (supported in tests)
        Test.setCreatedDate(leads[0].Id, System.now().addDays(-40));
        Test.setCreatedDate(leads[1].Id, System.now().addDays(-45));
        // Recent one stays recent (default created date ~ now)
        // AlreadyBogus can be either old or recent; ensure it's old but already bogus to verify skip
        Test.setCreatedDate(leads[3].Id, System.now().addDays(-50));

        Test.startTest();
        // Run the batch with a small scope to exercise execute logic
        Id jobId = Database.executeBatch(new LeadMarkBogusBatch(30), 50);
        Test.stopTest();

        // Reload all leads
        Map<Id, Lead> reloaded = new Map<Id, Lead>([
            SELECT Id, Status, IsConverted, CreatedDate
            FROM Lead WHERE Id IN :leads
        ]);

        // Assertions:
        // Old unconverted leads should be Bogus
        System.assertEquals('Bogus', reloaded.get(leads[0].Id).Status, 'Old lead 1 should be marked Bogus');
        System.assertEquals('Bogus', reloaded.get(leads[1].Id).Status, 'Old lead 2 should be marked Bogus');

        // Recent unconverted should remain its original status
        System.assertEquals('Open - Not Contacted', reloaded.get(leads[2].Id).Status, 'Recent lead should not be changed');

        // Already Bogus should remain Bogus (no change, but still Bogus)
        System.assertEquals('Bogus', reloaded.get(leads[3].Id).Status, 'Already Bogus lead should remain Bogus');
    }

    @IsTest
    static void testRunConvenienceMethod() {
        // Minimal test to exercise LeadMarkBogusBatch.run
        insert new Lead(LastName = 'Any', Company = 'Any Co', Status = 'Open - Not Contacted');
        Test.startTest();
        Id jobId = LeadMarkBogusBatch.run(200);
        Test.stopTest();
        System.assertNotEquals(null, jobId, 'Batch job id should be returned');
    }
}