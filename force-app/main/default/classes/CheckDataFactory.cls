@isTest
public class CheckDataFactory {

    @TestSetup
	static void setupMethod(){
    List<Account> accList = TestDataFactory.prepareAccountList(
        'ApexHours ', '999-111', 'https://www.apexhours.com', 'Hot',
        'Banking', 200, 200
    );
    //TestDataFactory.prepareAccountList(Name, Phone, Web, Rating, Industry, NumberOfEmployees, noOfAccounts)
    User u = TestDataFactory.prepareUser(
        'Standard User', 'amit.salesforce21@gmail.com', 'Amit', 'Singh', '' );
    insert accList;
    System.runAs(u){

    }	
	}
    @IsTest // If you are using @Istest with testMethod there is no need to use Test.startTest & Test.stopTest method
	static void runAsTest(){
    List<Account> accList = [Select Id, Name, Rating, Industry From Account Limit 200];
    Set<id> accId = new Set<Id>();
    for(Account acc : accList){
        accId.add(acc.Id);
    }
    User u = [Select Id, Name From User Where Email = 'amit.salesforce21@gmail.com' Limit 1];
    System.runAs(u){
      //  ApexClass1.updateAccounts(accId);
    }
	}
    
    
}