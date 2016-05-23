//
//  SDCoreDataInterface.m
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "SDCoreDataInterface.h"
#import "SDCoreDataLayer.h"

//categories
#import "NSFetchRequest+Extensions.h"
#import "NSManagedObjectContext+Extensions.h"
#import "NSManagedObject+Extensions.h"
#import "NSObject+Extensions.h"

// entities
#import "CDUser.h"

// data classes
#import "User.h"

@interface SDCoreDataInterface()

@property (nonatomic, strong) SDCoreDataLayer *cdlayer;
@property (nonatomic, strong) NSManagedObjectContext *ctx;

@end

@implementation SDCoreDataInterface
@synthesize ctx;


-(instancetype) init
{
    if (self = [super init])
    {
        self.cdlayer = [SDCoreDataLayer singleton];
        self.ctx = self.cdlayer.managedObjectContext;
    }
    return self;
}


#pragma mark -- Class Convenience Methods
/***************************************************************************************************************************/

// retrieves and returns an entity or dictionary version of entity
-(id)retrieveEntity:(NSString*)entityName withIdentifier:(NSString*)identifier returnType:(SDDataStoreType)type
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@", identifier];
    
    // get a reference to the cached result or nil
    NSManagedObject *entity = [ctx uniqueEntityOfType:entityName matchingPredicate:predicate];
    
    // return our object or dictionary representation
    return type == SDDataStoreTypeEntity ? entity : [entity toDictionary];
    
}

-(id) entityOfType:(NSString*)type matchingPredicateString:(NSString*)predicateString
{
    id entity = [ctx uniqueEntityOfType:type matchingPredicate:[NSPredicate predicateWithFormat:predicateString]];
    
    return entity;
}

-(void) deleteAllObjectsOfType:(NSString *)entityName
{
    [ctx deleteAllEntitiesOfType:entityName];
    
    [self.cdlayer saveContext];
}




#pragma mark -- SDDataStoreProtocol Access methods
/***************************************************************************************************************************/

-(CDUser*) cdUserWithIdentifier:(NSString*)userId
{
    id user = [ctx uniqueEntityOfType:@"CDUser" matchingPredicate:[NSPredicate predicateWithFormat:@"id == %@", userId]];
    
    return user;
}

-(User*) userWithIdentifier:(NSString *)userId
{
    CDUser *user = [self cdUserWithIdentifier:userId];
    
    return [user toUser];
}

-(NSDictionary*) userInfoFromUserId:(NSString*)userId
{
    NSManagedObject *obj = [ctx uniqueEntityOrNilOfType:@"CDUser" matchingPredicate:[NSPredicate predicateWithFormat:@"id == %@", userId]];
    
    return [obj toDictionary];
}


-(void) updateAvatar:(NSString*)newURL forUserId:(NSString*)userId
{
    [ctx updateAttribute:@"avatar" withValue:newURL onEntity:@"CDUser" matchingPredicate:[NSPredicate predicateWithFormat:@"id == %@", userId]];
    
    [self.cdlayer saveContext];
}


-(void) deleteChildWithId:(NSString*)childId
{
    [ctx deleteEntityOfType:@"CDUser" matchingPredicate:[NSPredicate predicateWithFormat:@"id == '%@'", childId]];
    
    [self.cdlayer saveContext];
}

// takes an array of account info dictionaries
-(void) saveUsers:(NSArray*)accounts
{
    // bail if accounts is nil
    if (! accounts) {   return; }
   
    // create or update any stored accounts
    [accounts enumerateObjectsUsingBlock:^(NSDictionary *acctInfo, NSUInteger idx, BOOL *stop)
        {
            // create new user or fetch if one exists
            CDUser *user = [self cdUserWithIdentifier:acctInfo[@"id"]];
            
            // populate the entity properties from the dictionary
            [user loadFromDictionary:acctInfo];
        }];
   
    // save our changes
    [self.cdlayer saveContext];
   
    // fire a notification with the current user info
    NSNotification *note = [NSNotification notificationWithName:@"CDUsersDidSaveNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:note waitUntilDone:YES];
    
}








@end
