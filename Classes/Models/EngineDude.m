//
//  EngineDude.m
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 2/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EngineDude.h"
#import "TKHTTPURLConnection.h"
#import "trekaroo_mobileAppDelegate.h"
#import "NSString+UUID.h"
#import "NSString+URLEncoding.h"
//
//@implementation NSURLRequest (IgnoreSSL)
//
//+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
//{
//	// ignore certificate errors only for this domain
//	if ([host hasSuffix:@"trekaroo.com"])
//	{
//		return YES;
//	}
//	else
//	{
//		return NO;
//	}
//}
//
//@end

@implementation EngineDude

- (id)init {
	if ((self = [super init]) != nil) {
		_engineQueue = dispatch_queue_create("groovyQueue", NULL);
		_connections = [[NSMutableDictionary alloc] init];
	}
	return self;
}


+ (EngineDude *)engineDude {
	static EngineDude *_theDude = nil;
	if (!_theDude) _theDude = [[self alloc] init];
	return _theDude;
}

#define COMPRESSION_FACTOR 0.9

#define HTTP_POST_METHOD        @"POST"
#define BOUNDARY @"AaB03x"

//- (NSHTTPCookie *)trekarooCookie {
//	
//	//		NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:
//	//							[NSURL URLWithString:TREKAROO_MOBILE_HOST]];
//	NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//	int policy = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookieAcceptPolicy];
//	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
//	NSLog(@"%d = policy", policy);
//	
//	NSLog([cookies description]);
//	
//	return cookies.count ? [cookies objectAtIndex:0] : nil;
//	
//}

- (NSMutableData *)multiPartDataWithImageData:(NSData *)data caption:(NSString *)caption andOptions:(NSDictionary *)options {
	NSMutableData *postBody = [[NSMutableData alloc] initWithCapacity:100];
	

	NSString *ownerType = [options valueForKey:@"owner_type"];
	NSString *ownerID = [options valueForKey:@"owner_id"];
	NSString *authenticityToken = [[options valueForKey:@"authenticity_token"] URLDecodedString]; 
	
	
	
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY ] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	if (caption.length) {
		[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo[caption]\"\r\n\r\n%@\r\n", caption]
							  dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY ] dataUsingEncoding:NSUTF8StringEncoding]];
	}
	
	
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo[owner_type]\"\r\n\r\n%@\r\n", ownerType]
						  dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY ] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo[owner_id]\"\r\n\r\n%@\r\n", ownerID]
						  dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY ] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"authenticity_token\"\r\n\r\n%@\r\n", authenticityToken]
						  dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY ] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo[uploaded_data]\"; filename=\"%@.%@\"\r\n",
						   [NSString stringWithNewUUID], @"jpg"]
						  dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", @"image/jpeg"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:data];
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDARY ] dataUsingEncoding:NSUTF8StringEncoding]];
	
	return [postBody autorelease];
}

- (NSString *)uploadImageData:(NSData *)data withCaption:(NSString *)caption andOptions:(NSDictionary *)options {
	NSString *cookie = [[options valueForKey:@"cookie"] URLDecodedString]; 
	NSMutableData *multiPartData = [self multiPartDataWithImageData:data caption:caption andOptions:(NSDictionary *)options];
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/photos/create",TREKAROO_MOBILE_URL]];
	
	// Construct an NSMutableURLRequest for the URL and set appropriate request method.
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url 
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData 
                                                          timeoutInterval:30.0];
	[theRequest setHTTPMethod:HTTP_POST_METHOD];
	
	[theRequest setValue:cookie forHTTPHeaderField:@"Cookie"];
	[theRequest addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY ] forHTTPHeaderField:@"Content-Type"];

	[theRequest addValue:[NSString stringWithFormat:@"%d",[multiPartData length]] forHTTPHeaderField: @"Content-Length"];
	[theRequest setHTTPBody:multiPartData];   
	
	
	TKHTTPURLConnection *connection;
    connection = [[TKHTTPURLConnection alloc] initWithRequest:theRequest delegate:self];

    if (!connection) {
        return nil;
    } else {
        [_connections setObject:connection forKey:[connection identifier]];
        [connection release];
    }
    
    return [connection identifier];
	
	
}

- (NSString *)uploadImage:(UIImage *)image withCaption:(NSString *)caption andOptions:(NSDictionary *)options{
	_delegate = [(trekaroo_mobileAppDelegate *)[[UIApplication sharedApplication] delegate] mainViewController];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	return [self uploadImageData:UIImageJPEGRepresentation(image, COMPRESSION_FACTOR) withCaption:caption andOptions:(NSDictionary *)options];
}


#pragma mark NSURLConnection delegate methods


- (void)connection:(TKHTTPURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it has enough information to create the NSURLResponse.
    // it can be called multiple times, for example in the case of a redirect, so each time we reset the data.
    [connection resetDataLength];
    
    // Get response code.
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    int statusCode = [resp statusCode];
    
    if (statusCode >= 400) {
		//        NSLog([NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
		//		NSLog([[resp allHeaderFields] description]);
        // Assume failure, and report to delegate.
        NSError *error = [NSError errorWithDomain:@"HTTP" code:statusCode userInfo:nil];
        [_delegate requestFailed:[connection identifier] withError:error];
		
        // Destroy the connection.
        [connection cancel];
        [_connections removeObjectForKey:[connection identifier]];
        
    } else if (statusCode == 200) {
        // Not modified, or generic success.
        [_delegate requestSucceeded:[connection identifier]];
        
        // Destroy the connection.
        [connection cancel];
        [_connections removeObjectForKey:[connection identifier]];
    }
    
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

//	[_delegate responseHeadersReceived:[resp allHeaderFields]];
	
    if (1) {
        // Display headers for debugging.
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        NSLog(@"(%d) [%@]:%@", 
              [resp statusCode], 
              [NSHTTPURLResponse localizedStringForStatusCode:[resp statusCode]], 
              [resp allHeaderFields]);
    }
}


- (void)connection:(TKHTTPURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the receivedData.
    [connection appendData:data];
}


- (void)connection:(TKHTTPURLConnection *)connection didFailWithError:(NSError *)error
{
    // Inform delegate.
    [_delegate requestFailed:[connection identifier] withError:error];
    
    // Release the connection.
    [_connections removeObjectForKey:[connection identifier]];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (NSMutableDictionary *)keysAndValuePairsFromURLString:(NSString *)url {
	NSRange r = [url rangeOfString:@"?"];
	NSMutableDictionary *d = [NSMutableDictionary dictionary];
	if (r.length) {
		url = [url substringFromIndex:r.location + 1];
		NSArray *encodedParameterPairs = [url componentsSeparatedByString:@"&"];
		for (NSString *encodedPair in encodedParameterPairs) 
		{
			NSArray *encodedPairElements = [encodedPair componentsSeparatedByString:@"="];
			if (encodedPairElements.count == 2)
				[d setValue:[encodedPairElements objectAtIndex:1] forKey:[encodedPairElements objectAtIndex:0]];

		}
	}
	return d;
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
//		if ([trustedHosts containsObject:challenge.protectionSpace.host])
//			[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

 
@end
