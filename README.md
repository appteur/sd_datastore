# sd_datastore

This project is an experiement with using CoreData in iOS.

I added some categories on NSFetchRequest, NSManagedObject & NSManagedObjectContext.

It seemed like I was using a lot of repeated code in my core data interface classes so this was an attempt to reduce some of the repetition by extracting it into some categories.

The NSManagedObject category has some convenience methods to dynamically populate an NSManagedObject's properties from a dictionary, as well as create a dictionary from a core data entity. It also has a method to create a local instance of itself in a given context. (It seems I found this one somewhere online, but I don't remember where).

The NSFetchRequest category takes a lot of code I kept duplicating and condenses it into one place so I could do the same operations with only one method call instead of multiple lines.

The NSManagedObjectContext category also takes a lot of repetitive code and simplifies it so you can use one line instead of many. It also allows for easier nil checks.

The SDCoreDataInterface class is the class I would call for all of my access to the data stored in CoreData throughout the app. I added an SDDataStoreProtocol to access CoreData with in case I wanted to swap CoreData out for some other storage in the future. 


There are also some other un-related classes in the project that will be removed in the future. It just seemed like a good place to keep them for the moment.


This was a test project I put together to run through some ideas for better organization. It's not entirely complete but you may get some good ideas or provide some good ideas from looking through it.