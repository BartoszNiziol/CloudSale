/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_OrderHistoryController {

    @AuraEnabled
    public static List<Order> searchOrders() {
        try{
          return RC_OrderHandler.searchOrders();
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static void submitComplain(String complainSubject, String complainDescription,String orderName){
        try{
            RC_ComplainHandler.submitComplain(complainSubject,complainDescription,orderName);
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}