public with sharing class dev_AccountController {
    
    /**
     * Fetches the first 10 Account records
     * @return List of Account records
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        try {
            return [
                SELECT Id, Name, Industry, Phone, Website, AnnualRevenue
                FROM Account
                ORDER BY Name ASC
                LIMIT 15
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching accounts: ' + e.getMessage());
        }
    }

    /**
     * Searches for Account records by name
     * @param searchTerm The search term to filter accounts
     * @return List of matching Account records
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchTerm) {
        try {
            String query = '%' + searchTerm + '%';
            return [
                SELECT Id, Name, Industry, Phone, Website, AnnualRevenue
                FROM Account
                WHERE Name LIKE :query
                ORDER BY Name ASC
                LIMIT 100
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error searching accounts: ' + e.getMessage());
        }
    }
}