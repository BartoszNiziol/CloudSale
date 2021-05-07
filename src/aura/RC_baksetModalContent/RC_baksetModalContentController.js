/**
 * Created by BRITENET on 04.05.2021.
 */
({
     closeModal:function(component,event,helper){
                  component.find("overlayLib").notifyClose();
                  let ev = $A.get("e.c:RC_ModalClosedEvent");
                  ev.fire();
                 }
})