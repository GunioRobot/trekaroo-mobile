//
//  PhotoPreviewViewController.m
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoPreviewViewController.h"
#import "EngineDude.h"
#import "MainViewController.h"

@implementation PhotoPreviewViewController
@synthesize uiImage, uiImageView, captionField, photoOptions;

- (id)init:(UIImage*)inImage options:(NSMutableDictionary *)options {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		self.uiImage = inImage;
		self.photoOptions = options;
	}
	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (IBAction)cancelAction:(id)sender {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
	[(MainViewController *)[self parentViewController] sendJSCommandToBrowser:@"alert(\'dialog closed\');"];	
}

- (void)nowSendPhoto {
	[[EngineDude engineDude] uploadImage:(UIImage *)uiImage withCaption:(NSString *)captionField.text andOptions:photoOptions];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendPhotoAction:(id)sender {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	// must be asynch to line above!
	[self performSelector:@selector(nowSendPhoto) withObject:nil afterDelay:0.0];
	
//	[[EngineDude engineDude] uploadImage:(UIImage *)uiImage withCaption:(NSString *)captionField.text andOptions:photoOptions];
//	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	if(self.uiImageView){
		[self.uiImageView setImage:self.uiImage];
	}
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
	[textField resignFirstResponder];
	return NO;
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.uiImageView = nil;
	self.captionField = nil;
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[uiImage release];
	[uiImageView release];
	[captionField release];
	[photoOptions release];
    [super dealloc];
}


@end
