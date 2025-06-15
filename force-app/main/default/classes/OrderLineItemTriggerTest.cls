@isTest
private class OrderLineItemTriggerTest {

    static void setupData(Integer oliCount, Decimal unitAmount, Boolean locked) {
        Sales_Order__c order = new Sales_Order__c(Name = 'Test Order', Locked__c = locked);
        insert order;

        List<Order_Line_Item__c> olis = new List<Order_Line_Item__c>();
        for (Integer i = 0; i < oliCount; i++) {
            olis.add(new Order_Line_Item__c(
                Name = 'OLI ' + i,
                Sales_Order__c = order.Id,
                Amount__c = unitAmount
            ));
        }
        insert olis;
    }

    @isTest
    static void testInsertTriggersRecalculationAndHighValue() {
        setupData(5, 25000, false);

        Sales_Order__c so = [SELECT Total_Amount__c, High_Value__c FROM Sales_Order__c LIMIT 1];
        System.assertEquals(125000, so.Total_Amount__c);
        System.assertEquals(true, so.High_Value__c);
    }

    @isTest
    static void testUpdateRecalculates() {
        setupData(2, 10000, false);

        Order_Line_Item__c oli = [SELECT Id, Amount__c FROM Order_Line_Item__c LIMIT 1];
        oli.Amount__c = 90000;
        update oli;

        Sales_Order__c so = [SELECT Total_Amount__c FROM Sales_Order__c LIMIT 1];
        System.assertEquals(100000, so.Total_Amount__c);
    }

    @isTest
    static void testDeleteAfterRecalculates() {
        setupData(3, 40000, false);

        Order_Line_Item__c oliToDelete = [SELECT Id FROM Order_Line_Item__c LIMIT 1];
        delete oliToDelete;

        Sales_Order__c so = [SELECT Total_Amount__c, High_Value__c FROM Sales_Order__c LIMIT 1];
        System.assertEquals(80000, so.Total_Amount__c);
        System.assertEquals(false, so.High_Value__c);
    }

    @isTest
    static void testPreventDeleteWhenLocked() {
        setupData(1, 10000, true);

        Test.startTest();
        try {
            delete [SELECT Id FROM Order_Line_Item__c LIMIT 1];
            System.assert(false, 'Expected delete to fail due to locked order');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('locked Sales Order'));
        }
        Test.stopTest();
    }

    @isTest
    static void testBatchInsert() {
        Sales_Order__c order = new Sales_Order__c(Name = 'Batch Order');
        insert order;

        List<Order_Line_Item__c> olis = new List<Order_Line_Item__c>();
        for (Integer i = 0; i < 200; i++) {
            olis.add(new Order_Line_Item__c(
                Name = 'OLI ' + i,
                Sales_Order__c = order.Id,
                Amount__c = 500
            ));
        }

        Test.startTest();
        insert olis;
        Test.stopTest();

        Sales_Order__c so = [SELECT Total_Amount__c FROM Sales_Order__c WHERE Id = :order.Id];
        System.assertEquals(100000, so.Total_Amount__c);
    }
}