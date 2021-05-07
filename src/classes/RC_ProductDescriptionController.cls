/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_ProductDescriptionController {

    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
        return RC_Image_Handler.getImagesLinks(productId);
    }
    @AuraEnabled
    public static void addToBasket (String customerId , String itemId, Decimal amount) {
        RC_BasketHandler.addToBasket(customerId,itemId,amount);
    }

}