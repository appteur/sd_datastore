//
//  NSManagedObjectContext+Extensions.m
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "NSManagedObjectContext+Extensions.h"
#import "NSFetchRequest+Extensions.h"

@implementation NSManagedObjectContext (Extensions)



-(NSArray*) allObjectsOfType:(NSString*)entityName
{
    if (! entityName) { return nil;  }
    
    // create a fetch request for all entities specified
    NSFetchRequest *request = [NSFetchRequest requestForEntity:entityName inContext:self];
    
    // run the request and return it
    return [self performRequest:request];
}


-(NSArray*) allObjectsOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate
{
    // create a fetch request for the entity with a predicate set
    NSFetchRequest *request = [NSFetchRequest requestForEntity:entityName inContext:self withPredicate:predicate];
    
    // run the request and return it
    return [self performRequest:request];
}


-(id) newEntityOfType:(NSString *)entityType
{
    // create a new object of the given entity type in this context
    return [NSEntityDescription insertNewObjectForEntityForName:entityType inManagedObjectContext:self];
}


-(id) uniqueEntityOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate
{
    // get all entities matching the predicate
    NSArray *entities = [self allObjectsOfType:entityName matchingPredicate:predicate];
    
    // if we have a result grab it, otherwise create and return a new empty one
    id entity = (entities.count > 0) ? entities[0] : [self newEntityOfType:entityName];
    
    return entity;
}


-(void) updateAttribute:(NSString*)attribute withValue:(id)value onEntity:(NSString*)entityType matchingPredicate:(NSPredicate*)predicate
{
    id entity = [self uniqueEntityOfType:entityType matchingPredicate:predicate];
    
    @try
    {
        [entity setValue:value forKey:attribute];
    }
    @catch (NSException *exception)
    {
#ifdef  DEBUG
        NSLog(@"Error updating attribute on entity: %@", exception.userInfo);
#endif
    }

}


-(id) uniqueEntityOrNilOfType:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate
{
    // get all entities matching the predicate
    NSArray *entities = [self allObjectsOfType:entityName matchingPredicate:predicate];
    
    // if we have a result grab it, otherwise create and return a new empty one
    id entity = (entities.count > 0) ? entities[0] : nil;
    
    return entity;
}


-(void) deleteEntityOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate
{
    // get any entities matching the predicate
    NSArray *entities = [self allObjectsOfType:entityName matchingPredicate:predicate];
    
    // enumerate and delete them
    [entities enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        [self deleteObject:obj];
    }];
}

-(void) deleteAllEntitiesOfType:(NSString *)entityType
{
    // fetch all entities of this type
    NSArray *entities = [self allObjectsOfType:entityType];
    
    // enumerate and delete them
    [entities enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         [self deleteObject:obj];
     }];
}


// performs a given fetch request on itself
-(NSArray*) performRequest:(NSFetchRequest*)request
{
    NSError *error   = nil;
    NSArray *results = [self executeFetchRequest:request error:&error];
    
    if (error)
    {
#ifdef DEBUG
        NSLog(@"Error performing fetch for entity: %@", error.userInfo);
#endif
    }
    
    return results;
}


-(NSManagedObject*) localInstanceOfObject:(NSManagedObject *)object
{
    // create a reference to a return object
    NSManagedObject *aReturnVal = nil;
    
    // if we're dealing with an actual managed object
    if (object && [object isKindOfClass:[NSManagedObject class]])
    {
        // if we already have an instance of this object in this context
        if ([self objectRegisteredForID:[object objectID]])
        {
            // set our return value
            aReturnVal = object;
        }
        else
        {
            // otherwise create an object in this context of this entity type
            aReturnVal = [[NSManagedObject alloc] initWithEntity:[object entity] insertIntoManagedObjectContext:self];
            
            // run through all the attributes of the received object and set the values on the new one
            [[[[object entity] attributesByName] allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
             {
                 // the value of the entity attribute
                 id anObject = [object valueForKey:key];
                 
                 if (anObject)
                 {
                     // we actually have a value so pass it to the new object
                     [aReturnVal setValue:anObject forKey:key];
                 }
             }];
        }
    }
    
    // return our new object
    return aReturnVal;
}



@end
