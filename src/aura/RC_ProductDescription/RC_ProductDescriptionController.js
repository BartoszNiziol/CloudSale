/**
 * Created by BRITENET on 28.04.2021.
 */
({
    handleClick: function (component, event, helper) {

        let itemId = component.get('v.recordId');
        let contactId = component.get('v.contactId');
        let amount = component.get('v.amount');
        if (amount < 1) {
            component.find('amountError').showCustomPopover({
                body: "Amount must be 1 or higher",
                referenceSelector: ".quantity",
                cssClass: "popoverclass,cPopoverOpener,slds-m-bottom_xx-large,slds-nubbin_bottom,popover"
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
            console.log('else');
            let action = component.get("c.addToBasket");
            action.setParams({ "customerId": contactId, "itemId": itemId, "amount": amount });
            action.setCallback(this, function (response) {
                let state = response.getState();
                console.log(response.getError());
                console.log(state);
                if (state == "SUCCESS") {
                    component.set("v.addedToBasket", true);
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "Product has been added to your basket."
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        }
    },

    init: function (component, event, helper) {
        let itemId = component.get('v.recordId');
        let action = component.get("c.getImagesLinks");
        action.setParam('productId', itemId);
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state == "SUCCESS") {
                component.set('v.imagesLinks', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    photoClick: function (component, event, helper) {

    }
})