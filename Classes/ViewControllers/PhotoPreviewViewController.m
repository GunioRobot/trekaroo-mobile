//
//  PhotoPreviewViewController.m
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoPreviewViewController.h"
#import "EngineDude.h"


@implementation PhotoPreviewViewController
@synthesize uiImage, uiImageView, captionField;

- (id)init:(UIImage*)inImage{
	if ((self = [super initWithNibName:nil bundle:nil])) {
		self.uiImage = inImage;
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

- (IBAction)sendPhotoAction:(id)sender {
	 [[EngineDude engineDude] uploadImage:(UIImage *)uiImage withCaption:(NSString *)captionField.text];
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
    [super dealloc];
}


@end
