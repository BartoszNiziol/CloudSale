/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_BasketItemController {
    @AuraEnabled
    public static void deleteProductFromBasket(String productId, Decimal amount){
       RC_BasketHandler.deleteProductFromBasket(productId,amount);
    }

    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
        return RC_Image_Handler.getImagesLinks(productId);
    }

}