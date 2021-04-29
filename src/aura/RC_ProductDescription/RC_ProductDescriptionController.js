/**
 * Created by BRITENET on 28.04.2021.
 */
({
    handleClick : function(component, event, helper) {

        var itemId = component.get('v.recordId');
        var contactId = component.get('v.contactId');

         let action = component.get("c.addToBasket");

         action.setParams({"customerId" : contactId, "itemId" : itemId});
         action.setCallback(this, function(response) {
                     let state = response.getState();
                     console.log(response.getError());
                     console.log(state);
                     if (state == "SUCCESS"){
                      component.set("v.addedToBasket", true);
                     }
                     });
                     $A.enqueueAction(action);
    }

})