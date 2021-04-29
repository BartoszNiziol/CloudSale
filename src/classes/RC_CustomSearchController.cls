/**
 * Created by BRITENET on 27.04.2021.
 */

public with sharing class RC_CustomSearchController {
    @AuraEnabled
    public static List<String> searchForIds(String searchText) {
        System.debug(searchText);
        String likeSearchText = '%'+searchText+'%';
        List<Product2> results = [SELECT Id,Name FROM Product2 WHERE Name LIKE :likeSearchText AND Family =: Label.Red_Carpet_Item_Family_Label];

        List<String> ProductsIds = new List<String>();
        for (Product2 p : results){
            ProductsIds.add(p.Id);
        }

        System.debug(ProductsIds);
        return  ProductsIds;
    }

    @AuraEnabled
    public static void addToBasket (String customerId , String itemId){
        System.debug('start');
        User user = [SELECT ContactId,FirstName,LastName FROM User WHERE Id = :UserInfo.getUserId()];
        OrderItem newOrderItem = new OrderItem();
        Order basket;
        try{
             basket = [SELECT Id FROM order WHERE Contact__c = :user.ContactId AND Status = 'Basket'];
        }catch (Exception e){
            System.debug('cach');
            Account account = [SELECT Id FROM account WHERE Id = '0010900000HXrUyAAL'];

            Order order = new Order();
            order.status = 'Basket';
            order.Name = user.FirstName +user.LastName;
            order.AccountId =account.Id;
            order.Contact__c = user.ContactId;
            order.EffectiveDate = System.Date.today();
            order.Pricebook2Id ='01s0900000BzG7tAAF';

            insert(order);
           basket = order;

        }
        List<PricebookEntry> pricebookEntries2 = [SELECT Id,Name FROM PricebookEntry ];
        System.debug(pricebookEntries2);


        newOrderItem.OrderId = basket.Id;
        newOrderItem.Product2Id = itemId;
        newOrderItem.Quantity = 1;

        Product2 product = [SELECT Price__c FROM Product2 WHERE Id = :itemId];
        newOrderItem.UnitPrice = product.Price__c;
        List<PricebookEntry> pricebookEntries = [SELECT Id FROM PricebookEntry WHERE Product2Id = :itemId];

        Id pricebookEntry = pricebookEntries[0].Id;
        newOrderItem.PricebookEntryId = pricebookEntry;

        insert newOrderItem;

    }

    @AuraEnabled
    public static List<String> getBasketProductsIds(){
        User user = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()];
        List<String> results = new List<String>();

        for (order ord : [
                SELECT Id, ( SELECT PricebookEntry.Product2.id FROM OrderItems)
                from order
                WHERE Contact__c = :user.ContactId AND Status = 'Basket'
        ]) {
            results = new List<String>();
            for (OrderItem oi : ord.orderItems) {
                results.add(oi.PricebookEntry.Product2.Id);
            }
        }
        return results;
    }



}