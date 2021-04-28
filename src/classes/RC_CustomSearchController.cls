/**
 * Created by BRITENET on 27.04.2021.
 */

public with sharing class RC_CustomSearchController {
    @AuraEnabled
    public static List<String> searchForIds(String searchText) {
        System.debug(searchText);
        String likeSearchText = '%'+searchText+'%';
        List<Product2> results = [SELECT Id,Name FROM Product2 WHERE Name LIKE :likeSearchText AND Family =: Label.Red_Carpet_Item_Family_Label];

        List<String> ProductsIds = new List<String>();
        for (Product2 p : results){
            ProductsIds.add(p.Id);
        }

        System.debug(ProductsIds);
        return  ProductsIds;
    }

}