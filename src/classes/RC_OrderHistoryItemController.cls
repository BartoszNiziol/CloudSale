/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_OrderHistoryItemController {

    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
        try{
            return RC_Image_Handler.getImagesLinks(productId);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }

    }

}