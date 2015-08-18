//
//  AccessTokenStorage.h
//  SocialiOSProfile
//
//  Created by Banu on 18/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#import "UserProfileUtils.h"

@interface AccessTokenStorage : NSObject

/**
* Persists the given access token to the device storage, and adds the
* ability to suppress related events
*
* @param accessToken the access token to save
* @param notify should an event regarding the save be fired
*/
+ (void)setAccessToken:(Provider)provider andAccessToken:(NSString*)accessToken;

+ (void)setAccessToken:(Provider)provider andAccessToken:(NSString*)accessToken andNotify:(BOOL)notify;


/**
 * Removes the access token for the given provider from the device storage
 *
 * @param provider the provider whose access token you wish to remove from the device storage
 */
+ (void)removeAccessToken:(Provider)provider;

/**
 * Fetches the access token stored for the given provider
 *
 * @param provider the provider which will be used to fetch the access token
 * @return an access token
 */
+ (NSString *)getAccessToken:(Provider)provider;

@end
