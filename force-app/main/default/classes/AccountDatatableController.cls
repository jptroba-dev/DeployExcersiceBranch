public with sharing class AccountDatatableController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchKey, String sortedBy, String sortedDirection) {
        // Whitelist sortable fields to prevent SOQL injection
        Set<String> allowedSortFields = new Set<String>{ 'Name', 'Industry', 'Rating', 'Type' };
        String sortField = allowedSortFields.contains(sortedBy) ? sortedBy : 'Name';

        String sortDir = 'ASC';
        if (String.valueOf(sortedDirection).toLowerCase() == 'desc') {
            sortDir = 'DESC';
        }

        String whereClause = '';
        if (String.isNotBlank(searchKey)) {
            // Move away from building a SOQL literal with quotes; use String.escapeSingleQuotes
            // and concatenate safely into the dynamic SOQL with ESCAPE clause.
            String escaped = String.escapeSingleQuotes(searchKey);
            // Escape LIKE wildcards and ESCAPE char
            escaped = escaped.replace('\\', '\\\\').replace('%', '\\%').replace('_', '\\_');
            // Build WHERE without nested quotes issues
            whereClause = 'WHERE Name LIKE \'%' + escaped + '%\' ESCAPE \'\\\\\'';
        }

        // Build dynamic query with controlled ORDER BY and optional WHERE
        String soql = 'SELECT Id, Name, Industry, Phone, Rating, Type, Website FROM Account ' +
                      whereClause + ' ORDER BY ' + sortField + ' ' + sortDir + ' NULLS LAST LIMIT 200';

        return Database.query(soql);
    }
}