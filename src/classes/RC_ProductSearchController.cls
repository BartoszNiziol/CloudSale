/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_ProductSearchController {
    @AuraEnabled
    public static List<String> searchForIds(String searchText) {
        try{
            return  RC_ProductHandler.searchForIds(searchText);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}