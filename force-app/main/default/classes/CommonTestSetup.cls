@isTest
public class CommonTestSetup {

    @testSetup
    static void setup(){
        //create common test accounts
        List<Account> testAccts= new List<Account>();
        for (Integer i=0;i<200;i++){
            testAccts.add(new Account (Name = 'Test Acc'+i, Industry='Education', Rating='Hot',
                                	Phone ='999-112'+i ));
                          }
        insert testAccts;
    
            }
    
    @isTest
    static void testMethod1(){
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test Acc0' LIMIT 1];
        acc.Phone = '555-5555';
        update acc;
        
        //delete acc
        Account acc2 = [SELECT Id FROM Account WHERE Name = 'Test Acc1' LIMIT 1];
        delete acc2;
    }
       
    @isTest
    static void testMethod2(){
        //check method 1 rolled back.
        
        Account acct = [SELECT Id,Phone FROM Account WHERE Name = 'Test Acc0' LIMIT 1];
        
        System.assertequals('999-1120',acct.Phone);
        // assert,assertEqual, assertNotEquals
        
        
        // verify original account created is not altered
        Account acct2 = [SELECT Id FROM Account WHERE Name = 'Test Acc1' LIMIT 1];
        System.assertNotEquals(null,acct2);
    }
    }