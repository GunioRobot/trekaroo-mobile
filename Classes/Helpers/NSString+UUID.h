//
//  NSString+UUID.h
//  MGTwitterEngine
//
//  Created by Matt Gemmell on 16/09/2007.
//  Copyright 2007 Magic Aubergine.
//

#import <Foundation/Foundation.h>


@interface NSString (UUID)

+ (NSString*)stringWithNewUUID;
- (unsigned long)unsignedLongValue;
- (unsigned long long)unsignedLongLongValue;

@end
