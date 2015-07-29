//
//  ViewController.m
//  SDDataStore
//
//  Created by Seth on 10/27/14.
//  Copyright (c) 2014 Seth. All rights reserved.
//

#import "ViewController.h"

#import "SDCoreDataInterface.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        // get a reference to our data store (maybe make a singleton?)
        self.dataStore = [[SDCoreDataInterface alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    User *currentUser = [self.dataStore userWithIdentifier:@"19"];
    
    // do something with user here
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
