/**
 * Created by BRITENET on 27.04.2021.
 */

public with sharing class RC_CustomSearchController {
    @AuraEnabled
    public static List<String> searchForIds(String searchText) {
        List<List<SObject>> results = [SELECT Id FROM Product2];
        List<String> ids = new List<String>();
        for (List<SObject> sobjs : results) {
            for (SObject sobj : sobjs) {
                ids.add(sobj.Id);
            }
        }
        return ids;
    }

}