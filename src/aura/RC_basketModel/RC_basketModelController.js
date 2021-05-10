/**
 * Created by BRITENET on 02.05.2021.
 */
({
    getBasket: function (component, event, helper) {
         console.log('stat');
        let action = component.get("c.getBasketProductsIds");
        action.setCallback(this, function (response) {
            let state = response.getState();
            let foundIds = [];
            console.log(state);
            if (state == "SUCCESS") {
                component.set('v.wraps', response.getReturnValue());
            }else{
                 helper.toast('Retrieve basket item filed',response.getError()[0].message,'error');
            }
        });
        $A.enqueueAction(action);

    },

    onClicked: function (component, event, helper) {
        let urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/basket"
        });
        urlEvent.fire();
        component.set("v.isOpened", false);
    },

    openmodal: function (component, event, helper) {
        let modalBody;
        console.log("isOpened:" + component.get("v.isOpened"));
        if (!component.get("v.isOpened")) {
            $A.createComponent("c:RC_baksetModalContent", {},
                function (content, status) {
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

    setModalFlag: function (component, event, helper) {
        component.set("v.isOpened", false);
    },

    closeBasketModal: function (component, event, helper) {
        let ev = $A.get("e.c:RC_OvermouseCloseEvent");
        ev.fire();
    }
})