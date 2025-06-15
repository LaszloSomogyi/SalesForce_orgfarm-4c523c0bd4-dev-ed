Industrial Sales Platform - Sales Order Managing Functionality

## Business Background:
- Sales Orders represent a customer's order
- Order Line Items represent individual order items within a Sales Order
- Order Line Items show the currency value of the given item
- The summarized value of the Order Line Items is shown at the Sales Order page
- If the summarized value on a Sales Order is higher than $100,000, it is marked as a High Value item

## Technical Background:
- Sales_Order__c and Order_Line_Item__c Records are in a master-detail relationship
- Reparenting is allowed

## Business Requirements:
- When an Order Line Item is inserted/updated/deleted under a Sales Order, the summarized value of the related Order Line Items should be automatically recalculated
- If a Sales Order is marked as Locked, users should not be able to delete of any of its Order Line Items 
- If the summarized value on a Sales Order is higher than $100,000, it is marked as a High Value item

## Technical Setup:
- All required functionalities are divided into separate classes
- The Calculator class is responsible for re-calculating the summarized total amount value on the Sales Orders irrespective of the nature of the changes on the Order Line Items
- The Unit of Work class is responsible to collect all records that should be changed, effectuating the calculation calling the Calculator class and commit the changes at once to the records
- Each Strategy class is responsible for calling one type of change functionality based on the type of the changes
- The Factory class is responsible for triggering the appropriate Strategy classes based on the type of the changes that triggers the functionality
- The Trigger Handler and the Trigger apply the required strategy based on the type of the triggered change and the operation type resulting from the type fo the change.
- Pricing Strategy and Pricing Strategy Factory turns the pricing logic into a dynamically callable unit of code, where different pricing logics can be called in the future upon demand

## This granular setup of the functionality has the following advantages:
- All functionalities are separated and can be managed and changed on their own
- The Unit of Work pattern makes it possible to manage changes to the data in one step, making batch processing possible and adhering to governor limits easier
- The Strategy pattern makes it possible to separate the different change logics into individual classes that can be changed to incorporate future changes for each trigger type
- The Factory pattern makes it possible to dynamically enrich the choice of action based on the trigger type
- Pricing Strategy and Pricing Strategy Factory makes it possible to create various different pricing strategies - in order to do that new Pricing Strategy classes can be implemented which can be called from the Pricing Strategy Factory class based on pre-set pricing criteria.