/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_BasketItemController {
    @AuraEnabled
    public static void deleteProductFromBasket(String productId, Decimal amount){
        try{
            RC_BasketHandler.deleteProductFromBasket(productId,amount);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
        try {
            return RC_Image_Handler.getImagesLinks(productId);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}