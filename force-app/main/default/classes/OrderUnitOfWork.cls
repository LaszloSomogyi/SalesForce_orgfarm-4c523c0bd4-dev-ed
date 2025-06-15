public with sharing class OrderUnitOfWork {
    private Set<Id> orderIds = new Set<Id>();

    public void registerSalesOrdersForRecalculation(Set<Id> salesOrderIds) {
        orderIds.addAll(salesOrderIds);
    }

    public void applyChanges() {
        if (orderIds.isEmpty()) return;

        List<Sales_Order__c> ordersToUpdate = [
            SELECT Id, Total_Amount__c, High_Value__c,
                   (SELECT Id, Amount__c FROM Order_Line_Items__r)
            FROM Sales_Order__c WHERE Id IN :orderIds
        ];

        SalesOrderCalculator.recalculateSalesOrders(ordersToUpdate);
        update ordersToUpdate;
    }
}