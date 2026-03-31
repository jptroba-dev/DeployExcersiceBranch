public class CheckLoops {
    public static void listDemo(){
        list<String> fruits= new  list<String>();
        fruits.add('apple');
        fruits.add('orange');
        fruits.add('Grapes');   
        
        integer size= fruits.size();
        String fruitName;
        /*
        for (Integer i=0;i < size; i++) {
            fruitName =fruits.get(i);
            System.debug('Fruit is' + fruitName);
        } */
        //foreach
        for (String fruit:fruits){     /// friut name of iteratable
            System.debug(fruit);
        }  
  // Crear lista de cuentas
		
        List<Account> accounts = new List<Account>();

// Agregar cuentas con valores
		accounts.add(new Account(Name = 'Empresa ABC', Industry = 'Technology'));
		accounts.add(new Account(Name = 'Empresa XYZ', Industry = 'Finance'));
		accounts.add(new Account(Name = 'Empresa 123', Industry = 'Retail'));

// Iterar sobre la lista
		for (Account acc : accounts) {
 		System.debug('Name: ' + acc.Name);
	    System.debug('Industry: ' + acc.Industry);
}
        
        insert accounts;
       		for (Account acc : accounts) {
    			System.debug('Inserted Account Id: ' + acc.Id);
			}


    }
}