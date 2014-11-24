//
//  NSManagedObject+Extensions.h
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Extensions)


-(NSDictionary*) toDictionary;
-(void) loadFromDictionary:(NSDictionary*)dictionary;
-(NSManagedObject*) localInstanceInContext:(NSManagedObjectContext *)context;



@end
