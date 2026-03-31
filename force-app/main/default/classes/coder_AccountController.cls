/**
 * @description Controller class to retrieve Account records
 * @author Salesforce Developer
 */
public with sharing class coder_AccountController {
    
    /**
     * @description Retrieves 10 Account records
     * @return List<Account> List of Account records
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        try {
            return [
                SELECT Id, Name, Type, Industry, Phone, Website, AnnualRevenue, CreatedDate
                FROM Account
                ORDER BY CreatedDate DESC
                LIMIT 10
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving accounts: ' + e.getMessage());
        }
    }
}