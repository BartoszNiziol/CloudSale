/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_ProductHandler {

    public static List<String> searchForIds(String searchText) {
        try {
            String likeSearchText = '%' + searchText + '%';
            List<Product2> results = [SELECT Id,Name FROM Product2 WHERE Name LIKE :likeSearchText AND Family = :Label.Red_Carpet_Item_Family_Label];
            List<String> ProductsIds = new List<String>();
            for (Product2 p : results) {
                ProductsIds.add(p.Id);
            }
            return ProductsIds;
        }catch (Exception e){
            throw new AuraHandledException('Retrieving products failed' + e.getMessage());
        }
    }
}