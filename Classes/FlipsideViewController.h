//
//  FlipsideViewController.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 11/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
	UIToolbar *customToolBar;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIToolbar *customToolBar;
- (IBAction)done:(id)sender;
@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

