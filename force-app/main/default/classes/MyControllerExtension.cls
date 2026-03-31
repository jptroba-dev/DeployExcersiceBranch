public class MyControllerExtension {

    private final Account acct;
    
    public MyControllerExtension(ApexPages.StandardController stdController){
        this.acct = (account) stdController.getRecord();
    }
    
    public String getGreeting(){
        return 'Hello ' + acct.name + ' ('+acct.Id + ')';
    }
}