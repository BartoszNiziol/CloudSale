/**
 * Created by BRITENET on 07.05.2021.
 */

public with sharing class RC_OrderHandler {


    public static void submitOrder(){
            User user = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()];
            Account account = [SELECT Id FROM account WHERE Id = '0010900000HXrUyAAL'];
            Contact contact = [SELECT FirstName, LastName FROM Contact WHERE Id = :user.ContactId];
            Order basket = [SELECT Id, ContractId from order WHERE Contact__c = :user.ContactId AND Status = 'Basket'];

            List<OrderItem> orderItems = [SELECT Id, Quantity, Product2Id FROM OrderItem WHERE OrderId = :basket.Id];
            List<Contract> oldContract = [SELECT Status FROM Contract WHERE Id = :basket.ContractId LIMIT 1];
            if (oldContract.size() > 0) {
                oldContract.get(0).Status = 'Activated';
                update oldContract;
            } else {
                Contract contract = new Contract();
                contract.AccountId = account.Id;
                contract.status = 'Draft';
                contract.startdate = System.Date.today();
                contract.ContractTerm = 120;
                insert contract ;
            }
            basket.Status = 'Done';
            basket.EffectiveDate = System.Date.today();
            List<Order> ordersSubmitted = [SELECT Id FROM Order WHERE EffectiveDate = :basket.EffectiveDate AND Status = 'Done' AND Contact__c = :contact.Id];
            if (ordersSubmitted.size() == 0) {
                basket.name = contact.FirstName + ' ' + contact.LastName + ' ' + basket.EffectiveDate.format();
            } else {
                basket.name = contact.FirstName + ' ' + contact.LastName + ' ' + basket.EffectiveDate.format() + ' #' + ordersSubmitted.size();
            }
            update basket;

            Contract contract = new Contract();
            contract.AccountId = account.Id;
            contract.status = 'Draft';
            contract.startdate = System.Date.today();
            contract.ContractTerm = 120;
            insert contract ;

            Order order = new Order();
            order.AccountId = account.Id;
            order.status = 'Basket';
            order.Contact__c = user.ContactId;
            order.name = contact.FirstName + ' ' + contact.LastName + ' Cart';
            order.EffectiveDate = System.Date.today();
            order.ContractId = contract.Id;
            order.Pricebook2Id = '01s0900000BzG7tAAF';
            insert order;
    }


    public static List<Order> searchOrders() {

            User user = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()];
            List<Order> resultOrders = new List<Order>();
            for (order ord : [
                    SELECT Id,name, TotalAmount, EffectiveDate, (
                            select Id,
                                    OrderId,
                                    OrderItemNumber,
                                    PricebookEntry.Product2.Name,
                                    PricebookEntry.Product2.Product_Image__c,
                                    PricebookEntry.Product2.Price__c,
                                    PricebookEntry.Product2.id,
                                    Quantity,
                                    UnitPrice
                            FROM OrderItems
                    )
                    from order
                    WHERE Contact__c = :user.ContactId AND Status = 'Done'
            ]) {
                resultOrders.add(ord);
            }
            return resultOrders;
    }
}