//
//  EngineDude.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 2/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
@interface NSURLRequest (IgnoreSSL)
@end

@interface EngineDude : NSObject {
	dispatch_queue_t _engineQueue;
	NSMutableDictionary *_connections;
	MainViewController * _delegate;
}

+ (EngineDude *)engineDude;

- (NSString *)uploadImage:(UIImage *)image withCaption:(NSString *)caption andOptions:(NSDictionary *)options;
- (NSMutableDictionary *)keysAndValuePairsFromURLString:(NSString *)url;

@end

#warning For Production, simply comment out this next IS_STAGING AND IS_DEV
#define IS_STAGING 1
//#define IS_DEV 1

#define DEV_URL @"http://localhost:3000/mobile"
#define DEV_HOST @"http://localhost:3000"
#define DEV_INDEX_FILE @"index_developer.html"

#define STAGING_URL @"http://stg2.trekaroo.com/mobile"
#define STAGING_HOST @"http://stg2.trekaroo.com"
#define STAGING_INDEX_FILE @"index_staging.html"

#define PRODUCTION_MOBILE_URL @"http://trekaroo.com/mobile"
#define PRODUCTION_HOST @"http://trekaroo.com"
#define PRODUCTION_INDEX_FILE @"index_production.html"

#ifdef IS_DEV
#define TREKAROO_MOBILE_URL DEV_URL
#define TREKAROO_MOBILE_HOST DEV_HOST
#define TREKAROO_INDEX_FILE DEV_INDEX_FILE
#else
#ifdef IS_STAGING
#define TREKAROO_MOBILE_URL STAGING_URL
#define TREKAROO_MOBILE_HOST STAGING_HOST
#define TREKAROO_INDEX_FILE STAGING_INDEX_FILE
#else
#define TREKAROO_MOBILE_URL PRODUCTION_MOBILE_URL 
#define TREKAROO_MOBILE_HOST PRODUCTION_HOST 
#define TREKAROO_INDEX_FILE PRODUCTION_INDEX_FILE
#endif
#endif