/**
 * Created by BRITENET on 03.05.2021.
 */
({
    init: function (component, event, helper) {
        let action = component.get("c.searchOrders");
        action.setCallback(this, function (response) {
            let state = response.getState();
            console.log(state);
            if (state == "SUCCESS") {
                component.set('v.orders', response.getReturnValue());
                console.log(response.getReturnValue());
            }else{
                             var appEvent = $A.get("e.c:ToastEvent");
                             appEvent.setParams({
                                                    "title": 'Orders Load Error',
                                                    "message": response.getError()[0].message,
                                                    "type" : 'error'
                                                });
                              appEvent.fire();
                         }
        });
        $A.enqueueAction(action);
    },
    handleShowActiveSectionName: function (cmp, event, helper) {
        alert(cmp.find("accordion").get('v.activeSectionName'));
    },
    handleSetActiveSectionC: function (cmp) {
        cmp.find("accordion").set('v.activeSectionName', 'C');
    }
})