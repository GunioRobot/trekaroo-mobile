//
//  CustomToolBar.m
//  trekaroo-mobile
//
//  Created by Androidicus Maximus on 4/7/11.
//  Copyright 2011 Stone Design Corp. All rights reserved.
//

#import "CustomToolBar.h"


@implementation CustomToolBar


- (void)drawRect:(CGRect)rect {
    if (!customImage)
		customImage = [[UIImage imageNamed:@"toolbar.png"] retain];
	
	[customImage drawInRect:[self bounds]];
}

- (void)dealloc {
	[customImage release];
    [super dealloc];
}


@end
