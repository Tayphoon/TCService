//
//  TCService.h
//  TCService
//
//  Created by Tayphoon on 13.11.14.
//  Copyright (c) 2014 Tayphoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCResponse.h"

#ifdef _SYSTEMCONFIGURATION_H
typedef enum {
    TCServiceReachabilityStatusUnknown          = -1,
    TCServicekReachabilityStatusNotReachable    = 0,
    TCServiceReachabilityStatusReachableViaWWAN = 1,
    TCServiceReachabilityStatusReachableViaWiFi = 2,
} TCServiceReachabilityStatus;

typedef void (^TCServiceReachabilityStatusBlock)(TCServiceReachabilityStatus status);
#endif

#define NSStringNullForNil(value) ([value length]) ? value : [NSNull null]
#define NSObjectNullForNil(value) (value) ? value : [NSNull null]

extern NSString * const TCServiceErrorDomain;
extern NSString * const TCHttpStatusCodeKey;

typedef void(^RequestCompletionHandler)(BOOL success, NSData * responseData, NSError * error);
typedef void(^ObjectRequestCompletionHandler)(BOOL success, id object, NSData * responseData, NSError * error);

@class RKObjectManager;

@interface TCService : NSObject

@property (nonatomic, strong) id session;
@property (nonatomic, readonly) RKObjectManager * objectManager;
@property (nonatomic, strong) Class<TCResponse> responseClass;
@property (nonatomic, readonly) NSString * storeFileName;
@property (nonatomic, readonly) NSString * serviceUrl;

#ifdef RKCoreDataIncluded
@property (nonatomic, readonly) NSManagedObjectContext * context;
#endif

#ifdef _SYSTEMCONFIGURATION_H
@property (readonly, nonatomic, assign) TCServiceReachabilityStatus serviceReachabilityStatus;
#endif

+ (instancetype)sharedService;

+ (void)setSharedService:(id)service;

+ (instancetype)serviceWithURL:(NSString *)url;

+ (instancetype)serviceWithURL:(NSString *)url andSession:(id)session;

- (id)initWithURL:(NSString *)url;

- (id)initWithURL:(NSString *)url andSession:(id)session __attribute((objc_requires_super));

#ifdef _SYSTEMCONFIGURATION_H
- (void)setReachabilityStatusChangeBlock:(void (^)(TCServiceReachabilityStatus status))block;

- (BOOL)isServiceReachable;
#endif

@end
