public class Demo3 {
    
    Public void mainValueMethod(){
        
        String websiteUrl= 'www.mysite.com'; 
        
        system.debug('Before value call'+ websiteUrl);
        passByValueCall(websiteUrl);
        system.debug('After value call'+ websiteUrl);
    }

    private void passByValueCall(String websiteUrlValue){
        websiteUrlValue = 'www.salesforce.com'; // this change only remains in the method
    }
     /* 
      * Demo3 d3=new Demo3();
d3.mainValueMethod();
*/
    Public void mainReferenceMethod(){
    
        Account a= new Account();
        a.Name = 'Test Account';
        a.Website = 'www.site.com';
        
        system.Debug('Before reference call '+a);
        passByRefCall(a);
        system.Debug('after reference call '+a);
        
    }
    
    private void passByRefCall(Account a){
        a.Website = 'www.salesforce.com';
    }
    
} 
/*
Demo3 d3=new Demo3();
d3.mainValueMethod();

d3.mainReferenceMethod();
*/