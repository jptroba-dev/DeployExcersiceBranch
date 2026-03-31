trigger AccTrigger on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            system.debug('Before Insert Trigger New' + Trigger.new);
            system.debug('Before Insert Trigger Old' + Trigger.old);
        }
        else if(Trigger.isUpdate)
        {
            system.debug('Before Update Trigger New' + Trigger.new);
            system.debug('Before UpdateTrigger Old' + Trigger.old);
        }
        if(Trigger.isDelete)
        {
            system.debug('Before Delete Trigger New' + Trigger.new);
            system.debug('Before Delete Trigger Old' + Trigger.old);
        }
    }
    else if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            system.debug('After Insert Trigger New' + Trigger.new);
            system.debug('After Insert Trigger Old' + Trigger.old);
        }
        else if(Trigger.isUpdate)
        {
            system.debug('After Update Trigger New' + Trigger.new);
            system.debug('After Update Trigger Old' + Trigger.old);
        }
        if(Trigger.isDelete)
        {
            system.debug('After Delete Trigger New' + Trigger.new);
            system.debug('After Delete Trigger Old' + Trigger.old);
        }
        else if(Trigger.isUndelete)
        {
            system.debug('After Undelete Trigger New' + Trigger.new);
            system.debug('After Undelete Trigger Old' + Trigger.old);
        }
    }
}