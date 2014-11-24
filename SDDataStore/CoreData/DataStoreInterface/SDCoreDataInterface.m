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


-(User*) userWithIdentifier:(NSString*)userId
{
    id user = [ctx uniqueEntityOfType:@"User" matchingPredicate:[NSPredicate predicateWithFormat:@"userId == %@", userId]];
    
    return user;
}


-(NSDictionary*) userInfoFromUserId:(NSString*)userId
{
    NSManagedObject *obj = [ctx uniqueEntityOrNilOfType:@"User" matchingPredicate:[NSPredicate predicateWithFormat:@"userId == %@", userId]];
    
    return [obj toDictionary];
}


-(void) updateAvatar:(NSString*)newURL forUserId:(NSString*)userId
{
    [ctx updateAttribute:@"avatar" withValue:newURL onEntity:@"User" matchingPredicate:[NSPredicate predicateWithFormat:@"userId == %@", userId]];
    
    [self.cdlayer saveContext];
}


-(void) deleteChildWithId:(NSString*)childId
{
    [ctx deleteEntityOfType:@"User" matchingPredicate:[NSPredicate predicateWithFormat:@"userId == '%@'", childId]];
    
    [self.cdlayer saveContext];
}


-(void) deleteAllObjectsOfType:(NSString *)entityName
{
    [ctx deleteAllEntitiesOfType:entityName];
    
    [self.cdlayer saveContext];
}



@end
