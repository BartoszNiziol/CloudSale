/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_BasketModelController {

    public static List<RC_BasketWrapper> getBasketProductsIds(){
        return RC_BasketHandler.getBasketProductsIds();
    }

}