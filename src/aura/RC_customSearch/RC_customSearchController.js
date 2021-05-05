/**
 * Created by BRITENET on 28.04.2021.
 */
({
    handleClick : function(component, event, helper) {
      var searchText = component.get('v.searchText');
      var action = component.get('c.searchForIds');
      action.setParams({searchText: searchText});
      action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === 'SUCCESS') {
          var ids = response.getReturnValue();
          sessionStorage.setItem('customSearch--recordIds', JSON.stringify(ids));
           var searchEvents = $A.get("e.c:RC_SearchEvent");
            console.log('bef ser');
            searchEvents.fire();
             console.log('af ser');
        }
      });
      $A.enqueueAction(action);
    }
})