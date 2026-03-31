@IsTest
private class AccountDatatableControllerTest {
    @TestSetup
    static void setupData() {
        List<Account> accs = new List<Account>();
        accs.add(new Account(Name = 'Acme', Industry = 'Manufacturing', Phone = '111-111-1111', Rating = 'Hot', Type = 'Customer', Website = 'https://acme.example.com'));
        accs.add(new Account(Name = 'Beta Corp', Industry = 'Technology', Phone = '222-222-2222', Rating = 'Warm', Type = 'Prospect', Website = 'https://beta.example.com'));
        accs.add(new Account(Name = 'Zeta Holdings', Industry = 'Finance', Phone = '333-333-3333', Rating = 'Cold', Type = 'Partner', Website = 'https://zeta.example.com'));
        insert accs;
    }

    @IsTest
    static void testGetAccounts_DefaultSort() {
        Test.startTest();
        List<Account> results = AccountDatatableController.getAccounts(null, null, null);
        Test.stopTest();

        System.assertNotEquals(0, results.size(), 'Expected some accounts');
        // Ensure fields present
        Account a = results[0];
        System.assertNotEquals(null, a.Id);
        System.assertNotEquals(null, a.Name);
    }

    @IsTest
    static void testGetAccounts_SearchByName() {
        Test.startTest();
        List<Account> results = AccountDatatableController.getAccounts('Acme', 'Name', 'asc');
        Test.stopTest();

        System.assert(results.size() > 0, 'Expected at least one matching account');
        Boolean hasAcme = false;
        for (Account a : results) {
            if (a.Name.contains('Acme')) {
                hasAcme = true;
                break;
            }
        }
        System.assertEquals(true, hasAcme, 'Expected to find Acme in results');
    }

    @IsTest
    static void testGetAccounts_SortDesc() {
        Test.startTest();
        List<Account> results = AccountDatatableController.getAccounts(null, 'Name', 'desc');
        Test.stopTest();

        System.assert(results.size() >= 2, 'Need at least two results to validate sort');
        // Validate ordering for desc by Name (Zeta should come before Beta/Acme)
        Integer idxZeta = -1, idxAcme = -1;
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].Name == 'Zeta Holdings') idxZeta = i;
            if (results[i].Name == 'Acme') idxAcme = i;
        }
        if (idxZeta != -1 && idxAcme != -1) {
            System.assert(idxZeta < idxAcme, 'Expected Zeta to appear before Acme when sorting desc by Name');
        }
    }
}