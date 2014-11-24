//
//  NSFetchRequest+Extensions.m
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "NSFetchRequest+Extensions.h"

@implementation NSFetchRequest (Extensions)





+(NSFetchRequest*) requestForEntity:(NSString*)className inContext:(NSManagedObjectContext*)ctx
{
    // setup our fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    // initialize our entity description
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:ctx];
    
    // set the entity
    [request setEntity:entity];
    
    return request;
}


+(NSFetchRequest*) requestForEntity:(NSString *)className inContext:(NSManagedObjectContext *)ctx withPredicateString:(NSString *)predicate
{
    // setup our fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    // initialize our entity description
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:ctx];
    
    // set the entity
    [request setEntity:entity];
    
    if (predicate)
    {
        // setup our predicate to find our specific user
        NSPredicate *pred = [NSPredicate predicateWithFormat:predicate];
        
        // set the predicate
        [request setPredicate:pred];
    }
    
    
    return request;
}


+(NSFetchRequest*) requestForEntity:(NSString *)className inContext:(NSManagedObjectContext *)ctx withPredicate:(NSPredicate *)predicate
{
    // setup our fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    // initialize our entity description
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:ctx];
    
    // set the entity
    [request setEntity:entity];
    
    if (predicate)
    {
        // set the predicate
        [request setPredicate:predicate];
    }
    
    return request;
}


@end
