public class AccountTriggerHandler {

    private boolean m_isExecuting = false;
    private integer batchSize = 0;
    public static boolean isFromBatchJob;
    public static boolean isFromUploadApi = false;
    
    public AccountTriggerHandler(boolean isExcecuting, integer size)
    {
        m_isExecuting = isExcecuting;
        batchSize = size;
    }
    
    public void OnBeforeInsert(List<Account> newAccount){
        System.debug('Account Trigger on Before Insert');
    }
    public void OnAfterInsert(List<Account> newAccount){
        System.debug('Account Trigger on After Insert');
    }
    public void OnBeforeUpdate(List<Account> newAccount, List<Account> oldAccount, Map<ID,Account> newAccountMap,Map<ID,Account> oldAccountMap){
        System.debug('Account Trigger on Before Update');
    }    
    public void OnAfterUpdate(List<Account> newAccount, List<Account> oldAccount, Map<ID,Account> newAccountMap,Map<ID,Account> oldAccountMap){
        System.debug('Account Trigger on After Update');
    }
}