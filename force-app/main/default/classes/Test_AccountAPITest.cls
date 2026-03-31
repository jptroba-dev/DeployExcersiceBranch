@isTest
public class Test_AccountAPITest {
    
    @testSetup
    static void setupTestData() {
        // Crear cuentas de prueba
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test Account 1', AccountNumber = 'ACC-001'));
        testAccounts.add(new Account(Name = 'Test Account 2', AccountNumber = 'ACC-002'));
        testAccounts.add(new Account(Name = 'Test Account 3', AccountNumber = 'ACC-003'));
        
        insert testAccounts;
    }
    
    @isTest
    static void testGetAccountsSuccess() {
        // Preparar la solicitud
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/accounts/';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = new RestResponse();
        
        // Ejecutar el método
        Test.startTest();
        List<AccountAPI.AccountResponse> result = AccountAPI.getAccounts();
        Test.stopTest();
        
        // Validaciones
        System.assertEquals(3, result.size(), 'Debe devolver 3 cuentas');
        System.assertEquals('Test Account 1', result[0].accountName, 'El nombre debe coincidir');
        System.assertEquals('ACC-001', result[0].accountNumber, 'El número de cuenta debe coincidir');
        System.assertEquals('Test Account 2', result[1].accountName, 'El nombre debe coincidir');
        System.assertEquals('ACC-002', result[1].accountNumber, 'El número de cuenta debe coincidir');
    }
    
    @isTest
    static void testGetAccountsEmpty() {
        // Eliminar todas las cuentas de prueba
        delete [SELECT Id FROM Account];
        
        // Preparar la solicitud
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/accounts/';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = new RestResponse();
        
        // Ejecutar el método
        Test.startTest();
        List<AccountAPI.AccountResponse> result = AccountAPI.getAccounts();
        Test.stopTest();
        
        // Validación
        System.assertEquals(0, result.size(), 'Debe devolver lista vacía cuando no hay cuentas');
    }
    
    @isTest
    static void testResponseMapping() {
        // Preparar la solicitud
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/accounts/';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = new RestResponse();
        
        // Ejecutar el método
        Test.startTest();
        List<AccountAPI.AccountResponse> result = AccountAPI.getAccounts();
        Test.stopTest();
        
        // Validar que los campos se mapeen correctamente
        AccountAPI.AccountResponse firstResponse = result[0];
        System.assertNotEquals(null, firstResponse.accountName, 'accountName no debe ser nulo');
        System.assertNotEquals(null, firstResponse.accountNumber, 'accountNumber no debe ser nulo');
    }
}