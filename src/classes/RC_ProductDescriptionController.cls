/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_ProductDescriptionController {

    @AuraEnabled
    public static List<String> getImagesLinks(String productId){
        try{
            return RC_Image_Handler.getImagesLinks(productId);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void addToBasket (String customerId , String itemId, Decimal amount) {
        try {
            RC_BasketHandler.addToBasket(customerId, itemId, amount);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}