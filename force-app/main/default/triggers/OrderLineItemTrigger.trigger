trigger OrderLineItemTrigger on Order_Line_Item__c (before delete, after insert, after update, after delete) {
    SalesOrderCalculator.TriggerOperation operation;

    if (Trigger.isInsert) {
        operation = SalesOrderCalculator.TriggerOperation.INSERTING;
    } else if (Trigger.isUpdate) {
        operation = SalesOrderCalculator.TriggerOperation.UPDATING;
    } else if (Trigger.isDelete) {
        if (Trigger.isBefore) {
            operation = SalesOrderCalculator.TriggerOperation.BEFORE_DELETING;
        } else {
            operation = SalesOrderCalculator.TriggerOperation.AFTER_DELETING;
        }
    }

    new OrderLineItemTriggerHandler().runTrigger(
        Trigger.new,
        Trigger.old,
        Trigger.newMap,
        Trigger.oldMap,
        operation
    );
}