/**
 * Created by BRITENET on 07.05.2021.
 */
({

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