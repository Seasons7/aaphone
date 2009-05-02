//
//  AAPhoneAppDelegate.m
//  AAPhone
//
//  Created by mootoh on 5/2/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "AAPhoneAppDelegate.h"
#import "AAPhoneViewController.h"

@implementation AAPhoneAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
