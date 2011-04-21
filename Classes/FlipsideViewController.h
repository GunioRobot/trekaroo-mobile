//
//  FlipsideViewController.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 11/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>


@protocol FlipsideViewControllerDelegate;



@interface FlipsideViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	id <FlipsideViewControllerDelegate> delegate;
	UIToolbar *customToolBar;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIToolbar *customToolBar;

- (IBAction)done:(id)sender;
- (IBAction)sendEmailAction:(id)sender;
- (IBAction)goToNonMobileTrekarooSite:(id)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

