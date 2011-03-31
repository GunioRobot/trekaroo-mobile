//
//  NSString+UUID.m
//  MGTwitterEngine
//
//  Created by Matt Gemmell on 16/09/2007.
//  Copyright 2007 Magic Aubergine.
//

#import "NSString+UUID.h"


@implementation NSString (UUID)


+ (NSString*)stringWithNewUUID
{
    // Create a new UUID
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    
    // Get the string representation of the UUID
    NSString *newUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [newUUID autorelease];
}

- (unsigned int)unsignedIntValue {
	if (self.length == 0) return 0;
	else {
		unsigned int value;
		if (sscanf([self UTF8String], "%u", &value) == 1) return value;
		return 0;
	}
}
- (unsigned long)unsignedLongValue {
	if (self.length == 0) return 0;
	else {
		unsigned long value;
		if (sscanf([self UTF8String], "%lu", &value) == 1) return value;
		return 0;
	}
}

- (unsigned long long)unsignedLongLongValue {
	if (self.length == 0) return 0;
	else {
		const char *instr = [self UTF8String];
		unsigned long long retval = 0;
		if (sscanf(instr, "%llu", &retval) == 1) return retval;
		return 0;
	}
}


@end
