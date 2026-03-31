@isTest
public class SimpleUserActivationControllerTest {

    @testSetup
    static void setupData() {
        // Crear un perfil estándar para los usuarios de prueba
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        // Usuario inactivo
        User inactiveUser = new User(
            Alias = 'inact',
            Email = 'inactive@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Inactive',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Mexico_City',
            Username = 'inactive' + System.currentTimeMillis() + '@example.com',
            IsActive = false
        );
        insert inactiveUser;

        // Usuario activo
        User activeUser = new User(
            Alias = 'actv',
            Email = 'active@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Active',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Mexico_City',
            Username = 'active' + System.currentTimeMillis() + '@example.com',
            IsActive = true
        );
        insert activeUser;
    }

    @isTest
    static void testActivateInactiveUser() {
        User u = [SELECT Id, Username, IsActive FROM User WHERE IsActive = false LIMIT 1];

        UserActivationByUsernameController ctrl = new UserActivationByUsernameController();
        ctrl.username = u.Username;

        Test.startTest();
        ctrl.activateUser();
        Test.stopTest();

        User updatedUser = [SELECT Id, IsActive FROM User WHERE Id = :u.Id];
        System.assertEquals(true, updatedUser.IsActive, 'El usuario debería haberse activado');
        System.assertEquals(1, Limits.getEmailInvocations(), 'Se debió invocar el envío de correo');
    }

    @isTest
    static void testAlreadyActiveUser() {
        User u = [SELECT Id, Username, IsActive FROM User WHERE IsActive = true LIMIT 1];

        UserActivationByUsernameController ctrl = new UserActivationByUsernameController();
        ctrl.username = u.Username;

        Test.startTest();
        ctrl.activateUser();
        Test.stopTest();

        // El usuario sigue activo, pero no se debe haber enviado correo
        User stillActive = [SELECT Id, IsActive FROM User WHERE Id = :u.Id];
        System.assertEquals(true, stillActive.IsActive, 'El usuario ya estaba activo');
        System.assertEquals(0, Limits.getEmailInvocations(), 'No se debió enviar correo para usuario ya activo');
    }

    @isTest
    static void testNoUsernameProvided() {
        UserActivationByUsernameController ctrl = new UserActivationByUsernameController();
        ctrl.username = null;

        Test.startTest();
        ctrl.activateUser();
        Test.stopTest();

        System.assertEquals(true, ApexPages.hasMessages(), 'Debe mostrar un mensaje de error si no se ingresa Username');
    }
}