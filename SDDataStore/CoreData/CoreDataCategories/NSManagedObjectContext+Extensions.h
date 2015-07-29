//
//  NSManagedObjectContext+Extensions.h
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Extensions)


-(NSArray*) allObjectsOfType:(NSString*)entityName;

-(NSArray*) allObjectsOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate;

-(id) uniqueEntityOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate;

-(id) uniqueEntityOrNilOfType:(NSString *)entityName matchingPredicate:(NSPredicate *)predicate;

-(id) newEntityOfType:(NSString*)entityType;


-(void) updateAttribute:(NSString*)attribute withValue:(id)value onEntity:(NSString*)entityType matchingPredicate:(NSPredicate*)predicate;


-(void) deleteAllEntitiesOfType:(NSString*)entityType;

-(void) deleteEntityOfType:(NSString*)entityName matchingPredicate:(NSPredicate*)predicate;


-(NSManagedObject*) localInstanceOfObject:(NSManagedObject *)object;


@end
