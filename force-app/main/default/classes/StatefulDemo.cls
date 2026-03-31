global class StatefulDemo implements Database.Batchable<Sobject>, Database.Stateful{

	private Integer magicNum = 0;

	global Database.QueryLocator start(Database.BatchableContext bc){
    	System.debug('In the Start method');
    	return Database.getQueryLocator('Select Id, Name From Account LIMIT 100');
	}

global void execute(Database.BatchableContext bc, List<Account> scope){
    System.debug('In the execute method');
    for(Integer i = 0; i < 5; i++){
        magicNum++;
    }
}

global void finish(Database.BatchableContext bc){
    System.debug('In the finish method');
    System.debug('magicNum ' + magicNum); // magicNum =10 i e 2 batches of 50 each *5 for interaction per batch
}
}

/* invocation
StatefulDemo bd2 = new StatefulDemo();
Database.executeBatch(bd2,50);
*/