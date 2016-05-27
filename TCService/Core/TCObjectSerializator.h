//
//  TCObjectSerializator.h
//  TCService
//
//  Created by Tayphoon on 28.01.13.
//  Copyright (c) 2013 Tayphoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKManagedObjectStore;

@interface TCObjectSerializator : NSObject

+ (id)objectFromJSONString:(NSString*)jsonString destinationClass:(Class)destinationClass error:(NSError**)error;

+ (id)objectFromDictionary:(NSDictionary*)data destinationClass:(Class)destinationClass error:(NSError**)error;

+ (NSDictionary*)JSONDictionaryFromObject:(id)object error:(NSError**)error;

+ (NSString*)JSONStringFromObject:(id)object error:(NSError**)error;

+ (NSString*)JSONStringWithDictionary:(NSDictionary*)jsonDict error:(NSError**)error;

+ (NSDictionary*)JSONDictionaryWithString:(NSString *)jsonString error:(NSError **)error;

#ifdef RKCoreDataIncluded

+ (id)objectFromDictionary:(NSDictionary*)data destinationClass:(Class)destinationClass managedObjectStore:(RKManagedObjectStore *)managedObjectStore error:(NSError**)error;

+ (id)objectFromJSONString:(NSString*)jsonString destinationClass:(Class)destinationClass managedObjectStore:(RKManagedObjectStore *)managedObjectStore error:(NSError**)error;

#endif

@end
