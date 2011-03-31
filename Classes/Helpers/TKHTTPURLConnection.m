
#import "TKHTTPURLConnection.h"
#import "NSString+UUID.h"


@implementation TKHTTPURLConnection


#pragma mark Initializer


- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate 
{
    if (self = [super initWithRequest:request delegate:delegate]) {
        _data = [[NSMutableData alloc] initWithCapacity:0];
        _identifier = [[NSString stringWithNewUUID] retain];
		_URL = [[request URL] retain];
    }
    
    return self;
}


- (void)dealloc
{
	[_URL release];
    [_data release];
    [_identifier release];
    [super dealloc];
}


#pragma mark Data helper methods


- (void)resetDataLength
{
    [_data setLength:0];
}


- (void)appendData:(NSData *)data
{
    [_data appendData:data];
}


#pragma mark Accessors


- (NSString *)identifier
{
    return [[_identifier retain] autorelease];
}


- (NSData *)data
{
    return [[_data retain] autorelease];
}

- (NSURL *)URL
{
    return [[_URL retain] autorelease];
}


@end
