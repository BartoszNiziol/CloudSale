/**
 * Created by BRITENET on 29.04.2021.
 */
({
        deleteItemFromBasket : function(component, event, helper) {

            var productId = component.get("v.ProductId");
            console.log(productId);
            let deleteAction = component.get("c.deleteProductFromBasket");
            deleteAction.setParam("productId",productId);

            deleteAction.setCallback(this, function(response) {
                                 let state = response.getState();
                                 });
                                 $A.enqueueAction(deleteAction);
                                         var compEvents = component.getEvent("RC_RefreshBasketEvent");
                                         compEvents.fire();
        }
})