/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_BasketController {


    @AuraEnabled
    public static List<RC_BasketWrapper> getBasketProductsIds(){
        try{
            return RC_BasketHandler.getBasketProductsIds();
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }

    }

    @AuraEnabled
    public static void submitOrder(){
        try{
            RC_OrderHandler.submitOrder();
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}