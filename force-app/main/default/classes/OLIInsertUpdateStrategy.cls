public with sharing class OLIInsertUpdateStrategy implements IOLIStrategy{
    public void apply(List<Order_Line_Item__c> newList,
                      List<Order_Line_Item__c> oldList,
                      Map<Id, Order_Line_Item__c> newMap,
                      Map<Id, Order_Line_Item__c> oldMap,
                      OrderUnitOfWork uow) {
        Set<Id> salesOrderIds = new Set<Id>();
        for (Order_Line_Item__c oli : newList) {
            salesOrderIds.add(oli.Sales_Order__c);
        }
        
        uow.registerSalesOrdersForRecalculation(salesOrderIds);
    }
}