public class checkUserAssignedPermission {
	@AuraEnabled
    public static boolean method(String userId){
        String permissionSetName = 'AccountManager';
		String queryString = 'SELECT Id FROM PermissionSetAssignment WHERE AssigneeId = \'' + userId + '\' AND PermissionSet.Name = \'' + permissionSetName + '\'';
        List<PermissionSetAssignment> permissionSetInstance =  Database.query(queryString);
        if(permissionSetInstance.size() > 0){
            return true;
        }
        return false;
    }
}