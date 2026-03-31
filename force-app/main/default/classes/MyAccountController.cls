public class MyAccountController {
    
    public list<account> accountList {get;set;}
    
    /* or 
public list<account> getAccountList(){
	return accountList;
}

public list<account> setAccountList(list<account> accList){
	this.accountList = accList;
}	
	*/
    
    
    public MyAccountController(){
        accountList = [select Id,Name,CreatedDate from Account where CreatedDate!=NULL limit 100 ];
    }

}