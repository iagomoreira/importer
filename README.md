## The problem
We needed to import data like transactions, items, categories and products from a point of sales API because they didn't provide webhooks for that kind of data.
But we wanted to make it easy to be extended, so it would be very simple to add new data to be imported with the others.

In order to do that, the solution I provided was to create a BaseImporter (AbstractClass) to deal with all the rules for importing data in general, and then each class that implements the BaseImporter will need to provide only the data that needs to be imported, and by doing that way, there was no need to implement any logic if we want to import other data.

Also, a Epos::Client class was implemented to communicate with the API.

The models are simple and have only the attributes in most cases, so I didn't put it here.
