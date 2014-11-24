//
//  DataStoreProtocol.h
//  SDDataStore
//
//  Created by Seth on 11/5/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SDDataStoreTypeDictionary,
    SDDataStoreTypeArray,
    SDDataStoreTypeEntity
}SDDataStoreType;

@class User;

/*!
 *  This is the interface that defines the methods that SDCoreDataInterface implements to provide data to the app. 
 */
@protocol SDDataStoreProtocol <NSObject>

-(User*) userWithIdentifier:(NSString*)userId;

-(void) updateAvatar:(NSString*)newURL forUserId:(NSString*)userId;
-(void) deleteChildWithId:(NSString*)childId;
-(void) deleteAllObjectsOfType:(NSString *)entityName;
-(void) saveUsers:(NSArray*)accounts;

-(NSDictionary*) userInfoFromUserId:(NSString*)userId;


@end
