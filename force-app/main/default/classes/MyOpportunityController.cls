public class MyOpportunityController {
    
    // Get the list of opportunities based on search value
    @AuraEnabled
    public static List<Opportunity> fetchOpportunity(String searchKeyWord) {
        List<Opportunity> returnList = new List<Opportunity>();
        
        // If search value is null then return all opps. Else search accordingly
        String searchKey = String.isBlank(searchKeyWord) ? '%%' : searchKeyWord + '%';
        
        returnList = [SELECT Id
                      , Name
                      , CloseDate
                      , Amount
                      FROM Opportunity
                      WHERE Name
                      LIKE :searchKey
                      LIMIT 15];
        
        return returnList;
    }
}