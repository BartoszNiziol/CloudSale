/**
 * Created by BRITENET on 06.05.2021.
 */
({
     showSpinner: function(component, event, helper) {
            component.set("v.Spinner", true);
        },
        hideSpinner : function(component, event, helper){
            component.set("v.Spinner", false);
        }
})