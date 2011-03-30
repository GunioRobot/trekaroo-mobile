//
//  MainViewController.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 11/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import <Foundation/Foundation.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIWebViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	UIWebView *webView;
	UIImagePickerController *imgPicker;
	
}

@property (nonatomic,retain)IBOutlet UIWebView *webView;
@property (nonatomic, retain) UIImagePickerController *imgPicker;

- (IBAction)showInfo:(id)sender;
- (void) sendJSCommandToBrowser: (NSString*)command;


@end
