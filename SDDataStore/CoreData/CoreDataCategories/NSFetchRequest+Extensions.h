//
//  NSFetchRequest+Extensions.h
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchRequest (Extensions)

+(NSFetchRequest*) requestForEntity:(NSString*)className inContext:(NSManagedObjectContext*)ctx;

/*!
 *  Creates a fetch request and sets the entity, context and predicate if provided.
 *
 *  @param className The name of the entity the fetch is being executed for.
 *  @param ctx       The context to perform the fetch in.
 *  @param predicate A predicate string or nil. If a string is provided using variable substitution be sure to quote the variable. 
                        EX. @"SELF beginsWith '%@'".
 *
 *  @return Returns an instance of NSFetchRequest.
 */
+(NSFetchRequest*) requestForEntity:(NSString*)className inContext:(NSManagedObjectContext*)ctx withPredicateString:(NSString*)predicate;




+(NSFetchRequest*) requestForEntity:(NSString *)className inContext:(NSManagedObjectContext *)ctx withPredicate:(NSPredicate *)predicate;



@end
