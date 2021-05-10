/**
 * Created by BRITENET on 09.05.2021.
 */
({
     fireToast: function (component, event, helper) {
     let toastEvent = $A.get("e.force:showToast");

                    var eventMessage = event.getParam('message');
                    var eventType = event.getParam('type');
                    var eventTitle = event.getParam('title');

                    let toastMessage = component.get("v.message");
                    let toastType = component.get("v.toastType");
                    let toastTitle= component.get("v.title");
                    toastEvent.setParams({
                        "title": eventTitle,
                        "message": eventMessage,
                        "type" : eventType
                    });
                    toastEvent.fire();
    }
})