/**
 * Created by BRITENET on 10.05.2021.
 */

public with sharing class RC_ComplainHandler {
    public static void submitComplain( String complainSubject, String complainDescription, String order) {
        User user = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()];
        Account account = [SELECT Id FROM account WHERE Id = '0010900000HXrUyAAL'];
        Contact contact = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :user.ContactId];
        Case complain = new Case();
        complain.AccountId = account.Id;
        complain.ContactId = contact.Id;
        complain.Subject = complainSubject;


            Order orderToComplain = [SELECT Id FROM Order WHERE Name = :order LIMIT 1];
            if(orderToComplain != null){
                complain.Order__c = orderToComplain.Id;
            }
        complain.Description = complainDescription;
        complain.Type = 'Furniture Complain';
        complain.Origin = 'Web';

        insert complain;
        }


    }

