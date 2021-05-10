/**
 * Created by BRITENET on 07.05.2021.
 */
({

     init: function (component, event, helper) {
            let itemId = component.get('v.recordId');
            let action = component.get("c.getImagesLinks");
            action.setParam('productId', itemId);
            action.setCallback(this, function (response) {
                let state = response.getState();
                if (state == "SUCCESS") {
                    component.set('v.imagesLinks', response.getReturnValue());
                }else{
                                   helper.toast('Images Load Error',response.getError()[0].message,'error');
                             }
            });
            $A.enqueueAction(action);
        }

})