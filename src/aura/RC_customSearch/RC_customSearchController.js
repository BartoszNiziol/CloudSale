/**
 * Created by BRITENET on 28.04.2021.
 */
({
    handleClick : function(component, event, helper) {
      var searchText = component.get('v.searchText');
      var action = component.get('c.searchForIds');
      action.setParams({searchText: searchText});
      action.setCallback(this, function(response) {
          console.log(response);
        var state = response.getState();
            console.log('customerSearchController state');
            console.log(state);
        if (state === 'SUCCESS') {
          var ids = response.getReturnValue();
          sessionStorage.setItem('customSearch--recordIds', JSON.stringify(ids));
          var navEvt = $A.get('e.force:navigateToURL');
          navEvt.setParams({url: '/'});
          navEvt.fire();
        }
      });
      $A.enqueueAction(action);
    }
})