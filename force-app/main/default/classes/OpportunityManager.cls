@RestResource(urlMapping='/Opportunities/*')
global with sharing class OpportunityManager {

    @HttpGet
    global static Opportunity getOpportunityById() {
        RestRequest request = RestContext.request;
        // Extrae el oppId del final de la URL
        String oppId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        
        Opportunity result = [SELECT Name, StageName, LeadSource, CloseDate, Probability 
                            FROM Opportunity 
                            WHERE Id = :oppId];
        return result;
    }
    
    @HttpPost
    global static ID createOpportunity(String name, String stage, 
                                       String closedate, String source) {
        
        Opportunity newOpportunity = new Opportunity(
            Name = name,
            StageName = stage,
            LeadSource = source,
            CloseDate = Date.valueOf(closedate)
        );
        
        insert newOpportunity;
        return newOpportunity.Id;
    }
    
    @HttpPut
    global static ID upsertOpportunity(String name, String stage, 
                                       String closedate, String source, String id) {
        Opportunity thisOpportunity = new Opportunity(
            Id = id,
            Name = name,
            StageName = stage,
            LeadSource = source,
            CloseDate = Date.valueOf(closedate)
        );
        upsert thisOpportunity;
        return thisOpportunity.Id;
    }
    
    @HttpPatch
    global static ID updateOpportunityFields() {
        RestRequest request = RestContext.request;
        String oppId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        
        // Buscamos el registro
        Opportunity thisOpportunity = [SELECT Id FROM Opportunity WHERE Id = :oppId];
        
        // Deserializamos el JSON dinámicamente
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
        
        // Iteramos sobre los campos enviados en el JSON
        for(String fieldName : params.keySet()) {
            thisOpportunity.put(fieldName, params.get(fieldName));
        }
        
        update thisOpportunity;
        return thisOpportunity.Id;
    }
}