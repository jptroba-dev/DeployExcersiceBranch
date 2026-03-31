@IsTest
private class AccountAPI_CreateAccountTest {
    @IsTest
    static void testGetAccounts() {
        // Setup: create sample accounts
        List<Account> accs = new List<Account>{
            new Account(Name = 'Acme One', AccountNumber = 'A-001'),
            new Account(Name = 'Acme Two', AccountNumber = 'A-002')
        };
        insert accs;

        // Prepare REST context for GET
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/accounts';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = new RestResponse();

        // Invoke
        List<AccountAPI.AccountResponse> res = AccountAPI.getAccounts();

        System.assertNotEquals(null, res, 'Response should not be null');
        System.assert(res.size() > 0, 'Should return at least one account');
        // Validate mapping of fields
        Boolean anyMatch = false;
        for (AccountAPI.AccountResponse ar : res) {
            if (ar.accountName == 'Acme One' && ar.accountNumber == 'A-001') {
                anyMatch = true;
                break;
            }
        }
        System.assert(anyMatch, 'Should include the inserted account with expected fields');
        // Status for GET is default 200; not explicitly set in method.
    }

    @IsTest
    static void testCreateAccount_Success() {
        // Prepare payload
        AccountAPI.CreateAccountRequest payload = new AccountAPI.CreateAccountRequest();
        payload.Name = 'REST Created';
        payload.AccountNumber = 'REST-001';
        payload.Phone = '555-1234';
        String body = JSON.serialize(payload);

        // Prepare REST context for POST
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/accounts';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf(body);
        RestContext.request = req;
        RestContext.response = new RestResponse();

        // Invoke
        AccountAPI.CreateAccountResponse res = AccountAPI.createAccount();

        System.assertEquals(201, RestContext.response.statusCode, 'Should return 201 Created');
        System.assertEquals(true, res.success, 'Success flag should be true');
        System.assertNotEquals(null, res.id, 'Should return created Id');

        // Verify record exists
        Account created = [SELECT Id, Name, AccountNumber, Phone FROM Account WHERE Id = :res.id];
        System.assertEquals('REST Created', created.Name);
        System.assertEquals('REST-001', created.AccountNumber);
        System.assertEquals('555-1234', created.Phone);
    }

    @IsTest
    static void testCreateAccount_EmptyBody() {
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/accounts';
        req.httpMethod = 'POST';
        // No body set
        RestContext.request = req;
        RestContext.response = new RestResponse();

        AccountAPI.CreateAccountResponse res = AccountAPI.createAccount();
        System.assertEquals(400, RestContext.response.statusCode, 'Empty body should return 400');
        System.assertEquals(false, res.success, 'Success should be false');
        System.assertNotEquals(null, res.message, 'Message should describe the error');
    }

    @IsTest
    static void testCreateAccount_MissingName() {
        // Missing Name
        Map<String, Object> payload = new Map<String, Object>{
            'AccountNumber' => 'NO-NAME-001',
            'Phone' => '555-0000'
        };
        String body = JSON.serialize(payload);

        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/accounts';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf(body);
        RestContext.request = req;
        RestContext.response = new RestResponse();

        AccountAPI.CreateAccountResponse res = AccountAPI.createAccount();
        System.assertEquals(400, RestContext.response.statusCode, 'Missing Name should return 400');
        System.assertEquals(false, res.success, 'Success should be false');
        System.assert(res.message != null && res.message.contains('Name is required'), 'Error message should mention Name is required');
    }

    @IsTest
    static void testCreateAccount_InvalidJson() {
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/accounts';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf('{ invalid json }'); // malformed
        RestContext.request = req;
        RestContext.response = new RestResponse();

        AccountAPI.CreateAccountResponse res = AccountAPI.createAccount();
        System.assertEquals(400, RestContext.response.statusCode, 'Invalid JSON should return 400');
        System.assertEquals(false, res.success, 'Success should be false');
        System.assertNotEquals(null, res.message, 'Message should describe invalid JSON');
    }
}