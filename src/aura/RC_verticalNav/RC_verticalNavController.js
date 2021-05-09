/**
 * Created by BRITENET on 28.04.2021.
 */
({
   onClick : function(component, event, helper) {
       let id = event.target.dataset.menuItemId;
       if (id) {
           component.getSuper().navigate(id);
        }
  }
})