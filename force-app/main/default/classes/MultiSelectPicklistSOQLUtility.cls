public class MultiSelectPicklistSOQLUtility{

    @AuraEnabled
    public static List<Opportunity> getOpportunityBasedOnStatus(String oppStatus){
        List<Opportunity> oppList = new List<Opportunity>();
        if(oppStatus != null && oppStatus != ''){
            List<String> selectedItems = getItemsUsedBasedOnStatus(oppStatus);
            String selectedItemsStr = '(\''+string.join(selectedItems,'\',\'')+'\')';
            system.debug('String STR:::'+selectedItemsStr);
            String oppQuery = 'Select Id, Name From Opportunity Where Items_Used__c includes ' +selectedItemsStr;
            
            if(oppQuery != '' && oppQuery != null){
                oppList = Database.query(oppQuery);
            }
        }
        return oppList;
    }


    public static List<String> getItemsUsedBasedOnStatus(String oppStatus){
        List<String> itemsUsedList = new List<String>();
        if(oppStatus != '' && oppStatus == 'Closed Won'){
            itemsUsedList.add('Pen');
            itemsUsedList.add('Paper');
        }
        if(oppStatus != '' && oppStatus == 'Closed Lost'){
            itemsUsedList.add('Glue');
            itemsUsedList.add('Stapler');
        }

        if(itemsUsedList.size() > 0){
            return itemsUsedList;
        }
        return null;
    }

}