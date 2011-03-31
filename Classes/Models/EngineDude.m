//
//  EngineDude.m
//  trekaroo-mobile
//
//  Created by Michael Deitcher on 2/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EngineDude.h"


@implementation EngineDude

- (id)init {
	if ((self = [super init]) != nil) {
		_engineQueue = dispatch_queue_create("groovyQueue", NULL);
	}
	return self;
}


+ (EngineDude *)engineDude {
	static EngineDude *_theDude = nil;
	if (!_theDude) _theDude = [[self alloc] init];
	return _theDude;
}

- (void)uploadImage:(UIImage *)image withCaption:(NSString *)caption {
	
}


@end
