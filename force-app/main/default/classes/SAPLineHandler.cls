public class SAPLineHandler
{
  public static void MapSap(List<SAP_Line_Item__c> newtrigger)
  {
  Set<String> getlist=new Set<String>();
  Map<Id,Monthly_Product_Plan__c> getSalesRec=new Map<Id,Monthly_Product_Plan__c>();
  
  try
  {
  for(SAP_Line_Item__c c: newtrigger)
   getlist.add(c.Monthly_Product_Plan__c); 
   
  if(getlist.size()>0)
   getSalesRec=new Map<id, Monthly_Product_Plan__c>([SELECT id,User__r.Employee_Code__c,Monthly_Target__c,MPP_Mapping__c,Year__c from Monthly_Product_Plan__c where id IN:getlist]);
   
   if(!getSalesRec.isempty())
   {
    for(SAP_Line_Item__c c: newtrigger)
       c.Monthly_AOP__c= getSalesRec.get(c.Monthly_Product_Plan__c).Monthly_Target__c; 
   }  
  }
  catch(Exception e){ System.debug('Exception Caught :'+e);}  
  }
}