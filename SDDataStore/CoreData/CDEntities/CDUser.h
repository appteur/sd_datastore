//
//  CDUser.h
//  SDDataStore
//
//  Created by Seth on 11/24/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject+Extensions.h"

@class User;
@interface CDUser : NSManagedObject

@property (nonatomic, retain) NSNumber * xid;
@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * lname;



-(User*) toUser;


@end
