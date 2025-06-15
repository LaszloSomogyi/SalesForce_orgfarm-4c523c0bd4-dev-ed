Dear Arch,

I completed and deployed the first version of the Sales Order / Order Line Item management functionality that focuses on the update and handling of currency amounts on these two objects.
You can find the functionalities both on Github and in the Developer org.

I applied the Strategy, Factory and Unit of Work design patterns. 
Each of these patterns and all the other functionalities are divided into separate classes making it easier to separate responsibilities and making the solution open for future enhancements and extensions.
The calculation of the Total Amount value on the Sales Order happens in a separate Calculator class
Unit of Work --> commits changes to the database in a batch & governor limits friendly way.
Strategy classes --> calls the UOW for the appropriate change scenario
Factory class --> triggers the appropriate strategy class
TriggerHandler + Trigger --> calls the appropriate strategy based on the trigger type

I also added the first steps for developing a dynamic Pricing Strategy (IPricingStrategy, DefaultPricingStrategy, PricingStrategyFactory) --> This is called in the Calculator class, and based on this Pricing setup, various pricing strategies can be added dynamically in the future if needed. At the moment the DefaultPricingStrategy simply returns the current amount of the Order Line Item - this can be used as the base scenario in future enhancements.

The test class runs OK, and the I thoroughly tested the all the functionalities in the Developer org, as well.
I would be grateful if you could look at my solution and give me feedback on it

Best regards,

Laszlo