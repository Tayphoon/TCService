//
//  TCObjectSerializator.m
//  TCService
//
//  Created by Tayphoon on 28.01.13.
//  Copyright (c) 2013 Tayphoon. All rights reserved.
//
#import <RestKit/RestKit.h>

#import "TCObjectSerializator.h"

@interface NSObject(ObjectMapping)

+ (RKObjectMapping*)objectMapping;
+ (RKObjectMapping*)objectMappingForManagedObjectStore:(RKManagedObjectStore*)store;
+ (RKObjectMapping*)requestObjectMapping;

@end

@implementation TCObjectSerializator

+ (id)objectFromJSONString:(NSString*)jsonString destinationClass:(Class)destinationClass managedObjectStore:(RKManagedObjectStore *)managedObjectStore error:(NSError**)error {
    NSDictionary * objectData = [self JSONDictionaryWithString:jsonString error:error];
    if(!error) {
        return [self objectFromDictionary:objectData destinationClass:destinationClass managedObjectStore:managedObjectStore error:error];
    }
    return nil;
}

+ (id)objectFromJSONString:(NSString*)jsonString destinationClass:(Class)destinationClass error:(NSError**)error {
    return [TCObjectSerializator objectFromJSONString:jsonString destinationClass:destinationClass managedObjectStore:nil error:error];
}

+ (id)objectFromDictionary:(NSDictionary*)data destinationClass:(Class)destinationClass managedObjectStore:(RKManagedObjectStore *)managedObjectStore error:(NSError**)error {
    RKObjectMapping * objectMapping = [self objectMappingForClass:destinationClass managedObjectStore:managedObjectStore request:NO];
    
    NSDictionary * mappingsDictionary = @{ [NSString stringWithFormat:@"%@", destinationClass]: objectMapping };
    RKMapperOperation * operation = [[RKMapperOperation alloc] initWithRepresentation:data mappingsDictionary:mappingsDictionary];
    
#ifdef RKCoreDataIncluded
    if([objectMapping isKindOfClass:[RKEntityMapping class]]) {
        NSManagedObjectContext * managedObjectContext = [managedObjectStore mainQueueManagedObjectContext];
        RKManagedObjectMappingOperationDataSource *dataSource = [[RKManagedObjectMappingOperationDataSource alloc] initWithManagedObjectContext:managedObjectContext
                                                                                                                                          cache:managedObjectStore.managedObjectCache];
        operation.mappingOperationDataSource = dataSource;
    }
#endif

    [operation start];
    
    if(!operation.error) {
        return operation.mappingResult.firstObject;
    }else{
        
        if (error) {*error = operation.error;};
    }
    return nil;
}

+ (id)objectFromDictionary:(NSDictionary*)data destinationClass:(Class)destinationClass error:(NSError**)error {
    return [TCObjectSerializator objectFromDictionary:data destinationClass:destinationClass managedObjectStore:nil error:error];
}

+ (NSDictionary*)JSONDictionaryFromObject:(id)object error:(NSError**)error {    
    Class destinationClass = [object class];
    RKObjectMapping * objectMapping = [self objectMappingForClass:destinationClass request:YES];
    RKRequestDescriptor *requestDesriptor = [RKRequestDescriptor requestDescriptorWithMapping:objectMapping
                                                                                  objectClass:destinationClass
                                                                                  rootKeyPath:nil
                                                                                       method:RKRequestMethodGET];
    NSDictionary * objectDict = [RKObjectParameterization parametersWithObject:object
                                                             requestDescriptor:requestDesriptor
                                                                         error:error];
    return objectDict;
}

+ (NSString*)JSONStringFromObject:(id)object error:(NSError**)error {
    NSDictionary * objectDict = [self JSONDictionaryFromObject:object error:error];
    if (!*error) {
        return [self JSONStringWithDictionary:objectDict error:error];
    }
    return nil;
}

+ (NSDictionary*)JSONDictionaryWithString:(NSString *)jsonString error:(NSError **)error {
    NSData * data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * object = [NSJSONSerialization JSONObjectWithData:data
                                                            options:0
                                                              error:error];
    return object;
}

+ (NSString*)JSONStringWithDictionary:(NSDictionary*)jsonDict error:(NSError**)error {
    NSData * data = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                    options:0
                                                      error:error];
    if(!*error) {
        return [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (RKObjectMapping*)objectMappingForClass:(Class)destinationClass request:(BOOL)request {
    return [TCObjectSerializator objectMappingForClass:destinationClass managedObjectStore:nil request:request];
}

+ (RKObjectMapping*)objectMappingForClass:(Class)destinationClass managedObjectStore:(RKManagedObjectStore *)managedObjectStore request:(BOOL)request {
    RKObjectMapping * objectMapping = nil;

    if(!request && [destinationClass respondsToSelector:@selector(objectMapping)]) {
        objectMapping = [destinationClass objectMapping];
    }
    else if(request && [destinationClass respondsToSelector:@selector(requestObjectMapping)]) {
        objectMapping = [destinationClass requestObjectMapping];
    }
    else if(!request && [destinationClass respondsToSelector:@selector(objectMappingForManagedObjectStore:)]) {
        objectMapping = [destinationClass objectMappingForManagedObjectStore:managedObjectStore];
    }
    
    return objectMapping;
}

@end
