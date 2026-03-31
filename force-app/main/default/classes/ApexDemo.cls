public class ApexDemo {
    public ApexDemo() {
        

    }
    @AuraEnabled(cacheable=true)
    public static List<contact> getContactList(){
      //  try {        
            return [SELECT Id, Name FROM Contact limit 20];
    /*    } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }  */
    }

        @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        return [SELECT Id, Name FROM Account limit 2];
    }
}