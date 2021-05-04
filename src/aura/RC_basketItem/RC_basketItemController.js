/**
 * Created by BRITENET on 29.04.2021.
 */
({
        deleteItemFromBasket : function(component, event, helper) {
            var selectedEventId = event.target.id;
            var msg = 'Are you sure you want to delete this product?';
            console.log("before");
            if(!confirm(msg)){
                console.log("in if");
                return false;
            } else{
                console.log("else");

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


        }
})