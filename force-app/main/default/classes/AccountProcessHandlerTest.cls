@isTest
public class AccountProcessHandlerTest {
    
    @TestSetup
    static void makeData(){
        //List<String>  months=new List<String> {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
        
    }
    public static testmethod void methodName(){
         Id RecordTypeIdContact = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Distributor_T').getRecordTypeId();
 		//UserRole r =[SELECT Id,name FROM UserRole WHERE Name='RSM_D'];
        
      
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
        accObj.recordtypeid=RecordTypeIdContact;
         accObj.Branch__c = 'N/A';
      accObj.Sub_Status__c=  'Submitted To Branch Team';
        List <Monthly_Plan__c> mp_list=new List <Monthly_Plan__c>();
        
        insert accObj;
        
        
       // Account_Team__c acc_team=new Account_Team__c(Account__c=accObj1.Id);
        
        
       // Account_Team__c acc_team1=new Account_Team__c(Account__c=accObj2.Id);
        
        
        
         Attachment attach=new Attachment();   	
    	attach.Name='ERL';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attach.body=bodyBlob;
        attach.parentId=accObj.id;
        insert attach;
        
           string before = 'Testing base 64 encode';            
         Blob beforeblob = Blob.valueOf(before);
         //Insert contentdocument data
         ContentVersion cv = new ContentVersion();
         cv.title = 'test content trigger';      
         cv.PathOnClient ='test';           
         cv.VersionData =beforeblob;          
         insert cv;         
                                                
         ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];

        ContentDocumentLink newFileShare = new ContentDocumentLink();
        newFileShare.contentdocumentid = testcontent.contentdocumentid;
        newFileShare.LinkedEntityId = accObj.Id;
        newFileShare.ShareType= 'V';
        insert newFileShare;
        
        
        
        test.startTest();
        
        List<AccountProcessHandler.MonthlyPlanCreationRequest> mpcr_list=new List <AccountProcessHandler.MonthlyPlanCreationRequest>();
        
        
        AccountProcessHandler.MonthlyPlanCreationRequest mpcr=new  AccountProcessHandler.MonthlyPlanCreationRequest();
        mpcr.accountId=accObj.Id;
        mpcr.numberOfMonthlyPlanRecords=12; 
        mpcr_list.add(mpcr);
        AccountProcessHandler.createMonthlyPlanRecords(mpcr_list);
        
        //List<Monthly_Plan__c> mPlanList1=AccountProcessHandler.mpcr_list;       
        SubmitForApprovalController.checkAccHasERLAttachmentAndCESRecord(String.valueOf(accObj.Id));
        SubmitForApprovalController.setIsAccHavingERLFieldOnAccount(String.valueOf(accObj.Id));
        test.stopTest();
        
    }  
     public static testmethod void methodName1(){
          
           Account accObj1 = new Account();
            accObj1.Name = 'Test';
       
        insert accObj1;
     }
     public static testmethod void methodName2(){
          
           Account accObj2 = new Account();
            accObj2.Name = 'Test';
		accObj2.Branch__c = 'Mumbai';
      	accObj2.Sub_Status__c=  'Submitted To Branch Team';       
        insert accObj2;
         
         Account_Team__c acc_team=new Account_Team__c(Account__c=accObj2.Id);
         insert acc_team;
     }
     
}