//
//  NSError+Extension.h
//  TCService
//
//  Created by Tayphoon on 15.09.14.
//  Copyright (c) 2014 Tayphoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Extension)

- (NSError*)errorWithUnderlyingError:(NSError*)underlyingError;
- (NSError*)errorByAddaingUserInfo:(NSDictionary*)userInfo;

@end
