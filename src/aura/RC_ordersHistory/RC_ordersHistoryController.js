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
                 helper.toast('Orders Load Error',response.getError()[0].message,'error');
                         }
        });
        $A.enqueueAction(action);
    },
    handleShowActiveSectionName: function (cmp, event, helper) {
        alert(cmp.find("accordion").get('v.activeSectionName'));
    },
    handleSetActiveSectionC: function (cmp) {
        cmp.find("accordion").set('v.activeSectionName', 'C');
    },
     closeModal:function(component,event,helper){
            let cmpTarget = component.find('Modalbox');
            let cmpBack = component.find('Modalbackdrop');
            $A.util.removeClass(cmpBack,'slds-backdrop--open');
            $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
        },

        openmodal: function(component,event,helper) {
            let target = event.currentTarget;
            let orderName = target.dataset.value;

            component.set("v.selectedOrderForComplain",orderName)

            let cmpTarget = component.find('Modalbox');
            let cmpBack = component.find('Modalbackdrop');
            $A.util.addClass(cmpTarget, 'slds-fade-in-open');
            $A.util.addClass(cmpBack, 'slds-backdrop--open');
        },
        handleComplain:function (component,event,helper){

            let complainSubject = document.getElementById('complainSubject').value;
            let complainDescription = document.getElementById('complainDescription').value;
            let orderName = component.get("v.selectedOrderForComplain");
            let action = component.get("c.submitComplain");
            action.setParam("complainSubject", complainSubject);
            action.setParam("complainDescription", complainDescription);
            action.setParam("orderName", orderName);
            action.setCallback(this, function (response) {
                let state = response.getState();
                console.log(state+' complain handle');
                if (state == "SUCCESS") {
                     helper.toast('Success','Your complain has been submited','success');
                }else{
                 helper.toast('Submit complain failed',response.getError()[0].message,'error');
                }
            });
            $A.enqueueAction(action);





        }
})