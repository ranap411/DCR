public class ActivitiesListViewController {
    @AuraEnabled
    public static List<Event> getEvents(){
        return [Select Id,Subject,Status__c,StartDateTime,EndDateTime,Event_Locked__c,What.Name,WhoId,Owner.Name 
                From Event 
                Where Status__c =: Constants.EVENT_STATUS_SENTFORAPPROVAL 
                ];
    }
    
    @AuraEnabled
    public static boolean updateEvents(List<Event> editedAccountList){
        //System.debug('Evts Recvd-->'+editedAccountList);
        try{
            update editedAccountList;
            return true; 
        } catch(Exception e){
            System.debug('IN ActivitiesLstVwCon.cls-->Exception-->'+e.getMessage()+' at Line-->'+e.getLineNumber());
            return false;
        }
    }
    
}