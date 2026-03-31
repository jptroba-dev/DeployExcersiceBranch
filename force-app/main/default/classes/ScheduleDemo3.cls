Global class ScheduleDemo3 implements Schedulable {
    
    	Global void execute(SchedulableContext sc) {
			System.debug('In the execute method of Scheduled Job');
            
            // can invoke here batch job checking limits.
            // BatchDemo1 bd=new BatchDemo1();
            // Database.executeBatch(bd);
}
}

/*

ScheduleDemo3 sd3= new ScheduleDemo3();


*/