/**
 * Created by BRITENET on 28.04.2021.
 */
({
    handleClick : function(component, event, helper) {

        var itemId = component.get('v.recordId');
        var contactId = component.get('v.contactId');
        var amount = component.get('v.amount');
         let action = component.get("c.addToBasket");

         action.setParams({"customerId" : contactId, "itemId" : itemId,"amount" : amount});
         action.setCallback(this, function(response) {
                     let state = response.getState();
                     console.log(response.getError());
                     console.log(state);
                     if (state == "SUCCESS"){
                      component.set("v.addedToBasket", true);
                        var toastEvent = $A.get("e.force:showToast");
                                               toastEvent.setParams({
                                                   "title": "Success!",
                                                   "message": "Product has been added to your basket."
                                               });
                                               toastEvent.fire();

                     }
                     });
                     $A.enqueueAction(action);



    }

})