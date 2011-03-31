
#import <Foundation/Foundation.h>

@interface TKHTTPURLConnection : NSURLConnection {
    NSMutableData *_data;                   // accumulated data received on this connection
    NSString *_identifier;
	NSURL *_URL;							// the URL used for the connection (needed as a base URL when parsing with libxml)
}

// Initializer
- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate;

// Data helper methods
- (void)resetDataLength;
- (void)appendData:(NSData *)data;

// Accessors
- (NSString *)identifier;
- (NSData *)data;
- (NSURL *)URL;

@end
