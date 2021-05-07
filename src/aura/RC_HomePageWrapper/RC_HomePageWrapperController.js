/**
 * Created by BRITENET on 05.05.2021.
 */
({
    handleSearch: function (component, event, helper) {
        console.log('handle s');
        var itemId = component.set('v.isSearch', true);
    },
    handleUnSearch: function (component, event, helper) {
        console.log('handle unS');
        var itemId = component.set('v.isSearch', false);
    }
})