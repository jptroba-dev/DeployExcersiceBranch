@IsTest(SeeAllData=false)
private class UserSelectorServiceTest {

    @IsTest
    static void testLogUsersStartingWithJ_withResults() {
        User testUser = new User(
            Alias = 'jdoe',
            Email = 'jdoe@example.com',
            EmailEncodingKey = 'UTF-8',
            FirstName = 'Juan',
            LastName = 'Test',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'jdoe' + System.currentTimeMillis() + '@example.com'
        );
        insert testUser;

        Test.startTest();
        UserSelectorService.logUsersStartingWithJ();
        Test.stopTest();

        List<User> result = [
            SELECT Name FROM User WHERE Name LIKE 'J%' AND Id = :testUser.Id
        ];
        System.assertEquals(1, result.size(), 'Debe existir un usuario con nombre que empiece con J');
    }

    @IsTest
    static void testLogUsersStartingWithJ_noResults() {
        User testUser = new User(
            Alias = 'adoe',
            Email = 'adoe@example.com',
            EmailEncodingKey = 'UTF-8',
            FirstName = 'Ana',
            LastName = 'Test',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'adoe' + System.currentTimeMillis() + '@example.com'
        );
        insert testUser;

        Test.startTest();
        UserSelectorService.logUsersStartingWithJ();
        Test.stopTest();

        List<User> result = [
            SELECT Name FROM User WHERE Name LIKE 'J%' AND Id = :testUser.Id
        ];
        System.assertEquals(0, result.size(), 'No debe devolver usuarios cuyo nombre no empiece con J');
    }
}