## Documentation - Offline 4

### Problem 1 - Observer Pattern

1. Start Server first and then Client.
2. Client Commands-

    Subscribe to a stock:	`S <stock_name>` <br>
	Unsubscribe from a stock: `U <stock_name>` <br>
	
3. Admin/Server Commands-

	Increase stock price: `I <stock_name> <new_price>` <br>
	Decrease stock price: `D <stock_name> <new_price>` <br>
	Change stock count: `C <stock_name> <number_of_stock_to_add>` <br> 
	Print list of current stocks: `P` 


### Problem 2 - Mediator Pattern

1. Simple Request command - `<customer_name> <service_name>` <br>
	Eg. `JWSA POWER`	(JWSA requests Power) <br>

2. Simple Serve Command - <provider_name> SERVE <br>
	Eg. `JPDC SERVE` (JPDC will server POWER to those waiting in their queue) <br>
		
