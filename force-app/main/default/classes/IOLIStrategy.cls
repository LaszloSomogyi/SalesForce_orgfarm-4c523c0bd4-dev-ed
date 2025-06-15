public interface IOLIStrategy {
    void apply(List<Order_Line_Item__c> newList,
               List<Order_Line_Item__c> oldList,
               Map<Id, Order_Line_Item__c> newMap,
               Map<Id, Order_Line_Item__c> oldMap,
               OrderUnitOfWork uow);
}