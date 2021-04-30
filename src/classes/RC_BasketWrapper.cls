/**
 * Created by BRITENET on 30.04.2021.
 */

public with sharing class RC_BasketWrapper {
    @auraEnabled
  public String productId{get;set;}
    @auraEnabled
   public Decimal quantity {get;set;}


    public RC_BasketWrapper (String productId,Decimal quantity){

        this.productId = productId;
        this.quantity = quantity;

    }

}