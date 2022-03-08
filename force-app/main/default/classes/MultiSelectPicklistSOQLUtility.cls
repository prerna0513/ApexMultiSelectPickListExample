/*
* Class - MultiSelectPicklistSOQLUtility
* Description - This class search opportunity data based on one custom multiselect picklist value sent
* by the user. Here, the items selected (multiselect picklist field) is related to opportunity status. 
* Querying the records where the multiselect picklist has '(' [Parenthesis included in the value].
* needs to be properly manipulated so that the query is not malformed.
*/
public class MultiSelectPicklistSOQLUtility{


    /*
    * Function - getOpportunityBasedOnStatus 
    * Parameter - Oppotunity Status
    * Description - Based on opporunity status we are querying the oppotunity records.
    */
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

    /*
    * Function - getItemsUsedBasedOnStatus 
    * Parameter - Oppotunity Status
    * Description - Based on opporunity status we are mapping the custom multiselect picklist values 
    * containing special characters as parenthesis. 
    * Return - List of Multiselect picklist values
    */
    public static List<String> getItemsUsedBasedOnStatus(String oppStatus){
        List<String> itemsUsedList = new List<String>();
        if(oppStatus != '' && oppStatus == 'Closed Won'){
            itemsUsedList.add('Pen (1)');
            itemsUsedList.add('Paper (2)');
        }
        if(oppStatus != '' && oppStatus == 'Closed Lost'){
            itemsUsedList.add('Glue (2)');
            itemsUsedList.add('Stapler (4)');
        }

        if(itemsUsedList.size() > 0){
            return itemsUsedList;
        }
        return null;
    }

}