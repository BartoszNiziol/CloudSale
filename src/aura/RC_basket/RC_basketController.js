/**
 * Created by BRITENET on 28.04.2021.
 */
({
         getBasket : function(component, event, helper){
           var action = component.get("c.getBasketProductsIds");
            action.setCallback(this, function(response) {
                        let state = response.getState();
                        let foundIds = [];
                         if (state == "SUCCESS"){
                                             component.set('v.wraps',response.getReturnValue());
                                             }
                                             });
                                             $A.enqueueAction(action);
                                             console.log('finito');
         },

         submitOrderBasket : function (component, event,helper){
             var actionSubmit = component.get("c.submitOrder");
             console.log('HERE');
             actionSubmit.setCallback(this,function(response) {
                 var state = response.getState();
                 console.log("Submit order state" + state);
                        if(state == "SUCCESS"){

                        }
             });
             $A.enqueueAction(actionSubmit);
         }



})


