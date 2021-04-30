/**
 * Created by BRITENET on 27.04.2021.
 */

public with sharing class RC_CustomSearchController {
    @AuraEnabled
    public static List<String> searchForIds(String searchText) {
        String likeSearchText = '%'+searchText+'%';
        List<Product2> results = [SELECT Id,Name FROM Product2 WHERE Name LIKE :likeSearchText AND Family =: Label.Red_Carpet_Item_Family_Label];
        List<String> ProductsIds = new List<String>();
        for (Product2 p : results){
            ProductsIds.add(p.Id);
        }
        return  ProductsIds;
    }

    @AuraEnabled
    public static void addToBasket (String customerId , String itemId){
        User user = [SELECT ContactId,FirstName,LastName FROM User WHERE Id = :UserInfo.getUserId()];
        List<OrderItem> orderItems;
        List<Order> userOrders = [SELECT  Id,Name,Pricebook2Id FROM Order  WHERE Contact__c = :user.ContactId AND Status = 'Basket'];
        if(!userOrders.isEmpty()) {
             orderItems = [SELECT Id,Quantity FROM OrderItem WHERE Product2.Id = :itemId AND OrderId = :userOrders.get(0).Id];
        }else {
             orderItems = new List<OrderItem>();
        }
        if(orderItems.size() == 0) {
            OrderItem newOrderItem = new OrderItem();
            Order basket;
            try {
                basket = [SELECT Id FROM order WHERE Contact__c = :user.ContactId AND Status = 'Basket'];
                basket.Pricebook2Id = '01s0900000BzG7tAAF';
                update basket;
            } catch (Exception e) {
                Account account = [SELECT Id FROM account WHERE Id = '0010900000HXrUyAAL'];
                Order order = new Order();
                order.Name = user.FirstName + user.LastName;
                order.AccountId = account.Id;
                order.Pricebook2Id = '01s0900000BzG7tAAF';
                order.status = 'Basket';
                order.Contact__c = user.ContactId;
                order.EffectiveDate = System.Date.today();
                insert order;
                basket = order;
            }
            List<PricebookEntry> pricebookEntries2 = [SELECT Id,Name FROM PricebookEntry];
            newOrderItem.OrderId = basket.Id;
            newOrderItem.Product2Id = itemId;
            newOrderItem.Quantity = 1;
            Product2 product = [SELECT Price__c FROM Product2 WHERE Id = :itemId];
            newOrderItem.UnitPrice = product.Price__c;
            List<PricebookEntry> pricebookEntries = [SELECT Id FROM PricebookEntry WHERE Product2Id = :itemId];
            Id pricebookEntry = pricebookEntries[0].Id;
            newOrderItem.PricebookEntryId = pricebookEntry;
            insert newOrderItem;
        }else{
           OrderItem item = orderItems.get(0);
            item.Quantity ++;
            update item;
        }
    }

    @AuraEnabled
    public static List<RC_BasketWrapper> getBasketProductsIds(){
        User user = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()];
        List<RC_BasketWrapper> results = new List<RC_BasketWrapper>();
        for (order ord : [
                SELECT Id,TotalAmount, ( SELECT PricebookEntry.Product2.id,Quantity FROM OrderItems)
                from order
                WHERE Contact__c = :user.ContactId AND Status = 'Basket'
        ]) {
            results = new List<RC_BasketWrapper>();
            for (OrderItem oi : ord.orderItems) {
                RC_BasketWrapper wrap = new RC_BasketWrapper(String.valueOf(oi.PricebookEntry.Product2.Id),oi.Quantity, ord.TotalAmount );
                results.add(wrap);
            }
        }
        return results;
    }

    @AuraEnabled
    public static void deleteProductFromBasket(String productId){
        User user = [SELECT ContactId,Id FROM User WHERE Id = :UserInfo.getUserId()];
        Order userOrders = [SELECT  Id FROM Order  WHERE Contact__c = :user.ContactId AND Status = 'Basket'];
        List<OrderItem> orderItems = [SELECT Id FROM OrderItem WHERE Product2.Id =:productId AND OrderId =:userOrders.Id];
        delete  orderItems[0];
    }
}