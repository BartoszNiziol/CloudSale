/**
 * Created by BRITENET on 27.04.2021.
 */

public with sharing class RC_CustomSearchController {
    @AuraEnabled
    public static List<String> searchForIds(String searchText) {
        List<Product2> results = [SELECT Id,Name FROM Product2 WHERE Name LIKE :searchText];

        List<String> namesOfProducts = new List<String>();
        for (Product2 p : results){
            namesOfProducts.add(p.Name);
        }
        
        return  namesOfProducts;
    }

}