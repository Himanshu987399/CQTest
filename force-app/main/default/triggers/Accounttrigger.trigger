trigger Accounttrigger on Account (After insert,After Update) {
    accountHandler.hasPermissionOrNot();
    if(Trigger.isAfter && Trigger.isInsert){
        if(accountHandler.hasPermission == true){
            accountHandler.createContact(Trigger.New);
        } 
        else{
            accountHandler.addError(Trigger.new);
        }
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        if(accountHandler.hasPermission == true){
            accountHandler.createContactOnUpdate(Trigger.New);
        } 
        else{
            accountHandler.addError(Trigger.new);
        }
    }
}