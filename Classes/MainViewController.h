//
//  MainViewController.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 11/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIWebViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate> {
	UIWebView *webView;
	UIImagePickerController *imgPicker;
	UIToolbar *customToolBar;
	UIBarButtonItem *backItem;
	UIBarButtonItem *forwardItem;
	NSMutableDictionary *photoPostOptions;
	CLLocationManager *locationManager;
	BOOL _lastImageWasSnapshot;
	BOOL _hasBeenLoaded;
	BOOL _respondedToError;
	double _latitude;
	double _longitude;
}

@property (nonatomic,retain) NSMutableDictionary *photoPostOptions;
@property (nonatomic,retain) IBOutlet UIWebView *webView;
@property (nonatomic,retain) IBOutlet UIToolbar *customToolBar;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *backItem;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *forwardItem;
@property (nonatomic, retain) UIImagePickerController *imgPicker;

- (IBAction)showInfo;
- (void) sendJSCommandToBrowser: (NSString*)command;

#define STAGING_URL @"http://stg2.trekaroo.com/mobile"

- (void)requestFailed:(NSString *)identifier withError:(NSError *)error;
- (void)requestSucceeded:(NSString *)identifier;
	
@end
