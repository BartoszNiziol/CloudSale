/**
 * Created by BRITENET on 29.04.2021.
 */
({
    deleteItemFromBasket: function (component, event, helper) {
        var amount = component.get("v.amount");
        var quantity = component.get("v.quantity");
        if (amount < 1) {
            component.find('amountError').showCustomPopover({
                body: "Ammount must be 1 or higher",
                referenceSelector: ".amountHolder",
                cssClass: "popoverclass,cPopoverOpener,slds-m-bottom_xx-large,slds-nubbin_bottom"
            }).then(function (overlay) {
                component._overlay = overlay;
                setTimeout(function () {
                    //close the popover after 3 seconds
                    if (component._overlay) {
                        component._overlay.close();
                    }
                }, 3000);
            });
        } else if (amount > quantity) {

            component.find('amountError').showCustomPopover({
                body: "Amount can't be higher than quantity",
                referenceSelector: ".amountHolder",
                cssClass: "popoverclass,cPopoverOpener,slds-m-bottom_xx-large,slds-nubbin_bottom"
            }).then(function (overlay) {
                component._overlay = overlay;
                setTimeout(function () {
                    //close the popover after 3 seconds
                    if (component._overlay) {
                        component._overlay.close();
                    }
                }, 3000);
            });
        } else {
            var selectedEventId = event.target.id;
            var msg = 'Are you sure you want to delete this product?';
            console.log("before");
            if (!confirm(msg)) {
                console.log("in if");
                return false;
            } else {
                console.log("else");
                var productId = component.get("v.ProductId");

                console.log(productId);
                let deleteAction = component.get("c.deleteProductFromBasket");
                deleteAction.setParam("productId", productId);
                deleteAction.setParam("amount", amount);
                deleteAction.setCallback(this, function (response) {
                    let state = response.getState();
                });
                $A.enqueueAction(deleteAction);
                var compEvents = component.getEvent("RC_RefreshBasketEvent");
                compEvents.fire();
            }
        }
    },
    init: function (component, event, helper) {
        var itemId = component.get('v.recordId');
        let action = component.get("c.getImagesLinks");
        action.setParam('productId', itemId);
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state == "SUCCESS") {
                component.set('v.imagesLinks', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})