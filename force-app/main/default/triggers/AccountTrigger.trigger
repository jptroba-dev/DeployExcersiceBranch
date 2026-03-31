trigger AccountTrigger on Account (before insert,before update,after insert,after update) {

    AccountTriggerHandler handler = new AccountTriggerHandler (Trigger.isExecuting, Trigger.size);
    
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            handler.OnBeforeInsert(Trigger.New);
        } else {
            handler.OnAfterInsert(Trigger.New);
        }
    } 
    else if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            handler.OnBeforeUpdate(Trigger.New, Trigger.old, Trigger.NewMap, Trigger.OldMap);
        } else {
            handler.OnAfterUpdate(Trigger.New, Trigger.old, Trigger.NewMap, Trigger.OldMap);
        }    
    }
}