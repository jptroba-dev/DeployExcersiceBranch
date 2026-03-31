public class ApexClass1 {

    @TestVisible
    private static void updatePriority(Account accountRecord){
        if (accountRecord.Rating.equals('Hot')){
            accountRecord.CustomerPriority__c = 'High';
        } else if (accountRecord.Rating.equals('Warm')){
             accountRecord.CustomerPriority__c = 'Medium';
        } else {
            accountRecord.CustomerPriority__c = 'Low';
        }
    }
}