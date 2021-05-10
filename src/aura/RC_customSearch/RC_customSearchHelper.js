/**
 * Created by BRITENET on 10.05.2021.
 */
({
     toast : function(title,message,type){
                console.log('cstFct');
             var appEvent = $A.get("e.c:ToastEvent");
                                            appEvent.setParams({
                                                                   "title": title,
                                                                   "message": message,
                                                                   "type" : type
                                                               });
                                             appEvent.fire();

             }
})