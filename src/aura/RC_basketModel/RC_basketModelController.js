/**
 * Created by BRITENET on 02.05.2021.
 */
({
         getBasket : function(component, event, helper){
           let action = component.get("c.getBasketProductsIds");
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

          closeModal:function(component,event,helper){
                 var cmpTarget = component.find('Modalbox');
                 $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
             },

             openmodal: function(component,event,helper) {
                 var cmpTarget = component.find('Modalbox');
                 $A.util.addClass(cmpTarget, 'slds-fade-in-open');

             },

             handleHover: function(component,event,helper){
                 getBasket(component,event,helper);
                 openmodal(component,event,helper);

             }




})