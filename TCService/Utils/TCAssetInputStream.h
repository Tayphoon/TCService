//
//  TCAssetInputStream.h
//  TCService
//
//  Created by Tayphoon on 08.12.14.
//  Copyright (c) 2014 Tayphoon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * An ALAssetInputStream streams a representation of an ALAsset.
 */

@interface TCAssetInputStream : NSInputStream

/**
 * Designated initializer.
 *
 * @param assetURL A URL representing an asset in the Assets Library.
 * @param UTI      The UTI of the representation to stream, or nil to use the default representation.
 */
- (id)initWithAssetURL:(NSURL *)assetURL representationUTI:(NSString *)UTI;

/**
 * Designated initializer.
 *
 * @param asset A item representing an asset in the Assets Library.
 */
- (id)initWithAsset:(ALAsset *)asset;

@property (readonly, strong, nonatomic) NSURL *assetURL;

@property (readonly, copy, nonatomic) NSString *representationUTI;

@end
