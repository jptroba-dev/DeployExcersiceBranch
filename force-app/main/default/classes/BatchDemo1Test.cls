@isTest
private class BatchDemo1Test {
    @isTest
    static void testBatch() {
        // 1. Preparar datos
        List<Account> accs = new List<Account>();
        for(Integer i=0; i<10; i++) {
            accs.add(new Account(Name = 'Test Account ' + i));
        }
        insert accs;

        // 2. Ejecutar el Batch
        Test.startTest();
        BatchDemo1 bd = new BatchDemo1();
        Database.executeBatch(bd);
        Test.stopTest(); // Aquí es donde el Batch realmente corre

        // 3. Verificación
        // En este caso, BatchDemo1 solo hace System.debug, 
        // pero normalmente verificarías cambios en los registros.
        Integer count = [SELECT COUNT() FROM Account WHERE Name LIKE 'Test Account%'];
        System.assertEquals(10, count, 'Deberían existir 10 cuentas creadas');
    }
}