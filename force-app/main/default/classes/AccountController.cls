/**
 * @description: Retrieves Account records for display in LWC datatable
 * @author: JP
 * @date: 2025-11-19
 * @group: Salesforce Development
 * @last modified: 2025-11-19
 * @last modified by: JP
 **/
public with sharing class AccountController {
    /**
     * @description: Retrieves Account records with essential fields
     * @param: limitCount - Number of records to return (default 10)
     * @return: List of Account records
     **/
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(Integer limitCount) {
        if (limitCount == null || limitCount <= 0) {
            limitCount = 10;
        }
        
        return [
            SELECT Id, Name, Industry, Phone, Website, AnnualRevenue
            FROM Account
            ORDER BY Name
            LIMIT :limitCount
        ];
    }

    /**
     * @description: Searches for Accounts by name
     * @param: searchTerm - Account name to search for
     * @param: limitCount - Number of records to return (default 10)
     * @return: List of Account records matching the search term
     **/
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchTerm, Integer limitCount) {
        if (limitCount == null || limitCount <= 0) {
            limitCount = 10;
        }
        
        String searchPattern = '%' + searchTerm + '%';
        
        return [
            SELECT Id, Name, Industry, Phone, Website, AnnualRevenue
            FROM Account
            WHERE Name LIKE :searchPattern
            ORDER BY Name
            LIMIT :limitCount
        ];
    }
}