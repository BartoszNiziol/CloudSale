/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_BasketModelController {

    public static List<RC_BasketWrapper> getBasketProductsIds(){
        try{
            return RC_BasketHandler.getBasketProductsIds();
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}