trigger AccountDuplication on Account (before insert) {
    for (Account acc:Trigger.new){
        list<Account> mynew = [Select ID,Name from Account where Name= :acc.name];
        if(mynew.size()>0) {
            acc.Name.addError('Account with same name already existing');
        }
    }
}