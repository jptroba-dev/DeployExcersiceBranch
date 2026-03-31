public with sharing class AnonimousCLI {
    public AnonimousCLI() {
        List<Account> acc= [SELECT Id, Name FROM Account LIMIT 10];
        System.debug('ACC VALUE: '+acc);


    }
}