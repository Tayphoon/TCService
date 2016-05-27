//
//  TCRequestItemsHolder.h
//  TCService
//
//  Created by Tayphoon on 06.04.15.
//  Copyright (c) 2015 Tayphoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;
@class RKManagedObjectStore;

@interface TCRequestItemsHolder : NSObject

@property (nonatomic, strong) NSArray * items;

+ (RKObjectMapping*)requestObjectMappingForClass:(Class)itemClass
                                       toKeyPath:(NSString *)destinationKeyPath
                                           store:(RKManagedObjectStore*)store;

@end
