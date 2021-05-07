/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_BasketController {


    @AuraEnabled
    public static List<RC_BasketWrapper> getBasketProductsIds(){
        return RC_BasketHandler.getBasketProductsIds();
    }

    @AuraEnabled
    public static void submitOrder(){
        RC_OrderHandler.submitOrder();
    }

}