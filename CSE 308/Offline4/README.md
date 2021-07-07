## Documentation - Offline 4

### Problem 1 - Observer Pattern

1. Start Server first and then Client.
2. Client Commands-

    Subscribe to a stock:	`S <stock_name>`
	Unsubscribe from a stock: `U <stock_name>`
	
3. Admin/Server Commands-

	Increase stock price: `I <stock_name> <new_price>` 
	Decrease stock price: `D <stock_name> <new_price>` 
	Change stock count: `C <stock_name> <number_of_stock_to_add>` 
	Print list of current stocks: `P` 


### Problem 2 - Mediator Pattern

1. Simple Request command - `<customer_name> <service_name>` 
	Eg. `JWSA POWER`	(JWSA requests Power)

2. Simple Serve Command - <provider_name> SERVE 
	Eg. `JPDC SERVE` (JPDC will server POWER to those waiting in their queue) 
		
