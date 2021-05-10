/**
 * Created by BRITENET on 28.04.2021.
 */
({
    handleClick: function (component, event, helper) {
        let navEvt = $A.get('e.force:navigateToURL');
        navEvt.setParams({ url: '/' });
        navEvt.fire();
        let searchText = component.get('v.searchText');
        let action = component.get('c.searchForIds');
        action.setParams({ 'searchText': searchText });
        action.setCallback(this, function (response) {
            let state = response.getState();
        console.log(state);
            if (state === 'SUCCESS') {
                let ids = response.getReturnValue();
                sessionStorage.setItem('customSearch--recordIds', JSON.stringify(ids));
                let searchEvents = $A.get("e.c:RC_SearchEvent");
                searchEvents.fire();
            }else{
        helper.toast('Product Load Error',response.getError()[0].message,'error');
                         }

        });
        $A.enqueueAction(action);
    },
})