//
//  TCResponse.h
//  TCService
//
//  Created by Tayphoon on 13.11.14.
//  Copyright (c) 2014 Tayphoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TCResponse <NSObject>

@property (nonatomic, strong) id returnedValue;
@property (nonatomic, strong) NSNumber * statusCode;
@property (nonatomic, strong) NSString * statusMessage;
@property (nonatomic, strong) NSString * errorMessage;

@end
