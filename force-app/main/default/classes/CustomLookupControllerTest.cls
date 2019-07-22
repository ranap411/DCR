@isTest
public class CustomLookupControllerTest {
    
    @isTest
    public static void unitTest(){
        
        Account acc = new Account();
        acc.name='Test';
        insert acc;
        
        CustomLookupController lookUpController = new CustomLookupController();
        CustomLookupController.LookupWrapper wrapObj = new CustomLookupController.LookupWrapper(acc.id,acc.Name);
        List<CustomLookupController.LookupWrapper> wrapList = CustomLookupController.fetchBillingAccount('Account','Name','',acc.id,'');
       CustomLookupController.fetchLookUpValues('testKeyword', 'Account');
        System.assert(wrapList.size()>0);
        
        
    
    }

}