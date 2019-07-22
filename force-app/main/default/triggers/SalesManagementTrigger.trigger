/********************
Name: SalesManagementTrigger
Created by : Nikhil Tripathi
Purpose : Handles relationship between monthly targets and plans
Version : 1.0
********************/

trigger SalesManagementTrigger on Monthly_Product_Plan__c (before insert, before update,after insert, after update,before delete,after delete) {
 MonthlyProductPlanTriggerHandler.updateMonthlyAOPWhenMppIsDeleted(Trigger.new,Trigger.old, Trigger.operationType);
    
//(Trigger.new, Trigger.old,Trigger.oldMap,Trigger.operationType);    
 
 Map<String, Monthly_Product_Plan__c > createKey=new Map<String, Monthly_Product_Plan__c >();
 Map<String,Monthly_AOP__c > createMOPKey=new Map<String, Monthly_AOP__c >();
 Set<Id> getids= new Set<Id>();
 Set<Id> getMapids= new Set<Id>();
 Map<id,Monthly_AOP__c > AOPUpdateSet=new Map<id,Monthly_AOP__c >();
 List<Monthly_AOP__c > finalAop=new List<Monthly_AOP__c >();
 List<Monthly_AOP__c> getMOP=new List<Monthly_AOP__c>();
 List<Monthly_Product_Plan__c> RecToUpdate=new List<Monthly_Product_Plan__c>();
 Map<id,Monthly_Product_Plan__c> getRectype=new Map<id,Monthly_Product_Plan__c>();
 
 if(trigger.isupdate){
  for(Monthly_Product_Plan__c  c: trigger.new){    
     if( (c.Planned_Quantity__c!=trigger.oldMap.get(c.id).Planned_Quantity__c) || (c.Actual_Quantity__c!=trigger.oldMap.get(c.id).Actual_Quantity__c) ){  
       getids.add(c.Monthly_Target__c);}
       
  }
 }      
 
 else if(trigger.isInsert && trigger.isafter){
   for(Monthly_Product_Plan__c  c: trigger.new)  
       getMapids.add(c.Id); 
   if(getMapids.size()>0)          
       getRectype = new Map<id,Monthly_Product_Plan__c>([SELECT id, Planned_Quantity__c,Product__c,CreatedById,Year__c,Month__c,Monthly_Plan__c,Monthly_Plan__r.Account__r.recordtypeid,Monthly_Plan__r.Account__r.SAP_Code__c from Monthly_Product_Plan__c where id IN:getMapids]);
       
   if(getRectype.size()>0)
       for(Id  c: getRectype.keyset()){
       String strRecordDevName = Schema.SObjectType.Account.getRecordTypeInfosById().get(getRectype.get(c).Monthly_Plan__r.Account__r.recordtypeid).getDeveloperName();

       if(strRecordDevName=='Ophthalmic_Vision' || strRecordDevName=='Ortho_Dermal')
       createKey.put(getRectype.get(c).Monthly_Plan__r.Account__r.SAP_Code__c+getRectype.get(c).Year__c+getRectype.get(c).CreatedById+getRectype.get(c).Product__c+':'+getRectype.get(c).Monthly_Plan__c,getRectype.get(c)); 
       else 
       createKey.put(getRectype.get(c).Month__c+getRectype.get(c).Year__c+getRectype.get(c).CreatedById+getRectype.get(c).Product__c+':'+getRectype.get(c).Monthly_Plan__c,getRectype.get(c));     
       }           
             
   //*******code unit starts: MPP on insert
       
   if(!createKey.isEmpty())
   {
     System.debug('insert  : '+createKey);
     String currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;      
     getMOP=[SELECT id,Sales_User__c,Planned_Quantity__c,Account__c,Account_Sap_code__c,recordtypeid,Actual_Quantity__c,Product__c,Month__c,Year__c from Monthly_AOP__c where Year__c=: currentFiscalYear];
       
     if(getMOP.size()>0){  
       for(Monthly_AOP__c m: getMOP){
          String recordtypename = Schema.SObjectType.Monthly_AOP__c.getRecordTypeInfosById().get(m.recordtypeid).getDeveloperName();                 
           
           if(recordtypename=='International')          
             createMOPKey.put(m.Account_Sap_code__c+m.Year__c+m.Sales_User__c+m.Product__c,m);
           else
             createMOPKey.put(m.Month__c+m.Year__c+m.Sales_User__c+m.Product__c,m);          
       }    
     } 
     
     if(!createMOPKey.isEmpty()) {       
     for(String s: createKey.keyset())
     {
       List<String> getval= s.split(':');      
         if(createMOPKey.get(getval[0])!=NULL)
         {  
           /* String recordtypename = Schema.SObjectType.Monthly_AOP__c.getRecordTypeInfosById().get(createMOPKey.get(getval[0]).recordtypeid).getDeveloperName();                 
 
            if(recordtypename=='International'){
               createKey.get(s).Monthly_Target__c= createMOPKey.get(getval[0]).Id; 
               System.debug(createKey.get(s).Monthly_Target__c+': vals :'+recordtypename);
               RecToUpdate.add(createKey.get(s));
           }  */     
                
           createMOPKey.get(getval[0]).Planned_Quantity__c = createMOPKey.get(getval[0]).Planned_Quantity__c+ createKey.get(s).Planned_Quantity__c;
           
           AOPUpdateSet.put(createMOPKey.get(getval[0]).id, createMOPKey.get(getval[0])); 
         }                  
     } 
      
      if(AOPUpdateSet.values().size()>0){
       for(Monthly_AOP__c m :AOPUpdateSet.values()){
         finalAop.add(m);     
       }          
      }     
      
      if(finalAop.size()>0){
        for(Monthly_AOP__c a: finalAop)  
         database.update(finalAop, false); } 
      
      if(RecToUpdate.size()>0)
        database.update(RecToUpdate, false);          
    } 
  } 
 }
   //***********unit ends
    if(trigger.isupdate && trigger.isafter && getids.size()>0)
    {
    getMOP=[SELECT id,Planned_Quantity__c,Actual_Quantity__c, (SELECT id,Planned_Quantity__c,Actual_Quantity__c from Monthly_Product_Plans__r) from Monthly_AOP__c where id IN: getids];
    System.debug('here ');
    if(getMOP.size()>0){  
       for(Monthly_AOP__c m: getMOP){
        Decimal plan=0, act=0;
         for(Monthly_Product_Plan__c c: m.Monthly_Product_Plans__r)
         {
          plan=plan+c.Planned_Quantity__c;
          act=act+c.Actual_Quantity__c; 
         }
           System.debug('vals :'+plan+', act: '+act); 
           m.Planned_Quantity__c=plan;
           m.Actual_Quantity__c=act; 
           finalAop.add(m);
           
           System.debug('vals 3 :'+finalAop.size());           
       }          
    }   
      
     if(finalAop.size()>0)
        database.update(finalAop, false);
    }
  }