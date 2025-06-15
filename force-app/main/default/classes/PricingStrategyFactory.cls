public with sharing class PricingStrategyFactory {
    public static IPricingStrategy getStrategy(Order_Line_Item__c oli) {
        return new DefaultPricingStrategy();
    }
}