@isTest
public class SeeAllDataTest {
	
    @isTest(seeAllData=true)
    static void accountTest(){
        List<Account> accountList= [SELECT Id,Name,Phone,Fax,Industry,Rating,Description FROM Account LIMIT 15];
        System.assertEquals(15,accountList.size(),'Expected Accounts are not matching');
    }
    
    @isTest
    static void contactTest(){
        Account acc = new Account(Name = 'TestAccount', Industry='Education',Rating='Hot',
                                 Phone='999-1112');
        insert acc;
        List<Contact> contactList = [SELECT Id,Name,Email, Phone FROM Contact LIMIT1];
        System.assertEquals(1, contactList.size(),'There are no contacts available in DB!');

        
    }
    
    @isTest
    static void loadDataTest(){
        List<Account> sobjectList = Test.loadData(Account.sObjectType,'TestAccounts');
        Account acc = sobjectList.get(0);
        System.debug('Account Record'+acc); // retrieve record from static resourse
        
        System.assertEquals(3,sobjectList.size());
        //Test.loadData(sObjectType,'static resource (need to upload to salesforce in static resources) name TestAccounts');+
        //this make reusable data to test
    }
    
    //to test class
    @isTest
    static void privatePropDemo(){
        ApexClass1.updatePriority(new Account(Name='SF inc',Rating='Hot'));
    }
    @isTest
        static void privatePropDemo2(){
        ApexClass1.updatePriority(new Account(Name='SF inc',Rating='Warm'));
    }
    @isTest
        static void privatePropDemo3(){
        ApexClass1.updatePriority(new Account(Name='SF inc',Rating='Cold'));
    }
}