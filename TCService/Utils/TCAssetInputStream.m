//
//  TCAssetInputStream.m
//  TCService
//
//  Created by Tayphoon on 08.12.14.
//  Copyright (c) 2014 Tayphoon. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import "TCAssetInputStream.h"

@interface TCAssetInputStream() {
    ALAssetsLibrary *_library;
    ALAssetRepresentation * _assetRepresentation;
    NSUInteger _readIndex;
}

@property (nonatomic, assign) NSStreamStatus streamStatus;
@property (nonatomic, strong) NSError * streamError;


@end

@implementation TCAssetInputStream

@synthesize streamStatus = _streamStatus;
@synthesize streamError = _streamError;

- (id)initWithAssetURL:(NSURL *)assetURL representationUTI:(NSString *)UTI {
    if ((self = [super init])) {
        _assetURL = assetURL;
        _representationUTI = UTI;
    }
    return self;
}

- (id)initWithAsset:(ALAsset *)asset {
    if ((self = [super init])) {
        _assetRepresentation = asset.defaultRepresentation;
        _representationUTI = asset.defaultRepresentation.UTI;
    }
    return self;
}


- (void)open {
    self.streamStatus = NSStreamStatusOpening;
    
    if(!_assetRepresentation) {
        dispatch_semaphore_t flag = dispatch_semaphore_create(0);
        _library = [ALAssetsLibrary new];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_library assetForURL:self.assetURL resultBlock:^(ALAsset *asset) {
                _assetRepresentation = self.representationUTI ? [asset representationForUTI:self.representationUTI] : asset.defaultRepresentation;
                self.streamStatus = NSStreamStatusOpen;
                dispatch_semaphore_signal(flag);
            } failureBlock:^(NSError *error) {
                self.streamStatus = NSStreamStatusError;
                self.streamError = error;
                dispatch_semaphore_signal(flag);
            }];
        });
        dispatch_semaphore_wait(flag, DISPATCH_TIME_FOREVER);
    }
    else {
        self.streamStatus = NSStreamStatusOpen;
    }
}

- (void)close {
    _library = nil;
    _assetRepresentation = nil;
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)length {
    NSError *error;
    NSUInteger read = [_assetRepresentation getBytes:buffer fromOffset:_readIndex length:length error:&error];
    if (read == 0) {
        self.streamError = error;
        self.streamStatus = error ? NSStreamStatusError : NSStreamStatusAtEnd;
    }
    _readIndex += read;
    return read;
}

- (BOOL)getBuffer:(uint8_t **)buffer length:(NSUInteger *)length {
    return NO;
}

- (BOOL)hasBytesAvailable {
    return _readIndex < (NSUInteger)_assetRepresentation.size;
}

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode {}

- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode {}

- (id)propertyForKey:(NSString *)key {
    return nil;
}

- (BOOL)setProperty:(id)property forKey:(NSString *)key {
    return NO;
}

@end
