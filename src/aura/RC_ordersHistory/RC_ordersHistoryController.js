/**
 * Created by BRITENET on 03.05.2021.
 */
({
      init: function(component, event, helper) {

        var action = component.get("c.searchOrders");
           action.setCallback(this, function(response) {
                                  let state = response.getState();
                                  console.log(state);
                                   if (state == "SUCCESS"){
                                                       component.set('v.orders',response.getReturnValue());
                                                       }
                                                       });
                                                       $A.enqueueAction(action);

                   },




})