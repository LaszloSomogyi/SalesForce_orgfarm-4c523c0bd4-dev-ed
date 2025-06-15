public interface  IPricingStrategy {
    Decimal calculateAmount(Order_Line_Item__c oli);
}