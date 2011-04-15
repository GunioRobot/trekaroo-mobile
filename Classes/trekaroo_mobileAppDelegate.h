//
//  trekaroo_mobileAppDelegate.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 11/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface trekaroo_mobileAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

#define MAIN_VIEW_CONTROLLER ([(trekaroo_mobileAppDelegate *)[[UIApplication sharedApplication] delegate] mainViewController])
@end

