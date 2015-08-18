//
//  TokenProviderNotFoundException.m
//  SocialiOSProfile
//
//  Created by Banu on 18/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#import "TokenProviderNotFoundException.h"

@implementation TokenProviderNotFoundException

- (id) init {
    self = [super initWithName:@"TokenProviderNotFoundException" reason:@"Couldn't find a TokenProvider for the given Provider" userInfo:nil];
    return self;
}

@end
