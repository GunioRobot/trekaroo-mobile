//
//  EngineDude.h
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 2/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EngineDude : NSObject {
	dispatch_queue_t _engineQueue;
}

+ (EngineDude *)engineDude;

- (void)uploadImage:(UIImage *)image withCaption:(NSString *)caption;
@end
