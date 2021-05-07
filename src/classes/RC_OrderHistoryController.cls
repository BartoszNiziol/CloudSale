/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_OrderHistoryController {

    @AuraEnabled
    public static List<Order> searchOrders() {
        return RC_OrderHandler.searchOrders();
    }

}