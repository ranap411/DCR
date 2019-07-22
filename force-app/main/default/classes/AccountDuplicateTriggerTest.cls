@isTest
public class AccountDuplicateTriggerTest {

      @TestSetup
    static void makeData(){
    
        
    }
        public static testmethod void methodName(){
                 test.startTest();
      event obj = new event();
       obj.subject = 'test';
       obj.startDateTime = system.now();
       obj.endDateTime = System.now().addDays(1);
       insert obj;
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
        Account accObj1 = new Account();
          accObj1.Name = 'Test';
       accObj1.AccountNumber = '12345678';
       accObj1.Region__c = robj.Id;
        accObj1.Street_2__c = 'street2';
        accObj1.Street_3__c = 'street3';
            accObj1.Street_4__c = 'street4';
        accObj1.Street_5__c = 'street5';
        accObj1.Country_Key__c='IN';
        accObj1.City__c='mumbai';
        accObj1.City_postal_code__c='400001';
         insert accObj1;
         test.stopTest();
         
            
        }
}