public class AccountDuplicateTriggerHandler {

     public static void checkforduplicates(List<Account> newAccList, System.TriggerOperation triggerEvent){
    List<Account> all = newAccList;
    List<String> Street_2 = new List<String>();
List<String> Street_3 = new List<String>();
         List<String> Street_4 = new List<String>();
         List<String> Street_5 = new List<String>();
         List<String> Country_Key = new List<String>();
         List<String> Region_Code = new List<String>();
         List<String> City = new List<String>();
         List<String> City_postal_code = new List<String>();
         List<String> account_name = new List<String>();



    for(Account a1:all){
        Street_2.add(a1.Street_2__c );
        Street_3.add(a1.Street_3__c );
        Street_4.add(a1.Street_4__c );
        Street_5.add(a1.Street_5__c );
        Country_Key.add(a1.Country_Key__c );
        Region_Code.add(a1.Region_Code__c );
        City.add(a1.City__c );
        City_postal_code.add(a1.City_postal_code__c );
        account_name.add(a1.name );

    }
    List<Account> accs = [select id,Street_2__c,Street_3__c,name,Street_4__c,Street_5__c,Country_Key__c,Region_Code__c,City__c,City_postal_code__c  from Account where Street_2__c  in:Street_2 and Street_3__c  in:Street_3 and  Street_4__c  in:Street_4 and Street_5__c  in:Street_5 and Country_Key__c  in:Country_Key and Region_Code__c  in:Region_Code and City__c  in:City and City_postal_code__c  in:City_postal_code];
    Map<String,Account> dm = new Map<String,Account>();

    for(Account a2:accs ){
                System.debug('street 2::'+a2.Street_2__c+'::street 3::'+a2.Street_3__c+'::cust name::'+a2.name);

        dm.put(a2.Street_2__c ,a2);
        dm.put(a2.Street_3__c ,a2);
        dm.put(a2.Street_4__c ,a2);
        dm.put(a2.Street_5__c ,a2);
        dm.put(a2.Country_Key__c ,a2);
        dm.put(a2.Region_Code__c ,a2);
        dm.put(a2.City__c ,a2);
        dm.put(a2.City_postal_code__c ,a2);
        dm.put(a2.name ,a2);

    }

    for(Account a:newAccList){
        if(dm.get(a.Street_2__c ) != null && dm.get(a.Street_3__c ) != null && dm.get(a.Street_4__c ) != null && dm.get(a.Street_5__c ) != null && dm.get(a.Country_Key__c ) != null && dm.get(a.Region_Code__c ) != null && dm.get(a.City__c ) != null && dm.get(a.City_postal_code__c ) != null && dm.get(a.name ) != null){
            a.addError('You Cannot Create Duplicate Account');
            

        }
         /*  if(dm.get(a.Street_3__c ) != null){
           
            a.Street_3__c .addError('You Cannot Create Duplicate Account');

        }*/
    }
    
     }
}