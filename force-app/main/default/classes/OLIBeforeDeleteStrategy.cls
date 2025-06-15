public with sharing class OLIBeforeDeleteStrategy implements IOLIStrategy {
    public void apply(List<Order_Line_Item__c> newList,
                      List<Order_Line_Item__c> oldList,
                      Map<Id, Order_Line_Item__c> newMap,
                      Map<Id, Order_Line_Item__c> oldMap,
                      OrderUnitOfWork uow) {

        Set<Id> salesOrderIds = new Set<Id>();
        for (Order_Line_Item__c oli : oldList) {
            salesOrderIds.add(oli.Sales_Order__c);
        }                        

        Map<Id,Sales_Order__c> salesorderMap = new Map<Id,Sales_Order__c>([SELECT Id, Locked__c FROM Sales_Order__c WHERE Id IN: salesOrderIds]);

        for (Order_Line_Item__c oli : oldList) {
            if (salesorderMap.get(oli.Sales_Order__c).Locked__c) {
                oli.addError('You cannot delete an item from a locked Sales Order.');
            }
        }

        System.debug('OLIBeforeDeleteStrategy is here, salesOrderIds: ' + salesOrderIds);

    }
}