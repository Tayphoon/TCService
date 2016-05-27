//
//  TCRequestItemsHolder.m
//  TCService
//
//  Created by Tayphoon on 06.04.15.
//  Copyright (c) 2015 Tayphoon. All rights reserved.
//
#import <RestKit/RestKit.h>

#import "TCRequestItemsHolder.h"

@interface NSObject()

+ (RKObjectMapping *)objectMapping;

+ (RKObjectMapping *)objectMappingForManagedObjectStore:(RKManagedObjectStore*)store;

@end

@implementation TCRequestItemsHolder

+ (RKMapping*)mappingForClass:(Class)class store:(RKManagedObjectStore*)store {
    RKMapping * objectMapping = ([class respondsToSelector:@selector(objectMapping)]) ? [class objectMapping] : nil;
    if(!objectMapping) {
        BOOL isEntityMapping = [class respondsToSelector:@selector(objectMappingForManagedObjectStore:)];
        objectMapping = (isEntityMapping) ? [class objectMappingForManagedObjectStore:store] : nil;
    }
    return objectMapping;
}

+ (RKObjectMapping*)requestObjectMappingForClass:(Class)itemClass
                                       toKeyPath:(NSString *)destinationKeyPath
                                           store:(RKManagedObjectStore*)store {
    RKObjectMapping * mapping = [RKObjectMapping mappingForClass:[self class]];
    RKMapping * itemObjectMapping = [self mappingForClass:itemClass store:store];
    
    RKRelationshipMapping * relation = [RKRelationshipMapping relationshipMappingFromKeyPath:destinationKeyPath
                                                                                   toKeyPath:@"items"
                                                                                 withMapping:itemObjectMapping];
    [mapping addPropertyMapping:relation];
    return [mapping inverseMapping];
}

@end
