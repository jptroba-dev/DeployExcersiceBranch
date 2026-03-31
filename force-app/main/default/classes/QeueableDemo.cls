public class QeueableDemo implements System.Queueable {

    	public void execute (System.QueueableContext context){
		System.debug('Insite the execute method of Queueable Job');
            
        List<Account> listOfAccounts = new List<Account>([Select Id,Name FROM Account LIMIT 50]);
        System.debug('listOfAccounts ' + listOfAccounts);
            
		}
}

/*
QeueableDemo qd = new QeueableDemo();
Id jobId = System.enqueueJob(qd);
System.debug('jobId: ' + jobId);
*/