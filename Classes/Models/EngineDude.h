//
//  EngineDude.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 2/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"

@interface EngineDude : NSObject {
	dispatch_queue_t _engineQueue;
	NSMutableDictionary *_connections;
	MainViewController * _delegate;
}

+ (EngineDude *)engineDude;

- (NSString *)uploadImage:(UIImage *)image withCaption:(NSString *)caption andOptions:(NSDictionary *)options;
- (NSMutableDictionary *)keysAndValuePairsFromURLString:(NSString *)url;

@end

#warning For Production, simply comment out this next IS_STAGING 
#define IS_STAGING 1

#define STAGING_URL @"http://stg2.trekaroo.com/mobile"
#define STAGING_HOST @"http://stg2.trekaroo.com"

#define PRODUCTION_MOBILE_URL @"http://trekaroo.com/mobile"
#define PRODUCTION_HOST @"http://trekaroo.com"


#ifdef IS_STAGING
#define TREKAROO_MOBILE_URL STAGING_URL
#define TREKAROO_MOBILE_HOST STAGING_HOST
#else
#define TREKAROO_MOBILE_URL PRODUCTION_MOBILE_URL 
#define TREKAROO_MOBILE_HOST PRODUCTION_HOST 
#endif
