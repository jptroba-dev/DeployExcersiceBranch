@isTest
private class OpportunityManagerTest {

    @isTest
    static void testCreateOpportunity() {
        // 1. Ejecutar el método POST
        ID oppId = OpportunityManager.createOpportunity(
            'Test Opportunity POST', 
            'Prospecting', 
            '2026-12-31', 
            'Web'
        );

        // 2. Verificar que se creó el registro
        System.assertNotEquals(null, oppId, 'El ID no debería ser nulo');
        Opportunity opp = [SELECT Name FROM Opportunity WHERE Id = :oppId];
        System.assertEquals('Test Opportunity POST', opp.Name);
    }

    @isTest
    static void testGetOpportunityById() {
        // 1. Crear un registro de prueba en la base de datos
        Opportunity testOpp = new Opportunity(
            Name = 'Test Opp GET',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10),
            LeadSource = 'External'
        );
        insert testOpp;

        // 2. Simular el contexto de la petición REST
        RestRequest request = new RestRequest();
        // Construimos la URI incluyendo el ID del registro creado
        request.requestUri = '/services/apexrest/Opportunities/' + testOpp.Id;
        request.httpMethod = 'GET';
        
        // Asignamos la petición al contexto global de la prueba
        RestContext.request = request;

        // 3. Llamar al método GET de la clase
        Test.startTest();
        Opportunity result = OpportunityManager.getOpportunityById();
        Test.stopTest();

        // 4. Verificaciones
        System.assertNotEquals(null, result, 'Debería retornar una oportunidad');
        System.assertEquals(testOpp.Id, result.Id, 'El ID retornado no coincide');
        System.assertEquals('Test Opp GET', result.Name);
    }
}