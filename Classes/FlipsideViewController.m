//
//  FlipsideViewController.m
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 11/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate, customToolBar;

- (void)insertCoolLogo {
	UIImage *i = [UIImage imageNamed:@"treklogo"];
	UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0, 160.0, 30.0)] autorelease];
	iv.contentMode = UIViewContentModeScaleAspectFit;
	iv.backgroundColor = [UIColor clearColor];
	iv.opaque = NO;
	iv.image = i;
	UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:iv] autorelease];
	NSMutableArray *items = [NSMutableArray arrayWithArray:[customToolBar items]];
	[items insertObject:item atIndex:2];
	[customToolBar setItems:items];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];    
//	[self insertCoolLogo];
	
}

- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.customToolBar = nil;
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
{
	switch (result) {
		case MFMailComposeResultFailed:	
		{
			// maybe alert user
			
			break;
		}
		case MFMailComposeResultCancelled:	
			break;
		case MFMailComposeResultSaved:	
			break;
		case MFMailComposeResultSent:	
		default:
			break;
			
	}
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)sendEmailAction:(id)sender {
	MFMailComposeViewController *mailGuy = [[[MFMailComposeViewController alloc] init] autorelease];
	mailGuy.mailComposeDelegate = self;
	[mailGuy setToRecipients:[NSArray arrayWithObject:@"info@trekaroo.com"]];
	[mailGuy setSubject:@"Trekaroo iPhone Feedback"];
//	if (body) [mailGuy setMessageBody:@" isHTML:isHTML];
	[self presentModalViewController:mailGuy animated:YES];
}

- (IBAction)goToNonMobileTrekarooSite:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.trekaroo.com?mobile=false"]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
