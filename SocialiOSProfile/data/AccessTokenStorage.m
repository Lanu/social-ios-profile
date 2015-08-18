//
//  AccessTokenStorage.m
//  SocialiOSProfile
//
//  Created by Banu on 18/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#import "AccessTokenStorage.h"
#import "ProfileEventHandling.h"
#import "KeyValueStorage.h"
#import "SocialUtils.h"

@implementation AccessTokenStorage

static NSString* DB_KEY_PREFIX  = @"social.profile.";
static NSString* TAG            = @"SOCIAL AccessTokenStorage";


+ (void)setAccessToken:(Provider)provider andAccessToken:(NSString*)accessToken{
    [self setAccessToken:provider andAccessToken:accessToken andNotify:YES];
}

+ (void)setAccessToken:(Provider)provider andAccessToken:(NSString *)accessToken andNotify:(BOOL)notify {

    NSString* key = [self keyAccessToken:provider];
    [KeyValueStorage setValue:accessToken forKey:key];
    if (notify) {
        [ProfileEventHandling postAccessTokenUpdated:provider andAccessToken:accessToken];
    }
}

+ (void)removeAccessToken:(Provider)provider {
    NSString* key = [self keyAccessToken:provider];
    [KeyValueStorage deleteValueForKey:key];
}

+ (NSString *)getAccessToken:(Provider)provider {
    
    NSString* key = [self keyAccessToken:provider];
    NSString* accessToken = [KeyValueStorage getValueForKey:key];
    if (!accessToken || [accessToken length] == 0) {
        return nil;
    }

    return accessToken;
}

+ (NSString *)keyAccessToken:(Provider)provider {
    return [NSString stringWithFormat:@"%@access_token.%@", DB_KEY_PREFIX, [UserProfileUtils providerEnumToString:provider]];
}

@end
