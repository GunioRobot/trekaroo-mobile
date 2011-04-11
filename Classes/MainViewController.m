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

#if defined(DEBUG)
@interface NSURLRequest(extraspecial)
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString *)host;
@end


#endif

@implementation MainViewController
@synthesize webView, backItem, forwardItem, customToolBar, photoPostOptions;

- (void)updateButtons {
	backItem.enabled = [webView canGoBack];
	forwardItem.enabled  = [webView canGoForward];
}

- (void)hideToolbar:(BOOL)hide {
//	CGRect b = [self.view bounds];
//	CGRect tr = customToolBar.frame;
//	CGRect wr = hide ? b : CGRectMake(0.0,tr.size.height, b.size.width, b.size.height - tr.size.height);
//	tr.origin.y = hide ? -tr.size.height : 0.0;
//	[UIView beginAnimations:@"showhide" context:nil];
//	webView.frame = wr;
//	customToolBar.frame = tr;
//	[UIView commitAnimations];
}

- (void)goHome:(id)xender {
//	[self loadLocalHomePage];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:TREKAROO_MOBILE_URL]]];
}

- (void)insertCoolLogo {
//	UIImage *i = [UIImage imageNamed:@"treklogo"];
//	UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0, 160.0, 30.0)] autorelease];
//	iv.contentMode = UIViewContentModeScaleAspectFit;
//	iv.backgroundColor = [UIColor clearColor];
//	iv.opaque = NO;
//	iv.image = i;
	UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
	b.frame = CGRectMake(0.0,0.0, 160.0, 30.0);
	[b addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
//	[b setImage:i forState:UIControlStateNormal];
	b.showsTouchWhenHighlighted = YES;
	b.backgroundColor = [UIColor clearColor];
	b.opaque = NO;
	
	UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:b] autorelease];
	NSMutableArray *items = [NSMutableArray arrayWithArray:[customToolBar items]];
	[items insertObject:item atIndex:2];
//	[items replaceObjectAtIndex:3 withObject:item];
	[customToolBar setItems:items];
	
}

- (void)loadLocalHomePage {
	NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"localwebcache"] stringByAppendingPathComponent:TREKAROO_INDEX_FILE];
	NSURL *url = [NSURL fileURLWithPath:path];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
// this code can only be used in debug builds:
#warning THIS MAY NOT GO INTO APPSTORE ONE
//#if defined(DEBUG)
	[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"stg2.trekaroo.com"];
//#endif
	
	[super viewDidLoad];
	[EngineDude engineDude];
	[webView setDelegate:self];
	webView.scalesPageToFit = YES;
	
	[self hideToolbar:YES];
	[self loadLocalHomePage];
	// direct to a poi for testing
	//	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000/mobile/poi/filters?filter=Activity&lat=35.0914383&lng=-106.6040776#/mobile/activities/show/explora-childrens-museum-albuquerque-new-mexico?filter=Everything&lat=35.0914383&lng=-106.6040776"]]];
	
//	self.imgPicker = [[UIImagePickerController alloc] init];
//	self.imgPicker.delegate = self;	
//	[self updateButtons];
//	[self insertCoolLogo];
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

- (BOOL)startCameraPickerFromViewController:(UIViewController*)controller usingDelegate:(id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)delegateObject
									 source:(UIImagePickerControllerSourceType)source
{
    if ( (![UIImagePickerController isSourceTypeAvailable:source]))
		source = UIImagePickerControllerSourceTypeSavedPhotosAlbum;  // fallback if none available
	
	if ( (![UIImagePickerController isSourceTypeAvailable:source])       || (delegateObject == nil) || (controller == nil))
        return NO;
	
    UIImagePickerController* picker = [[[UIImagePickerController alloc] init] autorelease];
	_lastImageWasSnapshot = (source == UIImagePickerControllerSourceTypeCamera);

	picker.sourceType = source;
    picker.delegate =  delegateObject;
	picker.allowsEditing = YES;
	[controller presentModalViewController:picker animated:YES];
    return YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	NSString *url = [[request URL] absoluteString];
	
	NSLog(@"JSURL: %@",url);
//	BOOL shouldHide = [url isEqualToString:TREKAROO_MOBILE_URL] ||
//	([[request URL] isFileURL] && [[url lastPathComponent] isEqualToString:@TREKAROO_INDEX_FILE]);
//	[self hideToolbar:shouldHide];
//	NSString *s = [NSString stringWithContentsOfURL:[request URL]];
//	NSLog(s);
	
	NSArray *urlArray = [url componentsSeparatedByString:@"?"];
	NSString *cmd = @"";
	NSMutableArray *paramsToPass = nil;
	if([urlArray count] > 1){
		NSString *paramsString = [urlArray objectAtIndex:1];
		NSArray *urlParamsArray = [paramsString componentsSeparatedByString:@"&"];
		cmd = [[[urlParamsArray objectAtIndex:0] componentsSeparatedByString:@"="] objectAtIndex:1];
		int numCommands = [urlParamsArray count];
		paramsToPass = [NSMutableArray arrayWithCapacity:numCommands-1];
		for(int i = 1; i < numCommands; i++){
			NSString *aParam = [[[urlParamsArray objectAtIndex:i] componentsSeparatedByString:@"="] objectAtIndex:1];
			
			
			[paramsToPass addObject:aParam];
		}
	}
	
	
	if([cmd compare:@"choosePhoto"] == NSOrderedSame){
		self.photoPostOptions = [[EngineDude engineDude] keysAndValuePairsFromURLString:url];
		[self startCameraPickerFromViewController:self usingDelegate:self source:UIImagePickerControllerSourceTypePhotoLibrary];
	}
	else if([cmd compare:@"takePhoto"] == NSOrderedSame){
		self.photoPostOptions = [[EngineDude engineDude] keysAndValuePairsFromURLString:url];
		[self startCameraPickerFromViewController:self usingDelegate:self source:UIImagePickerControllerSourceTypeCamera];
	}
	else if([cmd compare:@"networkIndicateYes"] == NSOrderedSame){
		UIApplication* app = [UIApplication sharedApplication];
//		app.networkActivityIndicatorVisible = YES;
	}	
	else if([cmd compare:@"networkIndicateNo"] == NSOrderedSame){
		UIApplication* app = [UIApplication sharedApplication];
//		app.networkActivityIndicatorVisible = NO;
	}		
	else if([cmd compare:@"gotoExternalUrl"] == NSOrderedSame){
		NSString *urlText = [[paramsToPass objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
			NSLog(@"gotoExternalUrl: %@",urlText);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
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
		UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;	
		NSLog(@"turning it ON");
		return YES;
	}
}

- (void)avoidFlashLater {
//	[UIView beginAnimations:nil context:NULL];
	webView.alpha = 1.0;
//	[UIView commitAnimations];
}

- (void)reallyLoadFirstPage {
	if (!_hasBeenLoaded) {
		_hasBeenLoaded = YES;
		[self performSelector:@selector(avoidFlashLater) withObject:nil afterDelay:0.4];
//		NSLog(TREKAROO_MOBILE_URL);
//		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:TREKAROO_MOBILE_URL]]];
	}
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	if (!_hasBeenLoaded) [self reallyLoadFirstPage];
	UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;	
	NSLog(@"turning it OFF");

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;	
	NSLog(@"turning it OFF");

	if (!_hasBeenLoaded) [self reallyLoadFirstPage];

	NSString *jsCommand = @"setIOSMobileApp();";
	[self.webView stringByEvaluatingJavaScriptFromString:jsCommand];
//	[self updateButtons];
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
	PhotoPreviewViewController *photoViewController = [[PhotoPreviewViewController alloc]init:img options:photoPostOptions];
	
	[self performSelector:@selector(reallyShowPhotoPreview:) withObject:photoViewController afterDelay:0.7];
	
	if (img && _lastImageWasSnapshot) {
		_lastImageWasSnapshot = NO;
		UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
		
	}
//	[self presentModalViewController:[photoViewController animated:YES]];
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
}


- (void)dealloc {
	webView.delegate = nil;
	
	[webView release];
    [super dealloc];
}

#define REQUEST_FAIL_TAG 55
#define REQUEST_SUCCEED_TAG 56

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation 
{
	if (alertView.tag == REQUEST_FAIL_TAG) {
		
	} else if (alertView.tag == REQUEST_SUCCEED_TAG) {
		
	}
}

- (void)requestFailed:(NSString *)identifier withError:(NSError *)error {
	if (0) {
		UIAlertView *v = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Photo Upload",@"") message:NSLocalizedString(@"Could not upload photo at this this. Please try later.",@"")
												   delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK",@""),nil];
		
		v.tag = REQUEST_FAIL_TAG;
		[v show];
		[v release];
	} else {
		[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"photoUploadFailed(%d);",[identifier intValue]]];
		NSLog([error localizedDescription]);
	}
}

- (void)requestSucceeded:(NSString *)identifier {
	if (0) {
		UIAlertView *v = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Photo Uploaded",@"") message:NSLocalizedString(@"Thank you.",@"")
												   delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK",@""),nil];
		
		v.tag = REQUEST_SUCCEED_TAG;
		[webView reload];
		[v show];
		[v release];
	} else
		[webView stringByEvaluatingJavaScriptFromString:@"photoUploadSucceeded();"];
	// think about this: [webView reload];
}



@end
