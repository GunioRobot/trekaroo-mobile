//
//  MainView.m
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"


@implementation MainView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
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
	/*
	 *	if you are using QuickConnectOC within the Objective-C portion of your iPhone application
	 *	you can make the call that is commented out below.
	 */
	//[[QuickConnect getInstance] handleRequest:cmd withParameters:paramsToPass];
	/*
	 *	if you are not using QuickConnectOC you will need to use conditional statements like if-then-else or case statements
	 *	like the example below. You would then use the other parameters passed with the command to make decistions and
	 *	execute code.
	 */
	if([cmd compare:@"getLocation"] == NSOrderedSame){
		[locationManager startUpdatingLocation];
	}
	else if([cmd compare:@"logMessage"] == NSOrderedSame){
		//NSString *message = [[paramsToPass objectAtIndex:0] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
		NSString *message = [[paramsToPass objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"JSMessage: %@",message);
	}
	/*
	 *	Only load the page if it is the initial index.html file
	 */
	NSRange aSubStringRange = [url rangeOfString:@"index.html"];
	if(aSubStringRange.length != 0){
		return YES;
	}
	else{
		return NO;
	}
}

@end
