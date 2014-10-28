//
//  NSManagedObject+Extensions.m
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "NSManagedObjectContext+Extensions.h"
#import "NSManagedObject+Extensions.h"
#import "NSObject+Extensions.h"

@implementation NSManagedObject (Extensions)




-(NSDictionary*) toDictionary
{
    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionary];
    
    // run through all the attributes of the received object and set the values on the new one
    [[[[self entity] attributesByName] allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         // the value of the entity attribute
         id anObject = [self valueForKey:key];
         
         if (anObject)
         {
             // we actually have a value so pass it to the new object
             [returnDictionary setValue:anObject forKey:key];
         }
     }];
    
    return returnDictionary;
}


-(NSManagedObject*) localInstanceInContext:(NSManagedObjectContext *)context
{
    return [context localInstanceOfObject:self];
}






@end
