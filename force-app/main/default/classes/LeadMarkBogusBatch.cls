/**
 * Batch class to mark old, not-converted Leads as 'Bogus'
 *
 * Criteria:
 *  - IsConverted = false
 *  - CreatedDate < TODAY() - 30 days
 *
 * Action:
 *  - Sets Lead.Status = 'Bogus'
 *
 * Notes:
 *  - Ensure 'Bogus' is a valid value in the Lead.Status picklist/Lead Status values.
 *  - Uses Database.update with partial success handling.
 */
public with sharing class LeadMarkBogusBatch implements Database.Batchable<SObject> {

    // Allow overriding the cutoff in days if needed for reuse
    private Integer cutoffDays;

    public LeadMarkBogusBatch() {
        this.cutoffDays = 30;
    }

    public LeadMarkBogusBatch(Integer cutoffDays) {
        this.cutoffDays = (cutoffDays == null || cutoffDays <= 0) ? 30 : cutoffDays;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Compute cutoff date/time
        Datetime cutoff = Datetime.now().addDays(-cutoffDays);
        // Query: Leads not converted and created before cutoff
        String soql = 'SELECT Id, Status FROM Lead ' +
                      'WHERE IsConverted = false ' +
                      'AND CreatedDate < :cutoff';
        return Database.getQueryLocator(soql);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        if (scope == null || scope.isEmpty()) {
            return;
        }
        List<Lead> toUpdate = new List<Lead>();
        for (SObject sob : scope) {
            Lead l = (Lead)sob;
            // Only change if not already Bogus to avoid unnecessary DML
            if (l.Status != 'Bogus') {
                Lead upd = new Lead(Id = l.Id);
                upd.Status = 'Bogus';
                toUpdate.add(upd);
            }
        }
        if (!toUpdate.isEmpty()) {
            Database.SaveResult[] results = Database.update(toUpdate, false);
            // Optional: basic debug for failures
            for (Integer i = 0; i < results.size(); i++) {
                if (!results[i].isSuccess()) {
                    for (Database.Error err : results[i].getErrors()) {
                        System.debug(LoggingLevel.WARN, 'Failed to update Lead Id=' + toUpdate[i].Id + ' Error=' + err.getMessage());
                    }
                }
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug(LoggingLevel.INFO, 'LeadMarkBogusBatch finished for cutoffDays=' + cutoffDays);
    }

    // Convenience method to enqueue with default scope size
    public static Id run(Integer scopeSize) {
        Integer size = (scopeSize == null || scopeSize <= 0) ? 200 : scopeSize;
        return Database.executeBatch(new LeadMarkBogusBatch(), size);
    }
}