({
    // Method to be called on component initialization
    doInit: function(component, event, helper) {
        helper.fetchOppHelper(null, component);
    },
    
    // Method to perform search on opportunities
    searchOpportunities: function(component, event, helper) {
        var searchValue = component.find("searchField").get("v.value");
        
        console.log("user entered - ", searchValue);
        
        helper.fetchOppHelper(searchValue, component);
        
      
    }
})