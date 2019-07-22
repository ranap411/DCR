@isTest
public class TargetAndPlanningControllerTest {
    public static Account acc;
    public static User user;
      @TestSetup
    static void makeData(){
  
    }
    
      static testmethod void test() { 
             acc =new Account(name='Account', 
                Country_Key__c='IN', City__c='mumbai',City_postal_code__c='400001',Account_Locked__c=true,Status__c='Activated',Medical_Registration_No__c='test');
                   
        insert acc;
          
          Monthly_Plan__c mplan=new Monthly_Plan__c(name='mp1',Account__c=acc.id,Year__c='2019');
            insert mplan;
 
          
          List<Monthly_Product_Plan__c> mp_plan=new   List<Monthly_Product_Plan__c>();
          mp_plan.add(new Monthly_Product_Plan__c(Monthly_Plan__c=mplan.id));
          // Monthly_Product_Plan__c mp_plan=new  Monthly_Product_Plan__c(Monthly_Plan__c=mplan.id);
         insert mp_plan;
          
            Monthly_AOP__c m_aop= new Monthly_AOP__c(Account__c=acc.Id,Year__c='2019',Target_Quantity__c=10,Month__c='Jul');
         insert m_aop;
          
         Monthly_AOP__c[] m_mop=[SELECT Id FROM Monthly_AOP__c];
          Set<Id> aopIds = new Set<Id>();
			for(Monthly_AOP__c tsk: m_mop) {
 		aopIds.add(tsk.Id);
				}
          
          String uniqueUserName = 'dom_user' + DateTime.now().getTime() + '@testorg.com';
          Profile p = [SELECT Id FROM Profile WHERE Name='Domestic Sales'];
          UserRole ssd=[SELECT Id,name FROM UserRole WHERE Name='SS_D'];
          
		User u = new User(Alias = 'dom_u', Email='dom_user@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName,UserRole=ssd,Division__c='I');
          
          insert u;
          System.runAs(u) {
		  TargetAndPlanningController.getTargetAmountByUserDivision('Apr','2019','test');
          TargetAndPlanningController.getTargetAmountByUserDivision('Apr','2019','Domestic');
              TargetAndPlanningController.getTargetAmountByUserDivision('Apr','2019','Turkey');
              TargetAndPlanningController.getAccounts('Apr','2019','Domestic');
              TargetAndPlanningController.getAccounts('Apr','2019','Turkey');
              TargetAndPlanningController.getAccounts('Apr','2019','test');
              
            
          }
            TargetAndPlanningController.saveMPPS(mp_plan,'Apr','2019','Domestic');
          TargetAndPlanningController.saveMPPS(mp_plan,'Apr','2019','Turkey');
           TargetAndPlanningController.saveMPPS(mp_plan,'Apr','2019','test');
         
          TargetAndPlanningController tp_ctrl=new TargetAndPlanningController();
          tp_ctrl.summarizePlannedQtyOnAOP(aopIds); 
          
      }
}