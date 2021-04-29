/**
 * Created by BRITENET on 28.04.2021.
 */
({
         getBasket : function(component, event, helper){
           let action = component.get("c.getBasketProductsIds");
            action.setCallback(this, function(response) {
                        let state = response.getState();
                        let foundIds = [];
                         if (state == "SUCCESS"){
                                             component.set('v.itemsId',response.getReturnValue());
                                             }
                                             });
                                             $A.enqueueAction(action);

                                             console.log('finito');
         }



})


