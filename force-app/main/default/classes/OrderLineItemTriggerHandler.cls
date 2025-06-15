public with sharing class OrderLineItemTriggerHandler {

    public void runTrigger(
        List<Order_Line_Item__c> newList,
        List<Order_Line_Item__c> oldList,
        Map<Id, Order_Line_Item__c> newMap,
        Map<Id, Order_Line_Item__c> oldMap,
        SalesOrderCalculator.TriggerOperation operation
    ) {
        IOLIStrategy strategy = OLIStrategyFactory.getStrategy(operation);
        OrderUnitOfWork uow = new OrderUnitOfWork();

        strategy.apply(newList, oldList, newMap, oldMap, uow);
        uow.applyChanges();
    }
}