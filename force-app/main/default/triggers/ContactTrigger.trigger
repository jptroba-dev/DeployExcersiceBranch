trigger ContactTrigger on Contact (before insert) {
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    for(Contact con : trigger.new){
        if(con.Email != null){
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setTargetObjectId(con.Id);
            singleMail.setHtmlBody('Hello!');
            singleMail.setTreatTargetObjectAsRecipient(true);
            List<String> emailList = new List<String>();
            emailList.add(con.Email);
            singleMail.setToAddresses(emailList);
            emails.add(singleMail);
        }
    }
}