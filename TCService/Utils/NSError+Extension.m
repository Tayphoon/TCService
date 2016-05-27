//
//  NSError+Extension.m
//  TCService
//
//  Created by Tayphoon on 15.09.14.
//  Copyright (c) 2014 Tayphoon. All rights reserved.
//

#import "NSError+Extension.h"

@implementation NSError (Extension)

- (NSError*)errorWithUnderlyingError:(NSError*)underlyingError {
    if (!underlyingError || self.userInfo[NSUnderlyingErrorKey]) {
        return self;
    }
    
    NSMutableDictionary *mutableUserInfo = [self.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:self.domain code:self.code userInfo:[mutableUserInfo copy]];
}

- (NSError*)errorByAddaingUserInfo:(NSDictionary*)userInfo {
    NSMutableDictionary * info = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
    [info addEntriesFromDictionary:userInfo];
    
    return [[NSError alloc] initWithDomain:self.domain code:self.code userInfo:[info copy]];
}

@end
