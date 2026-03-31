@isTest
public class Demo1TestClass {
    
    @testSetup
    static void mySetupData(){
        Account acc = new Account (Name = 'TestAcc', Industry='Education', Rating='Hot',
                                	Phone ='999-112' );
        insert acc;
        

    }
    
    
	@isTest
    static void accountTest(){
        Account acc = [SELECT Id FROM Account WHERE NAme = 'TestAcc'];
        System.assertNotEquals(null,acc);
    }
    
    @isTest
    static void contactTest(){
        Account acc1 = [SELECT Id FROM Account WHERE NAme = 'TestAcc'];
        
        Contact  con = new Contact(FirstName = 'Amit', LastName='Singh', Email='email@any.com',
                                  Phone='999-112', AccountId = acc1.Id);
        insert con;

    }
    
        @isTest
    static void opportunityTest(){
         Account accountRecord = [SELECT Id FROM Account WHERE NAme = 'TestAcc'];
        Opportunity opp = new Opportunity (Name = 'Dicson Plc.', AccountId = accountRecord.Id,
                                          Amount=989.34, StageName='Closed Won', 
                                          CloseDate = System.today().addMonths(7));
        insert opp;
            }  
}