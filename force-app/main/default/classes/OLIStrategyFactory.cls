public with sharing class OLIStrategyFactory {
    public static IOLIStrategy getStrategy(SalesOrderCalculator.TriggerOperation operation) {
        
        System.debug('OLIStrategyFactory is here, operation: ' + operation);
        
        switch on operation {
            when INSERTING {
                return new OLIInsertUpdateStrategy();
            }
            when UPDATING {
                return new OLIInsertUpdateStrategy();
            }
            when BEFORE_DELETING {
                return new OLIBeforeDeleteStrategy();
            }
            when AFTER_DELETING {
                return new OLIAfterDeleteStrategy();
            }
        }
        return null;
    }
}