public class DMLFixer {
    public static void runWorkaround() {
        // 1. Operación de datos (Non-Setup)
        insert new Account(Name = 'Solución Mixed DML');
        System.debug('>>> Cuenta insertada con éxito');
        
        // 2. Operación de configuración (Setup) vía @future
        updateUserAsync(UserInfo.getUserId());
        System.debug('>>> Llamada asíncrona enviada para evitar Mixed DML');
    }

    @future
    public static void updateUserAsync(Id userId) {
        User u = [SELECT Id FROM User WHERE Id = :userId];
        u.AboutMe = 'Ahora sí funciona';
        update u;
        System.debug('>>> Usuario actualizado en proceso separado');
    }
}