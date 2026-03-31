public class AccountExtension {
    private final Account acct;
    public Integer numContacts { get; set; }

    // El constructor recibe el controlador estándar de la página
    public AccountExtension(ApexPages.StandardController stdController) {
        // Obtenemos el registro actual que está cargado en la página
        this.acct = (Account)stdController.getRecord();
        this.numContacts = 0;
    }

    // Método personalizado: Cuenta contactos relacionados
    public void countRelatedContacts() {
        if (acct.Id != null) {
            this.numContacts = [SELECT COUNT() FROM Contact WHERE AccountId = :acct.Id];
        }
    }
}