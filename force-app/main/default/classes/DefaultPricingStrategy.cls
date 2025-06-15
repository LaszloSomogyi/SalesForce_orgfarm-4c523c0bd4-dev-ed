public with sharing class DefaultPricingStrategy implements IPricingStrategy{
    public Decimal calculateAmount(Order_Line_Item__c oli) {
        return oli.Amount__c != null ? oli.Amount__c : 0;
    }
}