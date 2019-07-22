@isTest
public class AccountTeamHandlerTest {
  @TestSetup
    static void makeData(){
       CIty__c robj = new CIty__c();
       robj.country_key__c = 'IN';
       robj.Name='Maharashtra';
       insert robj;
       Account accObj = new Account();
       accObj.Name = 'Test';
       accObj.AccountNumber = '12345678';
       accObj.Region__c = robj.Id;
        accObj.Street_2__c = 'street2';
        accObj.Street_3__c = 'street3';
            accObj.Street_4__c = 'street4';
        accObj.Street_5__c = 'street5';
        accObj.Country_Key__c='IN';
        accObj.City__c='mumbai';
        accObj.City_postal_code__c='400001'; 
       insert accObj;
        
        CIty__c robj1 = new CIty__c();
       robj1.country_key__c = 'IN';
       robj1.Name='Goa';
       insert robj1;
    
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Admin_Dom' LIMIT 1];
        System.debug('PROFILE ID::::'+profileId.Id);
        User user1=new User();
        user1.LastName='TestUser1';
         user1.Username='testemail1323@gmail.com'; 
        user1.Email='testemail143@gmail.com'; 
        user1.Alias='user1'; 
        user1.TimeZoneSidKey='America/Los_Angeles';
        user1.LocaleSidKey='en_US';
        user1.EmailEncodingKey='ISO-8859-1';
        user1.LanguageLocaleKey='en_US';
        user1.ProfileId='00e0l000000OJcC';
        user1.User_Type__c='Domestic';
        insert user1;
         
         User user2=new User();
        user2.LastName='TestUser2';
         user2.Username='testemail2122@gmail.com'; 
        user2.Email='testemail2@gmail.com'; 
        user2.Alias='user2'; 
         user2.TimeZoneSidKey='America/Los_Angeles';
        user2.LocaleSidKey='en_US';
        user2.EmailEncodingKey='ISO-8859-1';
        user2.LanguageLocaleKey='en_US';
        user2.ProfileId='00e0l000000OJcC';
        user2.User_Type__c='Domestic';
        insert user2;
        
        Account_Team__c act_team1=new Account_Team__c();
        
        act_team1.Account__c=accObj.Id;
        act_team1.Account_Access__c='Read';
         act_team1.Team_Member__c=user1.Id;
        insert act_team1;
        
         Account_Team__c act_team2=new Account_Team__c();
        
        act_team2.Account__c=accObj.Id;
        act_team2.Account_Access__c='Read/Write';
        act_team2.Id=act_team1.Id;
         act_team2.Team_Member__c=user1.Id;
        update act_team2;
        
        Account_Team__c act_team3=new Account_Team__c();
        
        act_team3.Account__c=accObj.Id;
        act_team3.Account_Access__c='Read/Write';
        act_team3.Id=act_team2.Id;
        act_team3.Team_Member__c=user2.Id;
        update act_team3;
        
        delete act_team3;
        ExpenseTrackerController.getUserData();
        UrlConfigData__c config_data=new UrlConfigData__c(Token__c='',URL__c='http://procesys.archisys.biz/autoLogin?token=',name='ExpenseUrl');
        insert config_data;
        ExpenseTrackerController.getUrlConfigFromCS();
    }
    
     public static testmethod void methodName(){
     }
}