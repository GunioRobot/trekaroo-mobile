//
//  MainViewController.m
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 11/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import	"PhotoPreviewViewController.h"
#import "EngineDude.h"

@implementation MainViewController
@synthesize webView, backItem, forwardItem, customToolBar;

- (void)updateButtons {
	backItem.enabled = [webView canGoBack];
	forwardItem.enabled  = [webView canGoForward];
}

- (void)insertCoolLogo {
	UIImage *i = [UIImage imageNamed:@"treklogo"];
	UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0, 160.0, 30.0)] autorelease];
	iv.contentMode = UIViewContentModeScaleAspectFit;
	iv.backgroundColor = [UIColor clearColor];
	iv.opaque = NO;
	iv.image = i;
	UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:iv] autorelease];
	NSMutableArray *items = [NSMutableArray arrayWithArray:[customToolBar items]];
	[items replaceObjectAtIndex:3 withObject:item];
	[customToolBar setItems:items];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[EngineDude engineDude];
	[webView setDelegate:self];
#warning : Consider loading a local webpage
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:TREKAROO_MOBILE_URL]]];
	// direct to a poi for testing
	//	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000/mobile/poi/filters?filter=Activity&lat=35.0914383&lng=-106.6040776#/mobile/activities/show/explora-childrens-museum-albuquerque-new-mexico?filter=Everything&lat=35.0914383&lng=-106.6040776"]]];
	
	self.imgPicker = [[UIImagePickerController alloc] init];
	self.imgPicker.delegate = self;	
	[self updateButtons];
	[self insertCoolLogo];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.backItem = nil;
	self.forwardItem = nil;
	self.webView.delegate = nil;
	self.customToolBar = nil;
	self.webView = nil;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	NSString *url = [[request URL] absoluteString];
	
	NSArray *urlArray = [url componentsSeparatedByString:@"?"];
	NSString *cmd = @"";
	NSMutableArray *paramsToPass = nil;
	if([urlArray count] > 1){
		NSString *paramsString = [urlArray objectAtIndex:1];
		NSArray *urlParamsArray = [paramsString componentsSeparatedByString:@"&"];
		cmd = [[[urlParamsArray objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1];
		int numCommands = [urlParamsArray count];
		paramsToPass = [[NSMutableArray alloc] initWithCapacity:numCommands-1];
		for(int i = 1; i < numCommands; i++){
			NSString *aParam = [[[urlParamsArray objectAtIndex:i] componentsSeparatedByString:@"="] objectAtIndex:1];
			
			
			[paramsToPass addObject:aParam];
		}
	}
	NSLog(@"JSURL: %@",url);
	if([cmd compare:@"choosePhoto"] == NSOrderedSame){
		//[locationManager startUpdatingLocation];
		[self presentModalViewController:self.imgPicker animated:YES];
	}
	else if([cmd compare:@"takePhoto"] == NSOrderedSame){
		//[locationManager startUpdatingLocation];
	}
	else if([cmd compare:@"logMessage"] == NSOrderedSame){
		NSString *message = [[paramsToPass objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"JSMessage: %@",message);
	}
	/*
	 *	Only load the page if it is the initial index.html file
	 */
	
	NSRange aSubStringRange = [url rangeOfString:@"iPhoneCommand"];
	if(aSubStringRange.length != 0){
		return NO;
	}
	else{
		return YES;
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSString *jsCommand = @"Trekaroo.Mobile.setIOS();";
	[self.webView stringByEvaluatingJavaScriptFromString:jsCommand];
	[self updateButtons];
}

- (void) sendJSCommandToBrowser: (NSString*)command {
	[self.webView stringByEvaluatingJavaScriptFromString:command];
}

@synthesize imgPicker;

- (void)reallyShowPhotoPreview:(PhotoPreviewViewController *)pp {
    [self presentModalViewController:pp animated:YES];
	[pp release]; // this matches init below
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	PhotoPreviewViewController *photoViewController = [[PhotoPreviewViewController alloc]init:img];
	[self performSelector:@selector(reallyShowPhotoPreview:) withObject:photoViewController afterDelay:0.5];
//	[self presentModalViewController:[photoViewController animated:YES]];
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
	webView.delegate = nil;
	
	[webView release];
    [super dealloc];
}

- (void)requestFailed:(NSString *)identifier withError:(NSError *)error {
	
}

- (void)requestSucceeded:(NSString *)identifier {
	
}



@end
