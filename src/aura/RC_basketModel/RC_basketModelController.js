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



//             openmodal: function(component,event,helper) {
//                  console.log('open');
//                 var cmpTarget = component.find('Modalbox');
//                 $A.util.addClass(cmpTarget, 'slds-fade-in-open');
//
//             },

              onClicked : function(component, event, helper) {
                    var urlEvent  = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                         "url": "/basket"
                       });
                       urlEvent.fire();
               },

//               openmodal: function(component, evt, helper) {
//                   console.log('in open modal');
//                       var modalBody;
//                       $A.createComponent("c:RC_baksetModalContent", {},
//                          function(content, status) {
//                              if (status === "SUCCESS") {
//                                  modalBody = content;
//                                  component.find('overlayLib').showCustomModal({
//                                      header: "Basket",
//                                      body: modalBody,
//                                      showCloseButton: false,
//                                      cssClass: "mymodal",
//                                      closeCallback: function() {
//
//                                      }
//                                  })
//                              }
//                          });
//                   }

             openmodal : function(component, event, helper) {
                   var modalBody;
                   if(!component.get("v.isOpened")){
                  $A.createComponent("c:RC_baksetModalContent", {},
                         function(content, status) {
                               if (status === "SUCCESS") {
                                modalBody = content;
                                component.find('overlayLib').showCustomPopover({
                                 body: modalBody,
                                 referenceSelector: ".mypopover",
//                                 cssClass: "slds-popover,slds-nubbin_bottom,slds-p-around_x-small,slds-m-bottom_xx-large,popoverclass,cPopoverTest",
                                 direction: "south"
                                })
                                component.set("v.isOpened", true);
                               }
                   });
                   }
                },

                setModalFlag : function(component, event, helper) {
                     component.set("v.isOpened",false);
                     }


})