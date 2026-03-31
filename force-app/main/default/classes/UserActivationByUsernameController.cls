public with sharing class UserActivationByUsernameController {
    public String username { get; set; }

    public void activateUser() {
        if (String.isBlank(username)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debes ingresar un Username.'));
            return;
        }

        try {
            // Buscar usuario por Username
            User u = [SELECT Id, Name, Email, IsActive FROM User WHERE Username = :username LIMIT 1];

            if (u.IsActive) {
                // Ya está activo, no hacemos update ni correo
                ApexPages.addMessage(new ApexPages.Message(
                    ApexPages.Severity.INFO,
                    'El usuario ' + u.Name + ' ya estaba activo.'
                ));
                return;
            }

            // Activar usuario
            u.IsActive = true;
            update u;

            // Enviar notificación en otra transacción para evitar MIXED_DML
            sendActivationEmailAsync(u.Id);

            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.CONFIRM,
                'Usuario ' + u.Name + ' activado. Notificación enviada en segundo plano.'
            ));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
    }

    @future
    public static void sendActivationEmailAsync(Id userId) {
        User u = [SELECT Id, Name, Email FROM User WHERE Id = :userId];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { u.Email });
        mail.setSubject('Tu usuario ha sido activado');
        mail.setPlainTextBody('Hola ' + u.Name + ', tu cuenta en Salesforce ha sido activada exitosamente.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}