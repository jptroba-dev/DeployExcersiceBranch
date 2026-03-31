trigger AccountEmailer on Account (before insert) {
    
  if (Trigger.isBefore && Trigger.isInsert){
        System.debug('Im in AccountEmailer before insert Context');
    }
}