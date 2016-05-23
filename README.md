# sd_datastore

##### Language
Objective-C


### Overview
This project is an experiement with using CoreData in iOS. This is a test project I put together to run through some ideas for better organization. It's not entirely complete but you may get some ideas from looking through it.

In my Core Data code it seemed like I was using a lot of repeated code so this was an attempt to reduce some of the repetition by pulling it out into some categories.


### Categories
In this project you'll find categories on NSFetchRequest, NSManagedObject & NSManagedObjectContext.

Below you'll find a summary of the methods added to each category.


#### NSManagedObject
The NSManagedObject category has some convenience methods to dynamically populate an NSManagedObject's properties from a dictionary, as well as create a dictionary from a core data entity. It also has a method to create a local instance of itself in a given context. (It seems I found this method somewhere online, I believe it was in a WWDC video from several years ago).

```objective-c

// converts an entity into a dictionary with property names as keys and property values as dictionary values
-(NSDictionary) toDictionary;

// tries to load a core data entity from a dictionary. Dictionary keys should be the same as entity properties.
-(void) loadFromDictionary:(NSDictionary*)dictionary;

// creates a copy of an entity in a specified context (from a WWDC video)
-(NSManagedObject*) localInstanceInContext:(NSManagedObjectContext*)context

```

#### NSFetchRequest
The NSFetchRequest category takes a lot of code I kept duplicating and condenses it into one place so I could do the same operations with only one method call instead of multiple lines.

```objective-c

// condenses several lines of boilerplate code into one method call
+(NSFetchRequest*) requestForEntity:(NSString*)className inContext:(NSManagedObjectContext*)ctx;

// condenses more boilerplate code into one method call, accepts a predicate string for fetching
+(NSFetchRequest*) requestForEntity:(NSString *)className inContext:(NSManagedObjectContext *)ctx withPredicateString:(NSString *)predicate;

// same as above specified method, but takes an instance of NSPredicate instead of a predicate string
+(NSFetchRequest*) requestForEntity:(NSString *)className inContext:(NSManagedObjectContext *)ctx withPredicate:(NSPredicate *)predicate;

```

#### NSManagedObjectContext
The NSManagedObjectContext category also takes a lot of repetitive code and simplifies it so you can use one line instead of many. It also allows for easier nil checks.

```objective-c

// fetches all objects of a specified type
-(NSArray*) allObjectsOfType:(NSString*)entityName;

// fetches objects of type matching a predicate
-(NSArray*) allObjectsOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate;

// creates a new entity of a given type in 'self' context
-(id) newEntityOfType:(NSString *)entityType;

// fetches an entity matching a predicate if one exists, if none exist it creates a new entity of the specified type
-(id) uniqueEntityOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate;

// fetches an entity matching a predicate and tries to update the specified attribute with a given value
-(void) updateAttribute:(NSString*)attribute withValue:(id)value onEntity:(NSString*)entityType matchingPredicate:(NSPredicate*)predicate;

// fetches an entity matching a predicate if it exists, if none exist it returns nil
-(id) uniqueEntityOrNilOfType:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate;

// fetches an entity matching a predicate and deletes it
-(void) deleteEntityOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate;

// fetches and deletes all stored entities of a given type
-(void) deleteAllEntitiesOfType:(NSString *)entityType;

// performs a given fetch request on itself. If the request fails it logs the error to the console
-(NSArray*) performRequest:(NSFetchRequest*)request;

// creates and returns a copy of a given object in 'self' context (from WWDC session)
-(NSManagedObject*) localInstanceOfObject:(NSManagedObject *)object;

```



#### Core Data Interface
The SDCoreDataInterface class is the class I call for all of my access to the data stored in CoreData throughout the app. I added an SDDataStoreProtocol to access CoreData with in case I wanted to swap CoreData out for some other storage in the future. 



#### Examples
Using the categories in this project really shortens the code you write for retrieving data.

Lets look at an example in which you have a core data entity of type 'CDUser'.

You can write a method to retrieve the stored CDUser data like this: 

```objective-c

// fetch a user given the user identifier as a string
-(CDUser*) cdUserWithIdentifier:(NSString*)userId
{
    // ask the context for the unique entity of a given type matching specified predicate
    id user = [ctx uniqueEntityOfType:@"CDUser" matchingPredicate:[NSPredicate predicateWithFormat:@"id == %@", userId]];

    return user;
}


// If you want to convert a core data entity into a dictionary you can do it with just a couple lines
-(NSDictionary*) userInfoFromUserId:(NSString*)userId
{
    NSManagedObject *obj = [ctx uniqueEntityOrNilOfType:@"CDUser" matchingPredicate:[NSPredicate predicateWithFormat:@"id == %@", userId]];

    return [obj toDictionary];
}


```


For more examples download the project and look at the SDCoreDataInterface.m file.
