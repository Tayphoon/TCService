//
//  TCService+Subclass.h
//  TCService
//
//  Created by Tayphoon on 13.11.14.
//  Copyright (c) 2014 Tayphoon. All rights reserved.
//

#import "TCService.h"
#import "TCRequestItemsHolder.h"

@class RKObjectRequestOperation;
@class ALAsset;

@interface TCService(Subclass)

- (void)getObjectsAtPath:(NSString *)path
              parameters:(NSDictionary *)parameters
                 handler:(ObjectRequestCompletionHandler)handler;

- (void)getObjectsAtPath:(NSString *)path
              parameters:(NSDictionary *)parameters
              fetchBlock:(NSFetchRequest *(^)(NSURL *URL))fetchBlock
                 handler:(ObjectRequestCompletionHandler)handler;

- (void)deleteObject:(id)object
                path:(NSString *)path
          parameters:(NSDictionary *)parameters
             handler:(ObjectRequestCompletionHandler)handler;

- (void)deleteObject:(id)object
                path:(NSString *)path
          parameters:(NSDictionary *)parameters
          fetchBlock:(NSFetchRequest *(^)(NSURL *URL))fetchBlock
             handler:(ObjectRequestCompletionHandler)handler;

- (void)putObject:(id)object
             path:(NSString *)path
       parameters:(NSDictionary *)parameters
          handler:(ObjectRequestCompletionHandler)handler;

- (void)putObject:(id)object
             path:(NSString *)path
       parameters:(NSDictionary *)parameters
       fetchBlock:(NSFetchRequest *(^)(NSURL *URL))fetchBlock
          handler:(ObjectRequestCompletionHandler)handler;

- (void)postObject:(id)object
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
           handler:(ObjectRequestCompletionHandler)handler;

- (void)postObject:(id)object
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
        fetchBlock:(NSFetchRequest *(^)(NSURL *URL))fetchBlock
           handler:(ObjectRequestCompletionHandler)handler;

- (void)postObjects:(NSArray*)objects path:(NSString *)path handler:(ObjectRequestCompletionHandler)handler;

- (void)postData:(NSData*)data path:(NSString *)path handler:(ObjectRequestCompletionHandler)handler;

- (void)postData:(NSData*)fileData
            path:(NSString *)path
      parameters:(NSDictionary *)parameters
fileAttributeName:(NSString*)fileAttributeName
        fileName:(NSString*)fileName
        mimeType:(NSString*)mimeType
         handler:(ObjectRequestCompletionHandler)handler;

- (void)postAsset:(ALAsset*)asset
             path:(NSString *)path
       parameters:(NSDictionary *)parameters
fileAttributeName:(NSString*)fileAttributeName
         fileName:(NSString*)fileName
         mimeType:(NSString*)mimeType
          handler:(ObjectRequestCompletionHandler)handler;

- (void)postFileAtPath:(NSURL*)filePath
                  path:(NSString*)path
            parameters:(NSDictionary*)parameters
     fileAttributeName:(NSString*)fileAttributeName
              fileName:(NSString*)fileName
              mimeType:(NSString*)mimeType
               handler:(ObjectRequestCompletionHandler)handler;

- (void)initDescriptors;

- (void)processAuthorizationForOperation:(RKObjectRequestOperation*)operation;

- (void)processError:(NSError*)error
            response:(id<TCResponse>)response
        forOperation:(RKObjectRequestOperation*)operation
             handler:(ObjectRequestCompletionHandler)handler;

- (NSError*)makeErrorWithDescription:(NSString*)errorDescription code:(NSInteger)code;

@end
