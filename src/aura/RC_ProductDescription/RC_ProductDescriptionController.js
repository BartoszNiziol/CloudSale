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
             var appEvent = $A.get("e.c:ToastEvent");
                                appEvent.setParams({
                                                       "title": 'Success',
                                                       "message": 'Product added to Your basket',
                                                       "type" : 'success'
                                                   });
                                 appEvent.fire();
                }else{
                                 var appEvent = $A.get("e.c:ToastEvent");
                                 appEvent.setParams({
                                                        "title": 'Adding to basket Error',
                                                        "message": response.getError()[0].message,
                                                        "type" : 'error'
                                                    });
                                  appEvent.fire();
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
            }else{
                             var appEvent = $A.get("e.c:ToastEvent");
                             appEvent.setParams({
                                                    "title": 'Images Load Error',
                                                    "message": response.getError()[0].message,
                                                    "type" : 'error'
                                                });
                              appEvent.fire();
                         }
        });
        $A.enqueueAction(action);
    },

    photoClick: function (component, event, helper) {

    }
})