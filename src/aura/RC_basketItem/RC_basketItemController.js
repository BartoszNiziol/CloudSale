/**
 * Created by BRITENET on 29.04.2021.
 */
({
        deleteCarFromCart : function(component, event, helper) {
            component.set("v.recordId");
            let deleteAction = component.get("c.deleteFromBasket");
            $A.enqueueAction(deleteAction);
        }
})