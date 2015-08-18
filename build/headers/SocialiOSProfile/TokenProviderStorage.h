//
//  TokenProviderStorage.h
//  SocialiOSProfile
//
//  Created by Banu on 18/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#import "UserProfileUtils.h"

/**
 A utility class for fetching and storing TokenProvider info locally on the device.
 */
@class TokenProvider;


@interface TokenProviderStorage : NSObject

/**
 Persists the given TokenProvider to the device storage
 
 @param tokenProvider the TokenProvider to save
 */
+ (void)setTokenProvider:(TokenProvider *)tokenProvider;

+ (void)setTokenProvider:(TokenProvider *)tokenProvider andNotify:(BOOL)notify;

/**
 Removes the given TokenProvider from the device storage
 
 @param tokenProvider the TokenProvider to remove
 */
+ (void)removeTokenProvider:(Provider)provider;

/**
 Fetches the TokenProvider stored for the given provider
 
 @param provider the provider which will be used to fetch the TokenProvider
 @return a TokenProvider
 */
+ (TokenProvider *)getTokenProvider:(Provider)provider;

@end
