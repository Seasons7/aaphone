//
//  AAPhoneAppDelegate.h
//  AAPhone
//
//  Created by mootoh on 5/2/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AAPhoneViewController;

@interface AAPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AAPhoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AAPhoneViewController *viewController;

@end

