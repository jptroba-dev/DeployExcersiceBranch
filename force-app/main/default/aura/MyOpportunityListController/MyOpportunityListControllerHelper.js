({
    // Helper method to fetch opportunity information from controller
    fetchOppHelper: function(searchVal, component) {
        component.set("v.columnsToDisplay", [
            { label: "Opportunity Name", fieldName: "Name", type: "text" },
            { label: "Close Date", fieldName: "CloseDate", type: "date" },
            { label: "Amount", fieldName: "Amount", type: "currency", cellAttributes: { alignment: 'left' } }
        ]);

        // Creating the action
        var action = component.get("c.fetchOpportunity");
        action.setParams({
            "searchKeyWord": searchVal
        });

        // Calling server side method
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                debugger;
                component.set("v.lstOpportunity", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }

})