public class HwQuery {
    
    public static void creacosas(){
		Account acc=new Account (
		Name='HW2aaa');
		insert acc;
		
        Account accquery = [select ID from Account where CreatedDate = TODAY];
        
        for (Integer cont=0;cont<5; cont++){
			Contact con= new Contact(
  			LastName= ('cuenta '+cont),
    		AccountId = accquery.Id
            );
  			insert con;
        	}  
		}
}