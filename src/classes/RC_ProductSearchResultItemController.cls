/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_ProductSearchResultItemController {
    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
        try {
            return RC_ProductHandler.getImagesLinks(productId);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}