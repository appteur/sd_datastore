//
//  NSObject+Extensions.m
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "NSObject+Extensions.h"

//For "Method" class
#import <objc/runtime.h>



@implementation NSObject (Extensions)




-(void) loadPropertiesFrom:(NSObject*)object
{
    // get all the property names from the received object
    NSArray *propertyNames = [object allPropertyNames];
    
    // run through the properties and try to load them from the received object
    [propertyNames enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
    {
        id value = [object valueForKey:key];
        
        @try
        {
            // try to set the value from the received object on self.
            [self setValue:value forKey:key];
        }
        @catch (NSException *exception)
        {
#ifdef DEBUG
            NSLog(@"Failed transfer value: [%@] forKey: [%@] from object: [%@] to object: [%@]", value, key, object, self);
#endif
        }

    }];
}




-(NSArray*) allPropertyNames
{
    NSMutableArray *propertyNamesArray = [NSMutableArray array];
    
    // setup counter at 0
    unsigned int count=0;
    
    // get our properties in a c array
    objc_property_t *props = class_copyPropertyList([self class],&count);
    
    for ( int i=0; i<count ;i++ )
    {
        // get the property name as a char
        const char *name = property_getName(props[i]);
        
        //        const char *attributes = property_getAttributes(props[i]);
        
        // convert to nsstring
        NSString *property = [NSString stringWithUTF8String:name];
        
        // add to our array
        [propertyNamesArray addObject:property];
        
        //        NSLog(@"property %d: %s -- %s",i,name,attributes);
    }
    
    return propertyNamesArray;
}






@end
