/**
 * Created by BRITENET on 27.04.2021.
 */
({
   onClick : function(component, event, helper) {
       var id = event.target.dataset.menuItemId;
       if (id) {
           component.getSuper().navigate(id);
        }
  }
})