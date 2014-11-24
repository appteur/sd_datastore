//
//  ViewController.h
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStoreProtocol.h"

@interface ViewController : UIViewController

@property (nonatomic) id<DataStoreProtocol> dataStore;


@end

