public with sharing class SalesOrderCalculator {

    public enum TriggerOperation { INSERTING, UPDATING, BEFORE_DELETING, AFTER_DELETING }

    public static void recalculateSalesOrders(List<Sales_Order__c> ordersToUpdate) {
        for (Sales_Order__c order : ordersToUpdate) {
            Decimal total = 0;
            for (Order_Line_Item__c oli : order.Order_Line_Items__r) {
                IPricingStrategy strategy = PricingStrategyFactory.getStrategy(oli);
                total += strategy.calculateAmount(oli);
            }
            order.Total_Amount__c = total;
            order.High_Value__c = total >= 100000;

        }

    }

}