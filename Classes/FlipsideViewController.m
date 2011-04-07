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
