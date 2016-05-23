//
//  CDUser.m
//  SDDataStore
//
//  Created by Seth on 11/24/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "CDUser.h"
#import "User.h"


@implementation CDUser

@dynamic xid;
@dynamic fname;
@dynamic lname;




-(User*) toUser
{
    User *convertedUser = [[User alloc] init];
    
    // run through all the attributes of the received object and set the values on the new one
    [[[[self entity] attributesByName] allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         // the value of the entity attribute
         id anObject = [self valueForKey:key];
         
         if (anObject)
         {
             @try
             {
                 // we actually have a value so pass it to the new object
                 [convertedUser setValue:anObject forKey:key];
             }
             @catch (NSException *exception)
             {
                 NSLog(@"User conversion -- Failed to set value: [%@] for key[%@]", anObject, key);
             }
             
         }
     }];
    
    return convertedUser;
}




@end
