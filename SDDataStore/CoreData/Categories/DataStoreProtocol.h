//
//  DataStoreProtocol.h
//  SDDataStore
//
//  Created by Seth on 11/5/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataStoreProtocol <NSObject>

/*!
 *  All predicates with the name predicateString are of NSString type and MUST be setup with single quotes as in the example below:
    Example:
        NSString *pred = [NSString stringWithFormat:@"userId == '%@'",uid]; // (Note '' around %@)
 */




/*!
 *  This returns an entity matching the predicate string passed in. Note that the predicate string must have single quotes around the specifier. See example.
 *
 *  @param etype           String name of the desired entity.
 *  @param predicateString The predicate string to match in the search. See example for usage.
 *
 *  @return Returns an instance of the requested entity or nil.
    @code
        Usage:
            NSString *type = @"User";
            NSString *pred = [NSString stringWithFormat:@"userId == '%@'",uid]; // (Note '' around %@)
            User *user = (User*)[self.dataDelegate entityOfType:type matchingPredicateString:pred];

 */
-(id) entityOfType:(NSString*)etype matchingPredicateString:(NSString*)predicateString;

/*!
 *  Returns the attributes for a given entity as a dictionary of key-value pairs.
 *
 *  @param entity          The name of the entity desired. (NSString)
 *  @param predicateString The predicate specifying the entity to return.
 *
 *  @return Returns a dictionary of entity attributes with the entity attributes as the keys.
 */
-(NSDictionary*) dictionaryRepresentationOfEntity:(NSString*)entity matchingPredicateString:(NSString*)predicateString;

/*!
 *  Call this to get all entities matching the entity specified as dictionaries in an array. As an example if you called this with a "User" entity specified it would return all users as a dictionary of their attributes with attributes as key names.
 *
 *  @param entity The entity type desired.
 *
 *  @return An array of dictionary representations of the specified entity.
 */
-(NSArray*) dictionaryRepresentationOfEntitiesOfType:(NSString*)entity;

/*!
 *  Use this method to obtain all stored instances of a particular entity type.
 *
 *  @param etype The name of the entity type desired.
 *
 *  @return An array of the entity type specified or nil.
 */
-(NSArray*) allEntitiesOfType:(NSString*)etype;

/*!
 *  Use this method to delete a single instance of a particular entity.
 *
 *  @param etype           The entity name/type as a string.
 *  @param predicateString The predicate string specifying the entity to delete.
    @code
        Usage:
            NSString *type = @"User";
            NSString *pred = [NSString stringWithFormat:@"userId == '%@'",uid]; // (Note '' around %@)
            [self.dataDelegate deleteEntityOfType:type matchingPredicateString:pred];

 */
-(void) deleteEntityOfType:(NSString*)etype matchingPredicateString:(NSString*)predicateString;

/*!
 *  Use this method to completely remove all entities of a given class.
 *
 *  @param entity The entity of which all instances will be deleted.
 */
-(void) deleteAllEntitiesOfType:(NSString*)entity;

/*!
 *  Use this method to update a single attribute on an entity matching the predicate string.
 *
 *  @param value           The object to set on the entity for the attribute specified.
 *  @param attributeName   The name of the attribute on the entity.
 *  @param entity          The name of the entity on which to find the attribute.
 *  @param predicateString The predicate specifying which entities to update.
 */
-(void) setValue:(id)value forAttribute:(NSString*)attributeName onEntity:(NSString*)entity matchingPredicateString:(NSString*)predicateString;




@end
