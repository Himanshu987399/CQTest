public class accountHandler {
    public static boolean hasPermission = false;
    public static void hasPermissionOrNot(){
        String permissionSetName = 'AccountManager';
        String queryString = 'SELECT Id FROM PermissionSetAssignment WHERE AssigneeId = \'' + UserInfo.getUserId() + '\' AND PermissionSet.Name = \'' + permissionSetName + '\'';
        List<PermissionSetAssignment> permissionSetInstance =  Database.query(queryString);
        if(permissionSetInstance.size() > 0){
            hasPermission = true;
        }
    }
    public static void addError(List<Account> acclist){
        for(Account acc: acclist){
            acc.addError('User donnot have edit and create permission');
        }
    }
    public static void createContact(List<Account> acclist){
        List<Contact> conList = new List<Contact>();
        for(Account acc : acclist){
            if(acc.Active__c == true){
                Contact conInstance = new Contact();
                conInstance.LastName = acc.Name + ' Customer Representative';
                conInstance.AccountId = acc.Id;
                conList.add(conInstance);
            }
        }
        if(conList.size() != 0){
            insert conList;
        }
    }
    public static void createContactOnUpdate(List<Account> acclist){
        List<Account> accData = [select Account_Activation_Summary__c,Active__c,Name,id,(select Id from Contacts) from Account where Id In: acclist];
        List<Contact> conList = new List<Contact>();
        for(Account acc : accData){
            for(Account acc1 :acclist){
                if(acc.Id == acc1.id){
                    List<Contact> conData = acc.Contacts;
                    String accSummary = acc.Account_Activation_Summary__c;
                    if(!String.isBlank(acc.Account_Activation_Summary__c) ){
                        if(acc.Active__c == true && conData.size() < 1){
                            Contact conInstance = new Contact();
                            conInstance.LastName = acc.Name + ' Customer Representative';
                            conInstance.AccountId = acc.Id;
                            conList.add(conInstance);
                        }
                    }
                    else{
                        acc1.addError('Account activation summary is blank');
                    }
                }
                
            }
            
        }
        if(conList.size() != 0){
            insert conList;
        }
    }
}