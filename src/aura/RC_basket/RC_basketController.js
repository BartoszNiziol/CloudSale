/**
 * Created by BRITENET on 28.04.2021.
 */
({
    getBasket: function (component, event, helper) {
        let action = component.get("c.getBasketProductsIds");
        action.setCallback(this, function (response) {
            let state = response.getState();
            let foundIds = [];
            if (state == "SUCCESS") {
                component.set('v.wraps', response.getReturnValue());
            }else {
                 var appEvent = $A.get("e.c:ToastEvent");
                                appEvent.setParams({
                                                       "title": 'Basket load filed',
                                                       "message": response.getError()[0].message,
                                                       "type" : 'error'
                                                   });
                                 appEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    submitOrderBasket: function (component, event, helper) {
        let actionSubmit = component.get("c.submitOrder");
        actionSubmit.setCallback(this, function (response) {
            let state = response.getState();
            if (state == "SUCCESS") {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Your order has been submitted."
                });
                toastEvent.fire();
                let urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"
                });
                urlEvent.fire();
            }else{
                 var appEvent = $A.get("e.c:ToastEvent");
                                appEvent.setParams({
                                                       "title": 'Submit order filed',
                                                       "message": response.getError()[0].message,
                                                       "type" : 'error'
                                                   });
                                 appEvent.fire();
            }
        });
        $A.enqueueAction(actionSubmit);
    }
})


