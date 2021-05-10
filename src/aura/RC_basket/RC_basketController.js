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
               helper.toast('Basket load filed',response.getError()[0].message,'error');
            }
        });
        $A.enqueueAction(action);
    },

    submitOrderBasket: function (component, event, helper) {
        let actionSubmit = component.get("c.submitOrder");
        actionSubmit.setCallback(this, function (response) {
            let state = response.getState();
            if (state == "SUCCESS") {
                helper.toast('Submit','Order submit completed','success');
                let urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"
                });
                urlEvent.fire();
            }else{
                    helper.toast('Submit order filed',response.getError()[0].message,'error');
            }
        });
        $A.enqueueAction(actionSubmit);
    }

})


